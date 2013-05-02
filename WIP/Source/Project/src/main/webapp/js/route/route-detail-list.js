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
        // hide and clear previous error message
        $("#cancelModal #errorMessage").hide();
        $("#cancelModal #errorMessage").html('');
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
                    // clear previous message
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
                            $("#cancelModal #message").append('<p>Refunding. Please don\'t close this page</p>');
                            $('#cancelModal .modal-body').addClass("loading");
                            // prevent closing page
                            $(window).on('unload.lock', function(e) {
                                return false;
                            });
                            // prevent accidentally closing modal
                            $('#cancelModal').modal('lock');
                        },
                        success : function(data) {
                            if (data.success) {
                                // clear previous message
                                $("#cancelModal #message").html('');
                                // display returned message
                                $("#cancelModal #message").append('<p>Refund process has been completed</p>');
                                // close modal
                                $('#cancelModal').modal('hide');
                            } else {
                                // display error message
                                $.each(data.messages, function(index, value) {
                                    $("#cancelModal #errorMessage").append('<p>' + value + '</p>');
                                });
                                $("#cancelModal #errorMessage").show();
                            }
                        },
                        error : function() {
                            $("#cancelModal .modal-body").append('<p class="error">ERROR</p>');
                        },
                        complete : function() {
                            // unlock
                            $(window).off('unload.lock');
                            $('#cancelModal').modal('unlock');
                            // remove loading sign
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
                        $("#cancelModal #errorMessage").append('<p>' + value + '</p>');
                    });
                    $("#cancelModal #errorMessage").show();
                    // change button Yes > Retry
                    $("#cancelModal #btnCancel").text('Retry');
                    $("#cancelModal #btnCancel").show();
                    // change button No > Close
                    $("#cancelModal #btnNo").text('Close');
                    $("#cancelModal #btnCancel").prop('disabled', false);
                }
            },
            error : function() {
                $("#cancelModal #errorMessage").append('<p>ERROR</p>');
                $("#cancelModal #errorMessage").show();
                // change button Yes > Retry
                $("#cancelModal #btnCancel").text('Retry');
                // change button No > Close
                $("#cancelModal #btnNo").text('Close');
                $("#cancelModal #btnCancel").prop('disabled', false);
            },
            complete : function() {
                // unlock
                $(window).off('unload.lock');
                $('#cancelModal').modal('unlock');
                // remove loading sign
                $('#cancelModal .modal-body').removeClass("loading");
            }
        });
    });
});

function validateSegmentPrice(params){ 
	   var price = params.value;
	   if (price.trim() == '' ||  parseInt(price) < 50) {
		   params.value = 50;
	   } else if (parseInt(price) > 10000) {
		   params.value = 10000	;
	   }
};

function showTripDialogBusPlate(){
	var rb1 = $("input[name='avaiBusList']:checked").val();
	
	if(rb1 == "busInRoute"){
		$('#tripDialogBusPlate').removeClass('hidden');
		$('#tripDialogBusPlateExtends').addClass('hidden');
	} else {
		$('#tripDialogBusPlateExtends').removeClass('hidden');
		$('#tripDialogBusPlate').addClass('hidden');
	}
	checkButton();
};

function getStation(el, des, stationEndAtKey) {
  cityId = $('#' + el).val();
     if (cityId != -1) {
     $.ajax({url: "getStation.html?cityId=" + cityId }).done(
     function(data) {
           $('#' + des).empty();
            $.each(data.stationInfos, function() {
              $('#' + des).append('<option value="'+this.id+'">'+this.name+'</option>');
            });
            if (el == 'startAt' && stationEndAtKey) {
              $("#stationStartAt").val(stationEndAtKey);
            }
            getDuration();
            if ($('#' + el).prop('disabled')) {
            	$('#' + el).select2('disable');
                $('#' + des).select2('disable');
            } else {
                $('#' + des).select2('enable');
            }
            $('#' + des).trigger('change');
        });
   }
};

function getDuration() {
  var startStationAt = $("#stationStartAt").val();
  var endStationAt = $("#stationEndAt").val();
  if (startStationAt && endStationAt && startStationAt != -1 && endStationAt != -1) {
     $.ajax({
           type : "GET",
           url: "getSegmentDuration.html?startStation=" + startStationAt + "&endStation=" + endStationAt,
           contentType : "application/x-www-form-urlencoded; charset=utf-8",
        }).done(
           function(data) {
              if (data.travelTime != '') {
                 $("#duration").val(data.travelTime);
                 $("#duration").prop("disabled", true);
              } else {
                 $("#duration").prop("disabled", false);
              }
              checkAdd();
           });
  } 
}

function checkAdd() {
  var startAt = $('#startAt').val();
  var endAt = $("#endAt").val();
  var duration = $('#duration').val();
  
  duration = parseInt(duration.replace(":",""), 10);

  if(startAt != -1 && endAt != -1 && duration != '' && duration >= parseInt('100', 10) && giCount < 5){
	  $("#add").addClass("btn-primary");
	  $("#add").removeAttr("disabled"); 
  } else { 
	 $("#add").removeClass('btn-primary');
     $("#add").attr("disabled","disabled");
  }
}

