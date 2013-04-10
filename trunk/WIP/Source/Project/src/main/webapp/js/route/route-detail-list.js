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
                    $('#cancelModal').modal();
                }
            },
            success : function(data) {
                console.log(data);
                if (data.success) {
                    $.each(data.messages, function(index, value) {
                        $("#cancelModal #message").append('<p>' + value + '</p>');
                    });
                    $("#cancelModal #btnCancel").show();
                    $("#cancelModal #btnNo").show();
                    $("#cancelModal #btnClose").hide();
                    $("#cancelModal #message").removeClass("error");
                    $("#cancelModal #btnRetry").off('click.cancel');
                } else {
                    $.each(data.messages, function(index, value) {
                        $("#cancelModal #message").append('<p class="error">' + value + '</p>');
                    });
                    $("#cancelModal #btnRetry").show();
                    $("#cancelModal #btnRetry").on('click.cancel', function(e) {
                        // get busStatus id
                        var id = $('#cancelModal input[name="cancelBusStatusId"]').val();
                        // send request to calculate refund amount
                        confirmCancelSchedule(id, true);
                        // disable default behavior (event will still bubble up)
                        e.preventDefault();
                    });
                }
            },
            error : function() {
                $("#cancelModal #btnRetry").show();
                $("#cancelModal #message").addClass("error");
            	$("#cancelModal #message").append('<p>ERROR</p>');
            },
            complete : function() {
                $('.modal-body').removeClass("loading");
            }
        });
	}

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

    $("#cancelModal .close-model-btn").on('click.close', function(e) {
        $(this).parents('.modal').modal('hide');
    });

    $("#cancelModal #btnCancel").on('click.cancel', function(e) {
        var id = $('#cancelModal input[name="cancelBusStatusId"]').val();
        // send request to execute cancel trip
        $.ajax({
            type : "POST",
            url : $('#contextPath').val() + "/schedule/secured/executeDelete.html",
            dataType: 'jsonp',
            crossDomain: true,
            data : {
                // get id from hidden input
                id : id,
                reason : $('#cancelModal input[name="reason"]').val(),
            },
            beforeSend : function() {
                $("#cancelModal #message").html('');
                $('#cancelModal .modal-body').addClass("loading");
                // prevent double submit
                $("#cancelModal #btnCancel").prop('disabled', true);
                // prevent accidentally closing modal
                $('#cancelModal').on('hidden.lock', function(e) {
                    return false;
                });
            },
            success : function(data) {
                $('#cancelModal').off('hidden.lock');
                if (data.success) {
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