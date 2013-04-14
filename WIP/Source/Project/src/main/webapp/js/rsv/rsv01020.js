$(document).ready(function(){
    $('li').removeClass('active');
    $('li#tab_reservationList').addClass('active');
    $('#btnPrint').on('click.print', function(){
        window.print();
    });
    $('.ticket-list').on('click.cancel', 'a[id^="cancel_"]', function(e) {
        // get event target
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
                // display confirm modal
                $('.modal-body').addClass("loading");
                $("#cancelConfirmMessage").html('');
                $("#btnCancel").attr("disabled", "disabled");
                $("#cancelErrorMessage").hide();
                $("#cancelErrorMessage").html('');
                $('#cancelModal').modal();
            },
            success : function(data) {
                if (data.errorMessage) {
                    $("#cancelErrorMessage").html(data.errorMessage);
                    $("#cancelErrorMessage").show();
                } else {
                    $("#cancelConfirmMessage").html(data.cancelConfirmMessage);
                    $("#btnCancel").removeAttr("disabled");
                }
            },
            error : function() {
                $("#cancelErrorMessage").show();
                $("#cancelErrorMessage").html('error');
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