var manageSegmentTable;

function deleteSegment(value) {
      var td = value.parentNode;
       var tr = td.parentNode;
       var aPos = manageSegmentTable.dataTable().fnGetPosition(td);
       var data = manageSegmentTable.fnGetData(tr);
       
       var curPosition = aPos[0];
       var tableLength = manageSegmentTable.dataTable().fnGetData().length;
       for (var i = curPosition; i <= tableLength; i++) {
    	   manageSegmentTable.dataTable().fnDeleteRow(curPosition);
       }
}

$(document).ready(function() {
  
   manageSegmentTable = $('#manageSegmentTable').dataTable({ bSort : false, bPaginate : false });
        
  $('#editRoute').bind('click', function(event) {
     giCount = 0;
     $("#routeAddDialogOk").attr("disabled","disabled"); 
     manageSegmentTable.dataTable().fnClearTable();
     $("#startAt").prop("disabled", false);
     //$("#stationStartAt").prop("disabled", true);
     //$("#stationEndAt").prop("disabled", true);
     //$("#startAt").val(-1);
     //$("#endAt").val(-1);
     // sort start at
     $('#startAt').html($('option', $('#startAt')).sort(function(a, b) {
    	 return a.text == b.text ? 0 : a.text < b.text ? -1 : 1;
     }));
     if ($('#startAt').data('removedOptionList')) {
    	 $($('#startAt').data('removedOptionList')).each(function(index, value) {
    		 value.appendTo('#endAt');
    	 });
     }
     $("#startAt").trigger('change');
     // sort end at
     $('#endAt').html($('option', $('#endAt')).sort(function(a, b) {
    	 return a.text == b.text ? 0 : a.text < b.text ? -1 : 1;
     }));
     $("#duration").val('01:00');
     $("#errorMessage").text('');
     $("#errorMessage").parent().hide();
     $("#editRouteSave").prop('disabled',true);
     $("#editRouteSave").removeClass('btn-primary');
     //$('#stationStartAt').empty();
     //$('#stationEndAt').empty();
     //$("#endAt option").show();
     $("#addRouteDialog").modal();
  });
   
  $("#duration").mask("99:99");
  
  $('#startAt').change(function() {
     //$("#endAt option").show();
     //$("#endAt").val(-1);
     //$('#stationEndAt').empty();
     getStation('startAt', 'stationStartAt');
     // re attach previous option
	 if ($(this).data('previousOption') && !$(this).prop('disabled')) {
	     console.log($(this).data('previousOption'));
		 $(this).data('previousOption').appendTo('#endAt');
	 }
	 // detach current option
     if ($(this).val() != -1) {
    	 if ($(this).prop('disabled')) {
    		 if (!$(this).data('removedOptionList')) {
    			 $(this).data('removedOptionList', []);
    		 }
    		 $(this).data('removedOptionList').push($("#endAt option[value=" + $("#startAt").val() + "]").detach());
    	 } else {
        	 $(this).data('previousOption', $("#endAt option[value=" + $("#startAt").val() + "]").detach());
    	 }
     } else {
    	 $(this).removeData('previousOption');
     }
     // sort end at
     $('#endAt').html($('option', $('#endAt')).sort(function(a, b) {
    	 return a.text == b.text ? 0 : a.text < b.text ? -1 : 1;
     }));
     //$("#endAt option[value=" + $("#startAt").val() + "]").hide();
     $("#endAt").trigger('change');
     checkAdd();
  });
              
  $('#endAt').change(function() {
     getStation('endAt', 'stationEndAt');
     checkAdd();
  });
  
  $('#stationEndAt').change(function() {
     getDuration();
      checkAdd();
  });
  
  $('#duration').change(function(){
     checkAdd();
  });
              
  $("#validDateDiv").datetimepicker({
     format : "yyyy/mm/dd - hh:ii",
     autoclose : true,
     todayBtn : true,
     startDate : new Date(),
     minuteStep : 10
  });
  
  $("#add").bind('click', function() {
        if (giCount == 5) {
           $("#errorMessage").text("Maximum segment added!");
           $("#add").removeClass('btn-primary');
           $("#add").attr("disabled","disabled");
           return;
        }
        
        $("#routeAddDialogOk").removeAttr("disabled");  

        var startAtKey = $("#startAt").val();
        var stationStartAtKey = $("#stationStartAt").val();
        var endAtKey = $("#endAt").val();
        var stationEndAtKey = $("#stationEndAt").val();
        var startAt = $("#startAt option:selected").text();
        var stationStartAt = $("#stationStartAt option:selected").text();
        var endAt = $("#endAt option:selected").text();
        var stationEndAt = $("#stationEndAt option:selected").text();
        var duration = $("#duration").val();
                       
        if (endAt.trim() == '' || endAtKey == -1) {
           return;
        }
        
        if (stationStartAt.trim() == '' || stationStartAtKey == -1) {
           return;
        }
                       
        if (stationEndAt.trim() == '' || stationEndAtKey == -1) {
           return;
        }
                       
        if (duration.trim() == '') {
           return;
        }
                       
        $('#manageSegmentTable').dataTable().fnAddData(
                [ startAt + ' - ' + stationStartAt,
                  endAt + ' - ' + stationEndAt, 
                  duration ]);
        
        giCount++;

        $("#startAt").val(endAtKey);
        $("#startAt").prop("disabled", true);
        //$('#startAt').select2('disable');
        //$("#stationStartAt").prop("disabled", true);
        //$('#stationStartAt').select2('disable');
        //$("#stationEndAt").empty();
        //getStation('startAt', 'stationStartAt', stationEndAtKey, true);
        $("#startAt").trigger('change');
                      
        //$("#endAt option[value=" + endAtKey + "]").remove();
        //$("#endAt").val(-1);
        $("#endAt").trigger('change');
        $("#duration").val('01:00');
        //$('#stationEndAt').empty();
        $("#duration").prop("disabled", false);

        var segment = {};
        segment['startAt'] = startAtKey;
        segment['stationStartAt'] = stationStartAtKey;
        segment['endAt'] = endAtKey;
        segment['stationEndAt'] = stationEndAtKey;
        segment['duration'] = duration;
        newSegments.push(segment);

        if (giCount == 5) {
           $("#errorMessage").text("Maximum segment added!");
           $("#errorMessage").parent().show();
        }
        $("#editRouteSave").addClass('btn-primary');
        $("#editRouteSave").prop('disabled',false);
 });

 $("#editRouteSave").bind('click', 
      function() {
	      $("#editRouteSave").attr("disabled","disabled");
	      newInfo['routeId'] = $("#routeId").val();
	      newInfo['segments'] = newSegments;
                       
        $.ajax({
           type : "POST",
           url : 'updateSegment.html',
           contentType : "application/x-www-form-urlencoded; charset=utf-8",
           data : {
              data : JSON.stringify(newInfo)
           },
           success : function(response) {
        	   var url = $('#contextPath').val() + "/route/route-detail-list.html?routeId="
				+ $('#routeId').val();
			   window.location = url;
           },
           error: function(){
        	   $('#saveSuccess').modal('hide');
        	   $("#saveSuccessDialogLabeMessage").html(response);
        	   $("#saveSuccess").text("Save new route failed!");
           }
        });
        
        
     });
 
 $('#saveSuccessDialogOk').click(function() {
        var url = $('#contextPath').val() + "/route/list.html";
        window.location = url;
  });
 
 $('#editRouteCancel').click(function() {
	 newInfo = {};
	 newSegments = [];
   giCount = 0;
 });
 
 //SELECT 2
 $("#startAt").select2();
 $("#endAt").select2();
 $("#stationStartAt").select2({minimumResultsForSearch : 5});
 $("#stationEndAt").select2({minimumResultsForSearch : 5});
 /*$('#editBusDialog').on('focus', function(e) {
	 e.preventDefault();
 });*/
 $('.select2-input').on('focusin.anti-modal', function(e){
	 e.stopPropagation();
 });
});

