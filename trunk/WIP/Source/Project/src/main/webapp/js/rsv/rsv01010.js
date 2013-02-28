$(document).ready(function(){
    var reservationTable = $('#reservationList').dataTable({
        "aoColumnDefs" : [ {
            bSortable : false,
            sWidth : "40px",
            sClass: "text_center",
            aTargets : [ "details" ]
        },
        {
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
        "sPaginationType": "full_numbers",
        "aLengthMenu": [[-1, 10, 20, 50, 75, 100], [$("span.hidden#sAll").text(), 10, 20, 50, 75, 100]],
        "oLanguage": {
            "oPaginate": {
                "sFirst": $("span.hidden#sFirst").text(),
                "sLast": $("span.hidden#sLast").text(),
                "sNext": $("span.hidden#sNext").text(),
                "sPrevious": $("span.hidden#sPrevious").text(),
            },
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
        // get event target
        var target = e.target ? e.target : e.source;
        // get id from clicked hyper-link
        var id = $(target).attr('id').replace('cancel_',"");
        // set id to hidden input
        $('input[name="cancelReservationId"]').val(id);
        // send request to calculate refund amount
        $.ajax({
            type : "GET",
            url : $('contextPath').val() + "/pay/calculateRefund.html",
            data : {
                reservationId : id
            },
            beforeSend : function() {
                // display confirm modal
                $('#cancelModal').modal();
                $('.modal-body').addClass("loading");
                $("#btnCancel").attr("disabled", "disabled");
            },
            success : function(data) {
                if (data.errorMessage) {
                    $("#cancelConfirmMessage").html(data.errorMessage);
                } else {
                    $("#cancelConfirmMessage").html(data.cancelConfirmMessage);
                    $("#btnCancel").removeAttr("disabled");
                }
            },
            error : function() {
                $("#cancelConfirmMessage").html("ERROR");
            },
            complete : function() {
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
            url : $('contextPath').val() + "/pay/cancelReservation.html",
            data : {
                // get id from hidden input
                reservationId : $('input[name="cancelReservationId"]').val()
            },
            beforeSend : function() {
                $('.modal-body').addClass("loading");
                $("#btnCancel").attr("disabled", "disabled");
            },
            success : function(data) {
                if (data.errorMessage) {
                    $("#cancelConfirmMessage").html(data.errorMessage);
                    $("#btnCancel").removeAttr("disabled");
                } else {
                    $("#cancelConfirmMessage").html(data.cancelConfirmMessage);
                    // display confirm modal
                    $('#cancelModal').on('hidden.reload', function() {
                        location.reload();
                    });
                }
            },
            error : function() {
                $("#cancelConfirmMessage").html("ERROR");
                $("#btnCancel").removeAttr("disabled");
            },
            complete : function() {
                $('.modal-body').removeClass("loading");
            }
        });
    });
});