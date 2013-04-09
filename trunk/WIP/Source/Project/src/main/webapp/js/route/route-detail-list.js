$(document).ready(function() {
	
	function confirmCancelSchedule(id, retry) {
        $.ajax({
            type : "GET",
            url : $('#contextPath').val() + "/schedule/secured/confirmCancel.html",
            dataType: 'jsonp',
            crossDomain: true,
            data : {
            	id : id
            },
            beforeSend : function() {
                // display confirm modal
                $("#cancelModal #message").html('');
                $('#cancelModal .modal-body').addClass("loading");
                $("#cancelModal #cancelMessage").removeClass("error");
                $("#cancelModal #btnCancel").hide();
                $("#cancelModal #btnNo").hide();
                $("#cancelModal #btnClose").show();
                $("#cancelModal #btnRetry").hide();
                if (!retry) {
                    $('#cancelModal #cancelModal').modal();
                }
            },
            success : function(data) {
                if (data.success) {
                    $("#cancelModal #btnCancel").show();
                    $("#cancelModal #btnNo").show();
                    $("#cancelModal #btnClose").hide();
                    $("#cancelModal #message").removeClass("error");
                    $("#cancelModal #btnRetry").off('click.cancel');
                } else {
                    $("#cancelModal #btnRetry").show();
                    $("#cancelModal #btnRetry").on('click.cancel', function(e) {
                        // get busStatus id
                        var id = $('#cancelModal input[name="cancelBusStatusId"]').val();
                        // send request to calculate refund amount
                        confirmCancelSchedule(id, true);
                    });
                    $("#cancelModal #message").addClass("error");
                }
                $.each(data.message, function(index, value) {
                	$("#cancelModal .modal-body").append('<p>' + value + '</p>');
                });
            },
            error : function() {
                $("#cancelModal #btnRetry").show();
                $("#cancelModal #message").addClass("error");
            	$("#cancelModal .modal-body").append('<p>ERROR</p>');
            },
            complete : function() {
                $('.modal-body').removeClass("loading");
            }
        });
        // disable default behavior (event will still bubble up)
        e.preventDefault();
	}

    $('#scheduleTable').on('click.cancel', 'button.btn-cancel', function(e) {
        // get busStatus id
        var id = $(this).siblings('input[name="id"]').val();
        // set id to hidden input
        $('#cancelModal input[name="cancelBusStatusId"]').val(id);
        // send request to calculate refund amount
        confirmCancelSchedule(id);
    });

    $("#cancelModal .close-model-btn").on('click.close', function(e) {
        $(this).parents('.modal').modal('hide');
    });

    $("#cancelModal #btnCancel").on('click.cancel', function(e) {
        // send request to calculate refund amount
        $.ajax({
            type : "POST",
            url : $('#contextPath').val() + "/schedule/secured/executeDelete.html",
            dataType: 'jsonp',
            crossDomain: true,
            data : {
                // get id from hidden input
                id : $('#cancelModal input[name="cancelBusStatusId"]').val(),
                reason : $('#cancelModal input[name="reason"]').val(),
            },
            beforeSend : function() {
                $("#cancelModal #message").html('');
                $('#cancelModal .modal-body').addClass("loading");
                $("#cancelModal #btnCancel").prop('disabled', true);
                $('#cancelModal').on('hidden.reload', function(e) {
                    // disable default behavior (event will still bubble up)
                    e.preventDefault();
                });
            },
            success : function(data) {
                $.each(data.message, function(index, value) {
                	$("#cancelModal .modal-body").append('<p>' + value + '</p>');
                });
                if (data.success) {
                    $("#cancelModal #btnCancel").hide();
                    $("#cancelModal #btnNo").hide();
                    $("#cancelModal #btnClose").show();
                    $("#cancelModal #message").removeClass("error");
                    $('#cancelModal').off('hidden.reload');
                    $('#cancelModal').on('hidden.reload', function(e) {
                        location.reload();
                    });
                } else {
                    $("#cancelModal #message").addClass("error");
                	$("#cancelModal .modal-body").append('<p>Do you want to try again?</p>');
                }
            },
            error : function() {
                $("#cancelModal #message").addClass("error");
            	$("#cancelModal .modal-body").append('<p>ERROR</p>');
            	$("#cancelModal .modal-body").append('<p>Do you want to try again?</p>');
            },
            complete : function() {
                $('#cancelModal .modal-body').removeClass("loading");
            }
        });
    });
});