var newInfo = {};
var newSegments = [];
var giCount = 0;

var info = {};
Date.prototype.toMyString = function () {

    function padZero(obj) {
          obj = obj + '';
          if (obj.length == 1)
              obj = "0" + obj
          return obj;
    }

    var output = "";
    output += padZero(this.getDate()) + "/";
    output += padZero(this.getMonth()+1) + "/";
    output += this.getFullYear();

    return output; 
};

   function checkBusType() {
	   var optionCount = $("#busType option").length;
	   if(optionCount != 0){
		   $("#busType").removeAttr("disabled"); 
        } else { 
        	$("#busType").attr("disabled","disabled");
        }
   }

	function validate(evt) {
		var theEvent = evt || window.event;
		var key = theEvent.keyCode || theEvent.which;
		var charCode = theEvent.charCode;
		var charac = String.fromCharCode(key);
		var regex = /[0-9]/;
		if (charCode != 0 && !regex.test(charac)) {
			theEvent.returnValue = false;
			if (theEvent.preventDefault)
				theEvent.preventDefault();
		}
	}

	function updateTarrif(info) {
		$.ajax({
			type : "POST",
			url : 'updateTariff.html',
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			data : {
				data : JSON.stringify(info)
			},
			success : function(response) {
				var url = $('#contextPath').val() + "/route/route-detail-list.html?routeId="
						+ $('#routeId').val();
				window.location = url;
			},
			error : function() {
				alert("Save new route failed!");
			}
		});
	}

	var d = new Date();
	var now = d.toMyString();
	d.setDate(d.getDate() + 1);
	$(function() {
	      $('#validDateSelect').datepicker({
	         dateFormat : 'dd/mm/yy',
	         minDate : '0',
	         maxDate : '+3M',
	         regional : 'vi'
	      });
	      $('#validDateSelect').val(now);
	      
	      $('#validDate').datepicker({
	            dateFormat : 'dd/mm/yy',
	            minDate : '0',
	            maxDate : '+3M',
	            regional : 'vi'
    	  });
    	  $('#validDate').val(now);
	});
	
	$('#cancelAdd').bind('click', function() {
		$("#tripDialogRoutes").val(-1);
		$("#tripDialogDepartureTime").val('');
		$("#tripDialogArrivalTime").val('');
		$('#tripDialogBusPlate').val('');
		$('#tripDialogBusPlateExtends').val('');
		$('#CreateScheduleDialog').modal('hide');
	});
	
	$(document).ready(function() {
		
		$('#scheduleTable').dataTable({ bSort : false });
		checkBusType();
		var active = $("#active").val();
		

		$('tr[data-segment-id]').each(function() {
			var id = this.dataset.segmentId;
			var segment = {};
			segment['id'] = id;
			segments.push(segment);
		});
		
		var selectedRouteId = $("#routeId").val();
		if (selectedRouteId != '-1') 
			{$.ajax({url : $('#contextPath').val()
				+ "/schedule/busTypes.html?&routeId="
				+ selectedRouteId,}).done(
				function(data) {
					$('#tripDialogBusType').empty();
					$.each(data.busTypeInfos, function() {
						   $('#tripDialogBusType').append('<option value="' + this.id + '">'
								+ this.type
								+ '</option>');
					});
				});
			};
		
		$('#busStatusInsertBtn').click(function() {
			var date = new Date();
			date.setDate(date.getDate() + 1);
			//$(".alert.fade.in.schedule-error").hide();
			$("#addNewSchedule").removeClass('btn-success');
			$("#addNewSchedule").attr("disabled","disabled");
			$('#tripDialogRoutes').val(-1);
			$('#tripDialogDepartureTime').val('');
			$('#tripDialogArrivalTime').val('');
			$('#tripDialogBusPlate').empty();
			$('#tripDialogBusPlateExtends').empty();
			$('#addScheduleError').empty();
			$('#CreateScheduleDialog').modal();
			$('#tripEditDialogLabel').html("Add New Schedule");
			
			$("#tripDialogDepartureTimeDiv").datetimepicker({
				format : "hh:ii - dd/mm/yyyy",
				autoclose : true,
				todayBtn : false,
				startDate : date,
				minuteStep : 10
			}).on('change', function(ev) {
				getAvailBus();
				getArrivalTime();
				checkButton();
			});
			
			$("#autoReturnDialogDepartureTimeDiv").datetimepicker({
				  format : "hh:ii - dd/mm/yyyy",
				  autoclose : true,
				  startDate : date,
				  minuteStep : 10
	      }).on('change', function(ev) {
	    	     getAutoArrivalTime();
	      });
			
			$("#tripDialogDepartureTimeDiv").datetimepicker("setDate", date);
			
			var d = date;
         	d.setDate(d.getDate() + 1);
			$("#autoReturnDialogDepartureTimeDiv").datetimepicker("setDate", d);
			$("#autoReturnDialogDepartureTimeDiv").datetimepicker("setStartDate", d);
			
			getArrivalTime();
			getAvailBus();
			getAutoArrivalTime();
		
		});

		function getAvailBus() {
			var selectedRouteId = $("#routeId").val();
			var departureTime = $("#tripDialogDepartureTime").val();
			var selectedBusType = $("#tripDialogBusType").val();
			if (selectedRouteId != '-1' && departureTime != ""
					&& selectedBusType != '-1') {$.ajax({
						url : $('#contextPath').val()	+ "/schedule/availBus.html?departureTime="
								+ departureTime + "&busType=" + selectedBusType
								+ "&routeId="
								+ selectedRouteId,
					}).done(function(data) {
						$('#tripDialogBusPlate').empty();
						$.each(data.busInfos,function() {$(
							'#tripDialogBusPlate')
							.append('<option value="' + this.id + '">'+ this.plateNumber+ '</option>');
						});
						$('#tripDialogBusPlateExtends').empty();
						$.each(data.busInfosExtend,function() {$(
							'#tripDialogBusPlateExtends')
							.append('<option value="' + this.id + '">'+ this.plateNumber+ '</option>');
						});
						checkButton();
					});
			} 
		};

		function getArrivalTime() {
			var selectedRouteId = $("#routeId").val();
			var departureTime = $("#tripDialogDepartureTime").val();
			if (selectedRouteId != '-1' && departureTime != "") {
			   	$.ajax(
					{url : $('#contextPath')
							.val()
							+ "/schedule/getArrivalTime.html?departureTime="
							+ departureTime
							+ "&routeId="
							+ selectedRouteId,
					}).done(function(data) {
						$("#tripDialogArrivalTime").val(data.arrivalTime);
					     var tempData = data.arrivalTime.split(" - "); 
					     var tempHour = tempData[0];
					     var tempDate = tempData[1];
					     var date = tempDate.split("/");
					     var newDate = new Date(date[2], parseInt(date[1]), parseInt(date[0]), parseInt(tempHour[1]) + 1, parseInt(tempHour[0]));
			           	 $("#autoReturnDialogDepartureTimeDiv").datetimepicker("setDate", newDate);
			             $("#autoReturnDialogDepartureTimeDiv").datetimepicker("setStartDate", newDate);
			             getAutoArrivalTime();
					});
			}
		}
		
		function getAutoArrivalTime() {
	         var selectedRouteId = $("#routeId").val();
	         var departureTime = $("#autoReturnDialogDepartureTime").val();
	         if (selectedRouteId != '-1' && departureTime != "") {
	        	$.ajax(
	            {
	            url : $('#contextPath').val()
	                  + "/schedule/getArrivalTime.html?departureTime="
	                  + departureTime
	                  + "&routeId="
	                  + selectedRouteId,
	            }).done(function(data) {
	               $("#autoReturnDialogArrivalTime").val(data.arrivalTime);
	            });
	         }
	    }
		
		$("#tripDialogBusType").change(function(){
			getAvailBus();
	    });

		$("#avaiBusList").change(function(){
/* 			var busInRoute = $("#tripDialogBusPlate").val();
			var busInStation = $("#tripDialogBusPlateExtends").val();
			var rb =  $('#avaiBusList').val();
			
			if(rb=="busInRoute"){
				busInRoute.show;
				busInStation.hide;
				
			} else {
				busInRoute.hide;
				busInStation.show;
			} */
		});
		

		$("#tripDialogBusPlate").change(function(){
      });
		
		$('#editRoute').bind('click', function(event){
			$("#editBusDialog").modal();
		});
		
		
		$('#addNewSchedule').bind('click',
			function(event) {
				var selectedRouteId = $("#routeId").val();
				$("#routeBeans").val(selectedRouteId);
				var departureTime = $("#tripDialogDepartureTime").val();
				var selectedBusType = $("#tripDialogBusType").val();
				var busPlate = $('#tripDialogBusPlate').val();
				var busPlateExtends = $('#tripDialogBusPlateExtends').val();
				
				var rb = $("input[name='avaiBusList']:checked").val();
				var form = $('#addNewTripForm');

				if (selectedRouteId == -1
						|| departureTime == ''
						|| !selectedBusType
						|| selectedBusType == -1) {
					return;
				}
				
				if( rb = "busInRoute"){
					if (!busPlateExtends || busPlateExtends == ''){
						return;
					}
				} else {
				 	if (!busPlate || busPlate == ''){
				 		return;
				 	}
				}
				
				event.preventDefault();
				$.ajax({
					type : "POST",
					url : $('#contextPath').val()
							+ "/schedule/"
							+ form.attr('action'),
					data : form.serialize(),
					success : function(response) {
						$('#CreateScheduleDialog').modal('hide');
						var url = window.location.toString();
	                     window.location = url;
					}
				});
			});

		$('#saveSuccessDialogOk').bind('click',function() {
			var url = $('#contextPath').val()
					+ "/schedule/list.html";
			window.location = url;
		});

		accounting.settings = {
			currency : {
				symbol : ".000", // default currency symbol is '$'
				format : "%v%s", // controls output: %s = symbol, %v = value/number (can be object: see below)
				decimal : ",", // decimal point separator
				thousand : ".", // thousands separator
				precision : 0
			// decimal places
			},
			number : {
				precision : 0, // default precision on numbers is 0
				thousand : ",",
				decimal : "."
			}
		};

		var segmentTable = $('#segmentTable').dataTable({
			"bSort" : false
		});
		
		var scheduleTable = $('#scheduleTable').dataTable();

		var priceTable = $('#priceTable').dataTable({
			"bSort" : false
		});

		var busDetailTable = $('#busDetailTable').dataTable({
			"bSort" : false
		});

		var editSegmentTable = $('#editSegmentTable').dataTable({
			"bSort" : false,
			"bPaginate" : false
		});

		$.each($("#editSegmentTable input"), function() {
			$("#" + this.id + "").keypress(function(event) {
				validate(event);
			});
		});

		$("#validDateDiv").datetimepicker({
			format : "hh:ii - dd/mm/yyyy",
			autoclose : true,
			todayBtn : true,
			startDate : new Date(),
			minuteStep : 10
		});
		
		$("#editPriceSave").bind('click',function() {
			info = {};
			var tariffs = [];
			$.each($("#editSegmentTable input"),
			function() {
				var tariff = {};
				tariff['segmentId'] = this.id;
				tariff['fare'] = this.value;
				tariffs.push(tariff);
			});
			info['routeId'] = $('#routeId').val();
			info['validDate'] = $('#validDate').val();
			info['tariffs'] = tariffs;
			info['busTypeId'] = $('#busTypes').val();
			info['addRevert'] = $("#addTariffRevRoute").is(':checked');
			updateTarrif(info);
		});

		$("#addBusPrice").click(function() {
			$.each($("#editSegmentTable input"),
			function() {$(this).val('');});
			$('#busTypes').val('-1');
			$('#validDateDiv').datetimepicker('setDate', (new Date()));
			$.ajax({
	            type : "GET",
	            url : 'getPreUpdateTariffAction.html?routeId=' + $("#routeId").val(),
	            contentType : "application/x-www-form-urlencoded; charset=utf-8",
	            success : function(response) {
	               $("#preUpdateTariffMessage").html(response.message);
	               $("#editPriceDialog").modal();
	            },
	            error : function() {
	               alert("Save new route failed!");
	            }
	         });
	        var busType = $('#busTypes').val();
	        var date = $('#validDate').val();
	        getPricePrefil(busType, segments, date);
		});

		$("#assignBus").click(function() {
			var routeId = $("#routeId").val();
			var busType = $("#busType").val();
			$("#addBus_BusType").val(busType);
			
			$.ajax({
				type : "GET",
				url : 'getBusInRoute.html?routeId='+ routeId+ '&type=' + busType,
						contentType : "application/x-www-form-urlencoded; charset=utf-8",
				success : function(response) {
					var busInRoute = response.busInRouteBeans;
					var busNotInRoute = response.busNotInRouteBeans;
					$('#busDetailTable').dataTable().fnClearTable();
					
   				$.each(busInRoute, function() {
   					if (this['delete'] == 'true') {
   					busDetailTable.dataTable().fnAddData([
   					   this.id,
   						this.plateNumber,
   						'<button type="button" data-id="'+ this.id +'" class="btn btn-danger btn-small">Delete</button>' ]);
   						$("#busDetailTable tr button[data-id="+ this.id+ "]").click(
	   						function() {
	   							$('#busDetailbusPlate').attr('disabled',false);
	   	                        $("#addBusError").text("");
	   							$("#busDetailAdd").addClass("btn-primary");    
	   			               	$("#busDetailAdd").removeAttr("disabled");
	   							var td = this.parentNode;
	   							var tr = td.parentNode;
	   							var aPos = busDetailTable.dataTable().fnGetPosition(td);
	   							var data = busDetailTable.fnGetData(tr);
	   							$('#busDetailbusPlate').append('<option value="'+ data[0] +'">'+ data[1]+ '</option>');
	   							busDetailTable.dataTable().fnDeleteRow(aPos[0]);
	   						}
   						);
   					} else {
   		            busDetailTable.dataTable().fnAddData([
   		               this.id,
   		               this.plateNumber,
   		               '<button type="button" data-id="'+ this.id +'" class="btn btn-small" disabled="disabled">Delete</button>' ]);
   		         };
   				});

					$('#busDetailbusPlate').empty();
					$.each(busNotInRoute,function() {
						$('#busDetailbusPlate').append(
						'<option value="'+ this.id +'">'+ this.plateNumber + '</option>');
						$('#busDetailbusPlate').attr('disabled',false);
						$("#addBusError").text("");
					});
					
					if ($("#busDetailbusPlate").val() == null || $("#busDetailbusPlate").val() == '') {
						$("#busDetailbusPlate").attr("disabled","disabled");
						$("#addBusError").text("There're no free bus at the moment!");
		                $("#busDetailAdd").removeClass("btn-primary");
		                $("#busDetailAdd").attr("disabled","disabled");
		            } else {
		            	$("#busDetailAdd").attr("disabled",false);
		                $("#busDetailAdd").addClass("btn-primary");    
		                $("#busDetailAdd").removeAttr("disabled");
		            }
					$("#busDetailDialog").modal();
				}
			});
		});

		$("#busDetailAdd").click(function() {
				var busId = $("#busDetailbusPlate").val();
				var plateNumber = $("#busDetailbusPlate option:selected").text();
				busDetailTable.dataTable().fnAddData([
					busId,plateNumber,
					'<button type="button" data-id="'+ busId +'" class="btn btn-danger btn-small">Delete</button>' ]);
				$("#busDetailbusPlate option[value="+ busId + "]").remove();
				$("#busDetailTable tr button[data-id="+ busId + "]").click(
				function() {
					var td = this.parentNode;
					var tr = td.parentNode;
					var aPos = busDetailTable.dataTable().fnGetPosition(td);
					var data = busDetailTable.fnGetData(tr);
					$('#busDetailbusPlate').append('<option value="'+ data[0] +'">'+ data[1]+ '</option>');
					busDetailTable.dataTable().fnDeleteRow(aPos[0]);
					$("#busDetailAdd").addClass("btn-primary");
					$("#busDetailAdd").attr("disabled",false); 
					$('#busDetailbusPlate').attr('disabled',false);
                    $("#addBusError").text("");
				});
				if ($("#busDetailbusPlate").val() == null || $("#busDetailbusPlate").val() == '') {
		               $("#busDetailbusPlate").attr("disabled","disabled");
		      } else {
		    	  $("#busDetailbusPlate").attr("disabled",false);
		      }
		});

		$("#busDetailAdd").bind('click', function(){
			var busId = $("#busDetailbusPlate").val();
			if (busId == null || busId == '') {
				$("#busDetailbusPlate").attr("disabled","disabled");
				$("#addBusError").text("There're no free bus at the moment!");
				$("#busDetailbusPlate").attr("disabled","disabled");
				$("#busDetailAdd").removeClass("btn-primary");
	         $("#busDetailAdd").attr("disabled","disabled");
	      } 
		});
		
		$("#autoReturnBus").attr("checked", false);
		$("#autoReturnBus").bind('click', function(){
			if($('#autoReturnBus').is(':checked')){
				$('#autoReturnDiv').show();
			} else{
				$('#autoReturnDiv').hide();
			}
		});
		
		$("#busDetailSave").click(
			function() {
				var routeId = $("#routeId").val();
				var busInfos = [];
				var unSelectBusInfos = [];
				$.each($("#busDetailTable tr.odd,#busDetailTable .even"),
					function() {
						var bus = {};
						if ($(this.cells[0]).html() != 'No data available in table') {
							bus['id'] = $(this.cells[0]).html();
							bus['plateNumber'] = $(this.cells[1]).html();
							busInfos.push(bus);
						}
					});

				$.each($("#busDetailbusPlate option"), function() {
					var unSelectBus = {};
					unSelectBus['id'] = this.value;
					unSelectBus['plateNumber'] = "0";
					unSelectBusInfos.push(unSelectBus);
				});

				var busDetailInfo = {};
				busDetailInfo['routeId'] = routeId;
				busDetailInfo['bus'] = busInfos;
				busDetailInfo['unSelectBus'] = unSelectBusInfos;

				$.ajax({
					type : "POST",
					url : 'saveBusDetail.html',
					contentType : "application/x-www-form-urlencoded; charset=utf-8",
					data : {data : JSON.stringify(busDetailInfo)
					},
					success : function(response) {
						var url = $('#contextPath').val() + "/route/route-detail-list.html?routeId="
						+ $('#routeId').val();
						window.location = url;
					}
				});
			});


		$('#return').bind('click', function() {
			var url = $('#contextPath').val() + "/route/list.html";
			window.location = url;
		});
		
		$('#reverseRoute').bind('click', function() {
			var url = $('#contextPath').val() + "/route/route-detail-list.html?routeId="
			+ $('#reverseRouteId').val();
			window.location = url;
		});

		validateBusType();
		$('#busType').bind('change', function() {
	         var busType = $('#busType').val();
	         var date = $('#validDateSelect').val();
	         getPrice(busType, segments, date);
	         validateBusType();
	      });
		
		$('#busType').bind('change', function() {
			var busType = $('#busType').val();
			var date = $('#validDateSelect').val();
			getPrice(busType, segments, date);
		});
		
		$("#addBus_BusType").bind('change', function() {
         var routeId = $("#routeId").val();
         var busType = $("#addBus_BusType").val();
         $('#busType').val(busType);
         var date = $('#validDateSelect').val();
         getPrice(busType, segments, date);
         $.ajax({
            type : "GET",
            url : 'getBusInRoute.html?routeId='+ routeId+ '&type=' + busType,
                  contentType : "application/x-www-form-urlencoded; charset=utf-8",
            success : function(response) {
               var busInRoute = response.busInRouteBeans;
               var busNotInRoute = response.busNotInRouteBeans;
               $('#busDetailTable').dataTable().fnClearTable();
               
               $.each(busInRoute, function() {
                  if (this['delete'] == 'true') {
                  busDetailTable.dataTable().fnAddData([
                     this.id,
                     this.plateNumber,
                     '<button type="button" data-id="'+ this.id +'" class="btn btn-danger">Delete</button>' ]);
                     $("#busDetailTable tr button[data-id="+ this.id+ "]").click(
                     function() {
                        var td = this.parentNode;
                        var tr = td.parentNode;
                        var aPos = busDetailTable.dataTable().fnGetPosition(td);
                        var data = busDetailTable.fnGetData(tr);
                        $('#busDetailbusPlate').append('<option value="'+ data[0] +'">'+ data[1]+ '</option>');
                           busDetailTable.dataTable().fnDeleteRow(aPos[0]);
                           $('#busDetailbusPlate').attr('disabled',false);
                           $("#addBusError").text("");
                           $("#busDetailAdd").addClass("btn-primary");    
                           $("#busDetailAdd").removeAttr("disabled");
                     });
                  } else {
                     busDetailTable.dataTable().fnAddData([
                        this.id,
                        this.plateNumber,
                        '<button type="button" data-id="'+ this.id +'" disabled="disabled">Delete</button>' ]);
                  };
               });

               $('#busDetailbusPlate').empty();
               $.each(busNotInRoute,function() {$('#busDetailbusPlate').append(
                  '<option value="'+ this.id +'">'+ this.plateNumber + '</option>');
               });
               if ($("#busDetailbusPlate").val() == null || $("#busDetailbusPlate").val() == '') {
            	   $("#busDetailbusPlate").attr("disabled","disabled");
				   $("#addBusError").text("There're no free bus at the moment!");
                   $("#busDetailAdd").removeClass("btn-primary");
                   $("#busDetailAdd").attr("disabled","disabled");
               } else {
            	   $('#busDetailbusPlate').attr('disabled',false);
                   $("#addBusError").text("");
                   $("#busDetailAdd").addClass("btn-primary");    
                   $("#busDetailAdd").removeAttr("disabled");
              }
            }
         });
      });
		
	    $('#validDateSelect').bind('change', function() {
	         var busType = $('#busType').val();
	         var date = $('#validDateSelect').val();
	         getPrice(busType, segments, date);
	         getSegmentDuration(segments, date);
	    });

	    $('#validDate').bind('change', function() {
	         var busType = $('#busTypes').val();
	         var date = $('#validDate').val();
	         getPricePrefil(busType, segments, date);
	    });    
		
		var busType = $('#busType').val();
		getPrice(busType, segments, $('#validDateSelect').val());
		
		if (active == 'false') {
			$("#addBusPrice").removeClass('btn-primary');
			$("#assignBus").removeClass('btn-primary');
			$("#busStatusInsertBtn").removeClass('btn-success');
			$("#editRoute").removeClass('btn-warning');
			$("#addBusPrice").attr("disabled","disabled");
			$("#assignBus").attr("disabled","disabled");
			$("#busStatusInsertBtn").attr("disabled","disabled");
			$("#editRoute").attr("disabled","disabled");
		}
		
		///SELECT 2
// 		$("#startAt").select2();
// 		$("#endAt").select2();
	});

	function validateBusType(){
		var busType = $("#busType").val();
		if (busType == null || busType == -1) {
			$("#assignBus").removeClass('btn-primary');
			$("#assignBus").attr("disabled","disabled");
			$("#busStatusInsertBtn").removeClass('btn-success');
			$("#busStatusInsertBtn").attr("disabled","disabled");
		} else {
			$("#assignBus").addClass('btn-primary');
			$("#assignBus").removeAttr("disabled"); 
			$("#busStatusInsertBtn").addClass('btn-success');
			$("#busStatusInsertBtn").removeAttr("disabled"); 
		}
	}
		
	function getSegmentDuration(segments, date) {
      var info = {};
      info['segments'] = segments;
      info['validDate'] = date;
      $.ajax({
         type : "POST",
         url : 'getSegmentDur.html',
         contentType : "application/x-www-form-urlencoded; charset=utf-8",
         data : {data : JSON.stringify(info)},
         success : function(response) {
            var data = response.segmentInfos;
            for ( var i = 0; i < data.length; i++) {
               element = data[i].duration;
               $('#segmentTable').dataTable().fnUpdate(element,i,3);
            };
         }
      });
   };
   
   function getPricePrefil(busType, segments, date) {
		var info = {};
		info['busType'] = busType;
		info['segments'] = segments;
		info['validDate'] = date;
		$.ajax({
			type : "POST",
			url : 'getPrice.html',
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			data : {data : JSON.stringify(info)},
			success : function(response) {
				var data = response.tariffInfos;
				var temp = 0;
				$("#editSegmentTable input").each(function(){
					element = data[temp];
					if(element.fare != 0){
						$(this).val(element.fare);
					} else {
						$(this).val("50");
					}
				    
				    temp++;
				});			
			}
		});
	};
	
	function checkButton(){
		var rb = $("input[name='avaiBusList']:checked").val();
        var busPlate = $('#tripDialogBusPlate').val();
        var busPlateExtend = $('#tripDialogBusPlateExtends').val();
        var addNewSchedule = $("#addNewSchedule");
		
        if(rb == "busInRoute"){
            if(busPlate != '' && busPlate != null){
            	$("#addScheduleError").text("");
            	addNewSchedule.addClass("btn-primary");
            	addNewSchedule.removeAttr("disabled"); 
            	$("#schedule-error").hide();
            } else { 
            	$("#addScheduleError").text("There is no available bus at this time. Please select other time or click cancel!");
            	$("#schedule-error").show();
            	addNewSchedule.removeClass('btn-primary');
            	addNewSchedule.attr("disabled","disabled");
            }
        } else {
        	if(busPlateExtend != '' && busPlateExtend != null){
            	$("#addScheduleError").text("");
            	addNewSchedule.addClass("btn-primary");
            	addNewSchedule.removeAttr("disabled"); 
            	$("#schedule-error").hide();
            } else { 
            	$("#addScheduleError").text("There is no available bus at this time. Please select other time or click cancel!");
            	$("#schedule-error").show();
            	addNewSchedule.removeClass('btn-primary');
            	addNewSchedule.attr("disabled","disabled");
            }
        }
	}
	
	function getPrice(busType, segments, date) {
		var info = {};
		info['busType'] = busType;
		info['segments'] = segments;
		info['validDate'] = date;
		$.ajax({
			type : "POST",
			url : 'getPrice.html',
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			data : {data : JSON.stringify(info)},
			success : function(response) {
				var data = response.tariffInfos;
				var totalMoney = 0;
				
				for ( var i = 0; i < $('#segmentTable').dataTable().length; i++) {
					  $('#segmentTable').dataTable().fnUpdate(0,i,2);
				}
				
				for ( var i = 0; i < data.length; i++) {
					element = data[i];
					totalMoney += element.fare;
					$('#segmentTable').dataTable().fnUpdate(accounting.formatMoney(element.fare),i,2);
				};
				
				if (totalMoney != 0) {
					  $('#totalMoney').html(accounting.formatMoney(totalMoney));
				} else {
					$('#totalMoney').html(0);
				};
			}
		});
	};


	var segments = [];
	


