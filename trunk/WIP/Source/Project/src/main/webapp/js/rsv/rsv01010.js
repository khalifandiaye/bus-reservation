$(document).ready(function(){
    $('li').removeClass('active');
    $('li#tab_reservationList').addClass('active');
    var reservationTable = $('#reservationList').dataTable({
        "aoColumnDefs" : [ {
            bSortable : false,
            sWidth : "70px",
            sClass: "text_center",
            aTargets : [ "details" ]
        },
        {
            "bVisible": false,
            "sClass": "text_center",
            "sWidth": "20px",
            "aTargets" : [ "index" ]
        },
        {
            "sWidth": "100px",
            "aTargets" : [ "status" ]
        },
        {
            "iDataSort": 0,
            "aTargets" : [ "departure_date" ]
        },
        {
            "iDataSort": 3,
            "aTargets" : [ "book_time" ]
        },
        {
            "bVisible": false,
            "aTargets" : [ 3 ]
        }],
        "bAutoWidth": true,
        "bDeferRender": true,
        "bStateSave": true,
        "iDisplayLength": 10,
        "aLengthMenu": [[-1, 10, 20, 50, 75, 100], [$("span.hidden#sAll").text(), 10, 20, 50, 75, 100]],
        "oLanguage": {
            "sEmptyTable" : $("span.hidden#sEmptyTable").text(),
            "sInfo": $("span.hidden#sInfo").text(),
            "sInfoEmpty": $("span.hidden#sInfoEmpty").text(),
            "sInfoFiltered": $("span.hidden#sInfoFiltered").text(),
            "sInfoThousands": $("span.hidden#sInfoThousands").text(),
            "sLengthMenu": $("span.hidden#sLengthMenu").text(),
            "sLoadingRecords": $("span.hidden#sLoadingRecords").text(),
            "sProcessing": $("span.hidden#sProcessing").text(),
            "sSearch": $("span.hidden#sSearch").text(),
            "sZeroRecords": $("span.hidden#sZeroRecords").text(),
        }
    });
    $(reservationTable).on('click.details', 'a[id^="details_"]', function(e) {
        // get event target
        var target = e.target ? e.target : e.source;
        // get id from clicked hyper-link
        var id = $(target).attr('id').replace('details_',"");
        // set id to hidden input
        $('input[name="reservationId"]').val(id);
        // submit form
        $('form').prop("action", $('#contextPath').val() + '/rsv/rsv01020.html');
        $('form').submit();
        // disable default behavior (event will still bubble up)
        e.preventDefault();
    });
    $(reservationTable).on('click.cancel', 'a[id^="cancel_"]', function(e) {
//        // get event target
        var target = e.target ? e.target : e.source;
        // get id from clicked hyper-link
        var id = $(target).attr('id').replace('cancel_',"");
        // set id to hidden input
        $('input[name="cancelReservationId"]').val(id);
        // send request to calculate refund amount
        $.ajax({
            type : "GET",
            url : $('#contextPath').val() + "/pay/calculateRefund.html",
            dataType: 'jsonp',
            crossDomain: true,
            data : {
                ticketId : id
            },
            beforeSend : function() {
                console.log('start ajax');
                // display confirm modal
                $('.modal-body').addClass("loading");
                $("#cancelConfirmMessage").html('');
                $("#btnCancel").attr("disabled", "disabled");
                $("#cancelErrorMessage").hide();
                $('#cancelModal').modal();
                $("#cancelErrorMessage").html('');
            },
            success : function(data) {
                console.log(data);
                if (data.errorMessage) {
                    $("#cancelErrorMessage").html(data.errorMessage);
                    $("#cancelErrorMessage").show();
                } else {
                    $("#cancelConfirmMessage").html(data.cancelConfirmMessage);
                    $("#btnCancel").removeAttr("disabled");
                }
            },
            error : function() {
                console.log('ajax error');
                $("#cancelErrorMessage").show();
                $("#cancelErrorMessage").html('error');
            },
            complete : function() {
                console.log('ajax complete');
                $('.modal-body').removeClass("loading");
            }
        });
        // disable default behavior (event will still bubble up)
        e.preventDefault();
    });
    $(".close-model-btn").on('click.close', function(e) {
        // get event target
        var target = e.target ? e.target : e.source;
        $(target).parents('.modal').modal('hide');
    });
    $("#btnCancel").on('click.cancel', function(e) {
        // send request to calculate refund amount
        $.ajax({
            type : "POST",
            url : $('#contextPath').val() + "/pay/cancelReservation.html",
            dataType: 'jsonp',
            crossDomain: true,
            data : {
                // get id from hidden input
                ticketId : $('input[name="cancelReservationId"]').val()
            },
            beforeSend : function() {
                $('.modal-body').addClass("loading");
                $("#btnCancel").prop("disabled", true);
                $("#cancelErrorMessage").hide();
                $("#cancelErrorMessage").html('');
            },
            success : function(data) {
                if (data.errorMessage && !data.cancelConfirmMessage) {
                    $("#cancelErrorMessage").show();
                    $("#cancelErrorMessage").html(data.errorMessage);
                    $("#btnCancel").prop("disabled", false);
                } else {
                    if (data.errorMessage) {
                        $("#cancelErrorMessage").show();
                        $("#cancelErrorMessage").html(data.errorMessage);
                    }
                    $("#cancelConfirmMessage").html(data.cancelConfirmMessage);
                    // display confirm modal
                    $('#cancelModal').on('hidden.reload', function() {
                        location.reload();
                    });
                    $('#btnNo').addClass("hidden");
                    $('#btnCancel').addClass("hidden");
                    $('#btnClose').removeClass("hidden");
                }
            },
            error : function() {
                $("#cancelErrorMessage").show();
                $("#cancelErrorMessage").html('error');
                $("#btnCancel").prop("disabled", false);
            },
            complete : function() {
                $('.modal-body').removeClass("loading");
            }
        });
    });
});