$(document).ready(function(){
    $('button').on('click.getAJAX', function(e) {
        var input = {
                "reservationInfo.subRouteName" : "subRouteName",
                "reservationInfo.strings[0]" : "String 1",
                "reservationInfo.strings[1]" : "String 2",
        };
        $.ajax({
            type : "GET",
            url : $('contextPath').val() + "/pay/doNothing.html",
            data : input,
            contentType: "application/json; charset=utf-8",
            beforeSend : function() {
                // display confirm modal
//                $('#cancelModal').modal();
//                $('.modal-body').addClass("loading");
//                $("#btnCancel").attr("disabled", "disabled");
            },
            success : function(data) {
                $('#subRouteName').html("data" + data.reservationInfo.subRouteName);
//                $('#seatNumbers').html(data.reservationInfo.seatNumbers);
                $(data.reservationInfo.strings).each(function() {
                    $('#strings').append('<span>' + this + '</span><br>');
                });
            },
            error : function() {
//                $("#cancelConfirmMessage").html("ERROR");
            },
            complete : function() {
//                $('.modal-body').removeClass("loading");
            }
        });
    });
//    $(reservationTable).on('click.cancel', 'a[id^="cancel_"]', function(e) {
//        // get event target
//        var target = e.target ? e.target : e.source;
//        // get id from clicked hyper-link
//        var id = $(target).attr('id').replace('cancel_',"");
//        // set id to hidden input
//        $('input[name="cancelReservationId"]').val(id);
//        // send request to calculate refund amount
//        $.ajax({
//            type : "GET",
//            url : $('contextPath').val() + "/pay/calculateRefund.html",
//            data : {
//                reservationId : id
//            },
//            beforeSend : function() {
//                // display confirm modal
//                $('#cancelModal').modal();
//                $('.modal-body').addClass("loading");
//                $("#btnCancel").attr("disabled", "disabled");
//            },
//            success : function(data) {
//                if (data.errorMessage) {
//                    $("#cancelConfirmMessage").html(data.errorMessage);
//                } else {
//                    $("#cancelConfirmMessage").html(data.cancelConfirmMessage);
//                    $("#btnCancel").removeAttr("disabled");
//                }
//            },
//            error : function() {
//                $("#cancelConfirmMessage").html("ERROR");
//            },
//            complete : function() {
//                $('.modal-body').removeClass("loading");
//            }
//        });
//        // disable default behavior (event will still bubble up)
//        e.preventDefault();
//    });
//    $(".close-model-btn").on('click.close', function(e) {
//        // get event target
//        var target = e.target ? e.target : e.source;
//        $(target).parents('.modal').modal('hide');
//    });
//    $("#btnCancel").on('click.cancel', function(e) {
//        // send request to calculate refund amount
//        $.ajax({
//            type : "POST",
//            url : $('contextPath').val() + "/pay/cancelReservation.html",
//            data : {
//                // get id from hidden input
//                reservationId : $('input[name="cancelReservationId"]').val()
//            },
//            beforeSend : function() {
//                $('.modal-body').addClass("loading");
//                $("#btnCancel").attr("disabled", "disabled");
//            },
//            success : function(data) {
//                if (data.errorMessage) {
//                    $("#cancelConfirmMessage").html(data.errorMessage);
//                    $("#btnCancel").removeAttr("disabled");
//                } else {
//                    $("#cancelConfirmMessage").html(data.cancelConfirmMessage);
//                    // display confirm modal
//                    $('#cancelModal').on('hidden.reload', function() {
//                        location.reload();
//                    });
//                }
//            },
//            error : function() {
//                $("#cancelConfirmMessage").html("ERROR");
//                $("#btnCancel").removeAttr("disabled");
//            },
//            complete : function() {
//                $('.modal-body').removeClass("loading");
//            }
//        });
//    });
});