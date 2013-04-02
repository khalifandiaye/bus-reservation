/*  function setValue(depart, arrive, fare, status){
 var obj = { departureTime: depart,
 arrivalTime: arrive,
 busStatus: status,
 fare: fare};
 var myString = JSON.stringify(obj);
 $("#tripData").val(myString);
 } */

//notification message on error cases.
function showPopup(message) {
    if ($(".notify-message").html().trim() != "") {
        $(".notify-message").empty();
    }
    $(".notify-message")
            .append(
                    '<div class="alert fade in"><button type="button" class="close" data-dismiss="alert">×</button>'
                            + message + '</div>');
}

// document ready
$(document).ready(function() {
    // switch on after map initialization has been called
    var mapInit = false;
    $('div.map-slider').hide();
    var rtnFlg = $('#rtnFlg').val();
    var outFlg = $('#outFlg').val();

    // disable submit button if there're no trips
    if (rtnFlg == '' && outFlg == '') {
        $('#confirm-submit').attr("disabled", "disabled");
        $('#confirm-submit').removeClass('btn-primary');
    } else {
        $('#confirm-submit').removeAttr("disabled");
        $('#confirm-submit').addClass('btn-primary');
    }
    ;

    // onclick submit button
    $("#confirm-submit").bind("click", function() {
        var outRadio = $('form input[name="out_journey"]:checked');
        var rtnRadio = $('form input[name="rtn_journey"]:checked');

        if (rtnRadio.size != 0) {

            var depart = $(rtnRadio).siblings(
                    '.rtn_deptTime').val();
            var arrive = $(outRadio).siblings(
                    '.out_arrTime').val();

            // cannot arrive before depart
            if (depart <= arrive) {
                if ($(".notify-message").html()
                        .trim() != "") {
                    $(".notify-message")
                            .empty();
                }
                $(".notify-message")
                        .append(
                                '<div class="alert fade in">'
                                        + '<button type="button" class="close" data-dismiss="alert">×</button>'
                                        + 'Vui lòng chọn chuyến về có thời gian khởi hành sau khi chuyến đi kết thúc.'
                                        + '</div>');
                return;
            }

            // set parameter for return journey
            $('input[name="rtnBusStatus"]')
                    .val(
                            $(rtnRadio)
                                    .siblings(
                                            '.rtn_status')
                                    .val());
            $('input[name="rtnDepartTime"]')
                    .val(
                            $(rtnRadio)
                                    .siblings(
                                            '.rtn_deptTime')
                                    .val());
            $('input[name="rtnArriveTime"]')
                    .val(
                            $(rtnRadio)
                                    .siblings(
                                            '.rtn_arrTime')
                                    .val());
            $('input[name="rtnFare"]').val(
                    $(rtnRadio).siblings(
                            '.rtn_fare').val());
        }
        // set parameter for onward journey
        $('input[name="outBusStatus"]').val(
                $(outRadio).siblings(
                        '.out_status').val());
        $('input[name="outDepartTime"]').val(
                $(outRadio).siblings(
                        '.out_deptTime').val());
        $('input[name="outArriveTime"]').val(
                $(outRadio).siblings(
                        '.out_arrTime').val());
        $('input[name="outFare"]').val(
                $(outRadio).siblings(
                        '.out_fare').val());

        $('form').submit();
    });

    // view trip details
    $('.trip-details').bind('click', function() {
        /*
         * var className =
         * $(this).attr('class').split(' ')[1];
         * //set param for onward journey
         * if(className == 'onward') { var
         * busStatus =
         * $(this).parent("td").next().next().next().find(
         * '.out_status').val(); var departTime =
         * $(this).parent("td").next().next().next().find(
         * '.out_deptTime').val(); var
         * arriveTime =
         * $(this).parent("td").next().next().next().find(
         * '.out_arrTime').val(); } else { //for
         * return journey var busStatus =
         * $(this).parent("td").next().next().next().find(
         * '.rtn_status').val(); var departTime =
         * $(this).parent("td").next().next().next().find(
         * '.rtn_deptTime').val(); var
         * arriveTime =
         * $(this).parent("td").next().next().next().find(
         * '.rtn_arrTime').val(); }
         */
        var param = new Object();
        getParameter($(this), param);

        // call ajax
        $.ajax({
            type : "GET",
            url : $('#contextPath').val() + "/search/getTripDetails.html",
            data : {
                busStatus : param.busStatus,
                departTime : param.departTime,
                arriveTime : param.arriveTime
            },
            success : function(data) {
                // set data to screen
                // console.log(data.tripList);
                $('#trips-list tbody')
                        .empty();
                $('#trips-list tbody')
                        .append(
                                '<tr class="row">'
                                        + '<th class="head">Giờ khởi hành</th>'
                                        + '<th class="head">Giờ dừng nghỉ</th>'
                                        + '<th class="head">Trạm khởi hành</th>'
                                        + '<th class="head">Trạm dừng nghỉ</th>'
                                        + '</tr>');
                var loop = data.tripList;
                for ( var i = 0; i < loop.length; i++) {
                    $('#trips-list tbody')
                            .append(
                                    '<tr class="row">'
                                            + '<td class="cell">'
                                            + loop[i]['deptDate']
                                            + '<br/>'
                                            + loop[i]['deptTime']
                                            + '</td>'
                                            + '<td class="cell">'
                                            + loop[i]['arrDate']
                                            + '<br/>'
                                            + loop[i]['arrTime']
                                            + '</td>'
                                            + '<td class="cell">'
                                            + loop[i]['deptCity']
                                            + '<br/>'
                                            + loop[i]['deptStat']
                                            + '</td>'
                                            + '<td class="cell">'
                                            + loop[i]['arrCity']
                                            + '<br/>'
                                            + loop[i]['arrStat']
                                            + '</td>'
                                            + '</tr>');
                }
            }
        });
    });

    // get parameter for showing trip details
    function getParameter($source, param) {
        console.log($source);
        var className = $source.attr('class').split(' ')[1];
        // set param for onward journey
        if (className == 'onward') {
            param.busStatus = $source.parent("td").next()
                    .next().next().find('.out_status').val();
            param.departTime = $source.parent("td").next()
                    .next().next().find('.out_deptTime').val();
            param.arriveTime = $source.parent("td").next()
                    .next().next().find('.out_arrTime').val();
            console.log(param);
        } else {
            // for return journey
            param.busStatus = $source.parent("td").next()
                    .next().next().find('.rtn_status').val();
            param.departTime = $source.parent("td").next()
                    .next().next().find('.rtn_deptTime').val();
            param.arriveTime = $source.parent("td").next()
                    .next().next().find('.rtn_arrTime').val();
        }
    }

    var $unique = $('input.chb-out');
    var $uniqueRet = $('input.chb-ret');

//    $('tr.tripDetails.row').click(function(event) {
//        if (event.target.type !== 'checkbox'
//                && event.target.nodeName !== 'A') {
//            $(':checkbox', this).trigger('click');
//        }
//    });

    $('form').on('click.map', '.map-active', function() {
        $('div.map-slider').show();
        var routeId = $(this).parent().parent().find('input[type="checkbox"]:checked').first().siblings('#routeId').val();
        if (!mapInit) {
            // create and display a map
            $('#map').customGMap('initialize', {
                hideMapLabels : true,
                showAdministrativeLabel : true,
                enableRoute : true
            });
            mapInit = true;
            loadAndShowRoute(routeId ,true);
        } else {
            loadAndShowRoute(routeId ,true);
        }
        $(this).removeClass('map-active');
        $(this).addClass('map-inactive');
        if ($(this).hasClass('onward')) {
            $(this).attr('title', 'Ẩn bản đồ của chuyến đi');
            $('div.map-slider').css('float', 'right');
//            $('div.map-slider')[0].style.styleFloat = 'right';
//            $('div.map-slider')[0].style.cssFloat = 'right';
//            $('span.map-inactive.onward').show();
            $('div.return-info').hide();
//            $('#map').customGMap('hideRoute');
//            $('#map').customGMap('showRoute', 1);
        } else {
            $(this).attr('title', 'Ẩn bản đồ của chuyến về');
            $('div.map-slider').css('float', 'left');
//            $('span.map-inactive.return').show();
            $('div.onward-info').hide();
//            $('#map').customGMap('hideRoute');
//            $('#map').customGMap('showRoute', 2);
        }
    });
    $('form').on('click.map', '.map-inactive', function() {
        $('div.map-slider').hide();
        $(this).removeClass('map-inactive');
        $(this).addClass('map-active');
        if ($(this).hasClass('onward')) {
            $(this).attr('title', 'Hiện bản đồ của chuyến đi');
//            $('div.map-slider').css('float', 'right');
//            $('div.map-slider')[0].style.styleFloat = 'right';
//            $('div.map-slider')[0].style.cssFloat = 'right';
//            $('span.map-inactive.onward').show();
            $('div.return-info').show();
//            $('#map').customGMap('hideRoute');
//            $('#map').customGMap('showRoute', 1);
        } else {
            $(this).attr('title', 'Hiện bản đồ của chuyến về');
//            $('div.map-slider').css('float', 'left');
//            $('span.map-inactive.return').show();
            $('div.onward-info').show();
//            $('#map').customGMap('hideRoute');
//            $('#map').customGMap('showRoute', 2);
        }
    });
    $('.result-table').on('click.select', 'tbody tr', function(e) {
        var siblingCheckBoxes = $('input[type="checkbox"][name="' + $(this).find('input[type="checkbox"]').attr('name') +'"]');
        var checked = $(this).find('input[type="checkbox"]').prop('checked');
        // inverse status when the checkbox itself is clicked
        if ($(e.target).is('input[type="checkbox"]')) {
            checked = !checked;
        }
        // uncheck all trips with the same name as the children checkbox
        siblingCheckBoxes.prop('checked', false);
        siblingCheckBoxes.parents('tr').removeClass('choose');
//        console.log($(this).parents('.result-table').hide());
        if (checked) {
            $(this).find('input[type="checkbox"]').prop('checked', false);
            $(this).removeClass('choose');
            // hide all other routes
            $('#map').customGMap('hideRoute');
        } else {
            $(this).find('input[type="checkbox"]').prop('checked', true);
            $(this).addClass('choose');
            if (mapInit) {
                var routeId = $(this).find('#routeId').val();
                loadAndShowRoute(routeId, true);
            }
        }
        checkChecked002();
    });
    
    function loadAndShowRoute(routeId, show) {
        if (mapInit && routeId) {
            if (!$('#map').customGMap('isRouteExist', routeId)) {
                var td = $('#routeId[value="' + routeId + '"]').parents('td');
                var param = null;
                var onward = td.hasClass('out-journey-rdo');
                console.log(td);
                // set param for onward journey
                if (onward) {
                    param = {
                        busStatus : td.find('.out_status').val(),
                        departTime : td.find('.out_deptTime').val(),
                        arriveTime : td.find('.out_arrTime').val(),
                    };
                } else {
                    // for return journey
                    param = {
                            busStatus : td.find('.rtn_status').val(),
                            departTime : td.find('.rtn_deptTime').val(),
                            arriveTime : td.find('.rtn_arrTime').val(),
                    };
                }
                console.log(param);
                // call ajax
                $.ajax({
                    type : "GET",
                    url : $('#contextPath').val()
                            + "/search/getRouteLatitude.html",
                    data : param,
                    success : function(data) {
                        var waypoints = new Array();
                        console.log(data.latitudeList);
                        $.each(data.latitudeList, function(key, value) {
                            waypoints.push({
                                latitude : value.latitude,
                                longitude : value.longitude
                            });
                        });
                        $('#map').customGMap('addRoute', {
                            routeId : routeId,
                            waypoints : waypoints
                        });
                        // hide all other routes
                        $('#map').customGMap('hideRoute');
                        // show route
                        $('#map').customGMap('showRoute', routeId);
                    }
                });
            } else {
                // hide all other routes
                $('#map').customGMap('hideRoute');
                // show route
                $('#map').customGMap('showRoute', routeId);
            }
        }
    }
//    $('span.map-active').click(function() {
//
//    });
//    $('span.map-inactive').click(function() {
//        $('div.map-slider').hide();
//        $(this).hide();
//        if ($(this).attr('class').split(' ')[1] == 'onward') {
//            $('div.map-slider')[0].style.styleFloat = 'left';
//            $('div.map-slider')[0].style.cssFloat = 'left';
//            $('span.map-active.onward').show();
//            $('div.return-info').show();
//        } else {
//            $('span.map-active.return').show();
//            $('div.onward-info').show();
//        }
//    });

    // make checkbox act like radio
//    $unique.click(function() {
//        $unique.filter(':checked').not(this).removeAttr(
//                'checked');
//        $('.result-table.onward tr.tripDetails').removeClass(
//                'choose');
//        if ($(this).is(':checked')) {
//            $(this).closest('tr').addClass('choose');
//            getLatitudeList($(this));
//        }
//        checkChecked001();
//    });
//
//    $uniqueRet.click(function() {
//        $uniqueRet.filter(':checked').not(this).removeAttr(
//                'checked');
//        $('.result-table.return tr.tripDetails').removeClass(
//                'choose');
//        if ($(this).is(':checked')) {
//            $(this).closest('tr').addClass('choose');
//            getLatitudeList($(this));
//        }
//        checkChecked001();
//    });

    // check if at least one journey (onward or return) is
    // checked
    function checkChecked001() {
        if ($unique.filter(':checked').size() == 0
                && $uniqueRet.filter(':checked').size() == 0) {
            $('#confirm-submit').attr("disabled", "disabled");
            $('#confirm-submit').removeClass('btn-primary');
        } else {
            $('#confirm-submit').removeAttr("disabled");
            $('#confirm-submit').addClass('btn-primary');
        }
    }
    function checkChecked002() {
        if ($('form input[name="out_journey"]:checked').size() == 0
                && $('form input[name="rtn_journey"]:checked').size() == 0) {
            $('#confirm-submit').attr("disabled", "disabled");
            $('#confirm-submit').removeClass('btn-primary');
        } else {
            $('#confirm-submit').removeAttr("disabled");
            $('#confirm-submit').addClass('btn-primary');
        }
    }

    // getLatitude
    function getLatitudeList($source) {
        var param = new Object();
        var className = $source.attr('class');
        // set param for onward journey
        if (className == 'chb-out') {
            param.busStatus = $source.parent("td").find(
                    '.out_status').val();
            param.departTime = $source.parent("td").find(
                    '.out_deptTime').val();
            param.arriveTime = $source.parent("td").find(
                    '.out_arrTime').val();
            console.log('onward1');
        } else {
            // for return journey
            param.busStatus = $source.parent("td").find(
                    '.rtn_status').val();
            param.departTime = $source.parent("td").find(
                    '.rtn_deptTime').val();
            param.arriveTime = $source.parent("td").find(
                    '.rtn_arrTime').val();
            console.log('return1');
        }
        // call ajax
        $.ajax({
            type : "GET",
            url : $('#contextPath').val()
                    + "/search/getRouteLatitude.html",
            data : {
                busStatus : param.busStatus,
                departTime : param.departTime,
                arriveTime : param.arriveTime
            },
            success : function(data) {
                var loop = data.latitudeList;
                var waypoints = new Array();
                console.log("1st round - success");
                for ( var i = 0; i < loop.length; i++) {
                    waypoints.push({
                        latitude : loop[i]['latitude'],
                        longitude : loop[i]['longitude']
                    });
                }
                if (className == 'chb-out') {
                    $('#map').customGMap('addRoute', {
                        routeId : 1,
                        waypoints : waypoints
                    });
                    // console.log($('#map').data('routes')[1].waypoints);
                    /*
                     * $('#map').customGMap('hideRoute');
                     * $('#map').customGMap('showRoute', 1);
                     */
                } else {
                    $('#map').customGMap('addRoute', {
                        routeId : 2,
                        waypoints : waypoints
                    });
                    // console.log($('#map').data('routes')[1].waypoints);
                    $('#map').customGMap('hideRoute');
                    $('#map').customGMap('showRoute', 2);
                }
            }
        });
    }

    // show message on error
    if ($("#message").val() != null
            && $("#message").val() != "") {
        showPopup($("#message").val());
    }

    function checkChecked() {
        if ($('.chb-out:checked').size() == 0
                && $('.chb-ret:checked').size() == 0) {
            $('#confirm-submit').attr("disabled", "disabled");
            $('#confirm-submit').removeClass('btn-primary');
        } else {
            $('#confirm-submit').removeAttr("disabled");
            $('#confirm-submit').addClass('btn-primary');
        }
    }

    // show result details for onward journey
    if ($('.list-header.onward4').size() != 0) {
        showResultDetails('onward4');
    } else if ($('.list-header.onward3').size() != 0) {
        showResultDetails('onward3');
    } else if ($('.list-header.onward5').size() != 0) {
        showResultDetails('onward5');
    } else if ($('.list-header.onward2').size() != 0) {
        showResultDetails('onward2');
    } else if ($('.list-header.onward6').size() != 0) {
        showResultDetails('onward6');
    } else if ($('.list-header.onward1').size() != 0) {
        showResultDetails('onward1');
    } else if ($('.list-header.onward7').size() != 0) {
        showResultDetails('onward7');
    }

    // show result details on click header for return journey
    if ($('.list-header-rtn.return4').size() != 0) {
        showResultDetailsRtn('return4');
    } else if ($('.list-header-rtn.return3').size() != 0) {
        showResultDetailsRtn('return3');
    } else if ($('.list-header-rtn.return5').size() != 0) {
        showResultDetailsRtn('return5');
    } else if ($('.list-header-rtn.return2').size() != 0) {
        showResultDetailsRtn('return2');
    } else if ($('.list-header-rtn.return6').size() != 0) {
        showResultDetailsRtn('return6');
    } else if ($('.list-header-rtn.return1').size() != 0) {
        showResultDetailsRtn('return1');
    } else if ($('.list-header-rtn.return7').size() != 0) {
        showResultDetailsRtn('return7');
    }

    // onlick list-header
    $('.list-header').bind('click', (function() {
        var className = $(this).attr('class').split(' ')[1];
        showResultDetails(className);
    }));

    $('.list-header-rtn').bind('click', (function() {
        var rtnClassName = $(this).attr('class').split(' ')[1];
        showResultDetailsRtn(rtnClassName);
    }));

    function showResultDetails(headerName) {
        $('.search-rs-dtl').hide();
        $('.search-rs-dtl.' + headerName).show();
        // var checkbox = $('table.' + headerName + '
        // tr.tripDetails #out_journey')[0];
        $(".chb-out").attr('checked', false);
        $('.result-table.onward tr.tripDetails').removeClass(
                'choose');
        $('table.' + headerName
                + ' tr.tripDetails #out_journey')[0].checked = true;
        $($('table.' + headerName + ' tr.tripDetails')[0])
                .addClass('choose');
        checkChecked();
        $('.list-header').removeClass('header-current');
        $('.list-header').addClass('header-default');
        $('.list-header.' + headerName).removeClass(
                'header-default');
        $('.list-header.' + headerName).addClass(
                'header-current');
        console.log('onward');
//        getLatitudeList($($('table.' + headerName
//                + ' tr.tripDetails #out_journey')[0]));
    }

    function showResultDetailsRtn(headerName) {
        $('.search-rs-dtl-rtn').hide();
        $('.search-rs-dtl-rtn.' + headerName).show();
        $(".chb-ret").attr('checked', false);
        $('.result-table.return tr.tripDetails').removeClass(
                'choose');
        $('table.' + headerName
                + ' tr.tripDetails #rtn_journey')[0].checked = true;
        $($('table.' + headerName + ' tr.tripDetails')[0])
                .addClass('choose');
        checkChecked();
        $('.list-header-rtn').removeClass('header-current');
        $('.list-header-rtn').addClass('header-default');
        $('.list-header-rtn.' + headerName).removeClass(
                'header-default');
        $('.list-header-rtn.' + headerName).addClass(
                'header-current');
        console.log('return');
//        getLatitudeList($($('table.' + headerName
//                + ' tr.tripDetails #rtn_journey')[0]));
    }
    checkChecked002();
});