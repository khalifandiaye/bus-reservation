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
                // add loading sign
                $('#cancelModal .modal-body').addClass("loading");
                // hide and clear previous error message
                $("#cancelModal #errorMessage").hide();
                $("#cancelModal #errorMessage").html('');
                // hide all but close button
                $("#cancelModal #btnCancel").hide();
                $("#cancelModal #btnNo").hide();
                $("#cancelModal #btnClose").show();
                $("#cancelModal #btnRetry").hide();
                // on first try
                if (!retry) {
                    // clear previous message
                    $("#cancelModal #message").html('');
                    // show modal
                    $('#cancelModal').modal();
                }
            },
            success : function(data) {
                console.log(data);
                if (data.success) {
                    // clear previous message
                    $("#cancelModal #message").html('');
                    // show new message
                    $.each(data.messages, function(index, value) {
                        $("#cancelModal #message").append('<p>' + value + '</p>');
                    });
                    // show input field
                    $('#cancelModal input[name="reason"]').show();
                    // show button confirm and cancel
                    $("#cancelModal #btnCancel").show();
                    $("#cancelModal #btnNo").show();
                    $("#cancelModal #btnClose").hide();
                } else {
                    // show error message
                    $.each(data.messages, function(index, value) {
                        $("#cancelModal #errorMessage").append('<p>' + value + '</p>');
                    });
                    $("#cancelModal #errorMessage").show();
                    // show retry button
                    $("#cancelModal #btnRetry").show();
                }
            },
            error : function() {
                // show generic error message
                $("#cancelModal #errorMessage").append('<p>ERROR</p>');
                $("#cancelModal #errorMessage").show();
                // show retry button
                $("#cancelModal #btnRetry").show();
            },
            complete : function() {
                // remove loading sign
                $('.modal-body').removeClass("loading");
            }
        });
	}

	// click event for cancel button linked with each schedule
    $('#scheduleTable').on('click.cancel', 'a.btn-cancel', function(e) {
        // get busStatus id
        var id = $(this).siblings('input[name="id"]').val();
        // set id to hidden input
        $('#cancelModal input[name="cancelBusStatusId"]').val(id);
        // send request to calculate refund amount
        confirmCancelSchedule(id);
        // disable default behavior (event will still bubble up)
        e.preventDefault();
    });

    // click event for retry button in cancel schedule modal
    $("#cancelModal #btnRetry").on('click.cancel', function(e) {
        // get busStatus id
        var id = $('#cancelModal input[name="cancelBusStatusId"]').val();
        // send request to calculate refund amount
        confirmCancelSchedule(id, true);
        // disable default behavior (event will still bubble up)
        e.preventDefault();
    });

    // click event to close cancel modal
    $("#cancelModal .close-model-btn").on('click.close', function(e) {
        $(this).parents('.modal').modal('hide');
    });

    $("#cancelModal #btnCancel").on('click.cancel', function(e) {
        // get id of schedule to be cancel
        var id = $('#cancelModal input[name="cancelBusStatusId"]').val();
        // get reason
        var reason = $('#cancelModal input[name="reason"]').val();
        // send request to execute cancel trip
        $.ajax({
            type : "POST",
            url : $('#contextPath').val() + "/schedule/secured/executeDelete.html",
            dataType: 'jsonp',
            crossDomain: true,
            data : {
                id : id,
                reason : reason,
            },
            beforeSend : function() {
                // add loading sign
                $('#cancelModal .modal-body').addClass("loading");
                // prevent double submit
                $("#cancelModal #btnCancel").hide();
                // prevent accidentally closing modal
                $('#cancelModal').modal('lock');
            },
            success : function(data) {
                $('#cancelModal').modal('unlock');
                if (data.success) {
                    $("#cancelModal #message").html('');
                    // hide input field
                    $('#cancelModal input[name="reason"]').hide();
                    // send request to refund related tickets
                    $.ajax({
                        type : "POST",
                        url : $('#contextPath').val() + "/schedule/secured/executeRefund.html",
                        dataType: 'jsonp',
                        crossDomain: true,
                        data : {
                            // get id from hidden input
                            id : id,
                        },
                        beforeSend : function() {
                            $("#cancelModal #message").html('');
                            $("#cancelModal #message").append('<p>Refunding. Please don\'t close this page</p>');
                            $('#cancelModal .modal-body').addClass("loading");
                            // prevent closing page
                            $(window).on('unload.lock', function(e) {
                                return false;
                            });
                            // prevent accidentally closing modal
                            $('#cancelModal').on('hidden.lock', function(e) {
                                return false;
                            });
                        },
                        success : function(data) {
                            // unlock
                            $(window).off('unload.lock');
                            $('#cancelModal').off('hidden.lock');
                            $("#cancelModal #message").html('');
                            if (data.success) {
                                $("#cancelModal #message").append('<p>Refund process has been completed</p>');
                                // close modal
//                                $('#cancelModal').modal('hide');s
                            } else {
                                // display error message
                                $.each(data.messages, function(index, value) {
                                    $("#cancelModal #message").append('<p class="error">' + value + '</p>');
                                });
                            }
                        },
                        error : function() {
                            $("#cancelModal .modal-body").append('<p class="error">ERROR</p>');
                        },
                        complete : function() {
                            $('#cancelModal .modal-body').removeClass("loading");
                        }
                    });
                    // show only close button
                    $("#cancelModal #btnCancel").hide();
                    $("#cancelModal #btnNo").hide();
                    $("#cancelModal #btnClose").show();
                    $("#cancelModal #message").removeClass("error");
                    // reload page on closing modal
                    $('#cancelModal').on('hidden.reload', function(e) {
                        location.reload();
                    });
                } else {
                    // display error message
                    $.each(data.messages, function(index, value) {
                        $("#cancelModal #message").append('<p class="error">' + value + '</p>');
                    });
                    // change button Yes > Retry
                    $("#cancelModal #btnCancel").text('Retry');
                    // change button No > Close
                    $("#cancelModal #btnNo").text('Close');
                    $("#cancelModal #btnCancel").prop('disabled', false);
                }
            },
            error : function() {
            	$("#cancelModal .modal-body").append('<p class="error">ERROR</p>');
                // change button Yes > Retry
                $("#cancelModal #btnCancel").text('Retry');
                // change button No > Close
                $("#cancelModal #btnNo").text('Close');
                $("#cancelModal #btnCancel").prop('disabled', false);
            },
            complete : function() {
                $('#cancelModal .modal-body').removeClass("loading");
            }
        });
    });
});