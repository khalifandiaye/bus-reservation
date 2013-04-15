<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC 
   "-//W3C//DTD XHTML 1.1 Transitional//EN"
   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>VinaBus - Route details</title> 
<jsp:include page="../common/xheader.jsp" />
<link href="<%=request.getContextPath()%>/styles/trip/datetimepicker.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/index.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery.dataTables.min.js"></script>
<script src="<%=request.getContextPath()%>/js/accounting.min.js"></script>
<script src="<%=request.getContextPath()%>/js/bootstrap-datetimepicker.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/styles/custom-data-table.css" />
<script src="<%=request.getContextPath()%>/js/common/custom-data-table.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/styles/jquery-ui.css" />
<script src="<%=request.getContextPath()%>/js/jquery-ui.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery.ui.datepicker-vi.js"></script>
<script src="<%=request.getContextPath()%>/js/route/route-detail-list.js"></script>
<script type="text/javascript">
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
		key = String.fromCharCode(key);
		var regex = /[0-9]/;
		if (!regex.test(key)) {
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
	
	$(document).ready(function() {
		checkBusType();
		var active = $("#active").val();
		
		if (active == 'false') {
			$("#addBusPrice").removeClass('btn-primary');
			$("#assignBus").removeClass('btn-primary');
			$("#busStatusInsertBtn").removeClass('btn-success');
			$("#addBusPrice").attr("disabled","disabled");
			$("#assignBus").attr("disabled","disabled");
			$("#busStatusInsertBtn").attr("disabled","disabled");
		}
		

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
			$("#addNewSchedule").removeClass('btn-success');
			$("#addNewSchedule").attr("disabled","disabled");
			$('#tripDialogRoutes').val(-1);
			$('#tripDialogDepartureTime').val('');
			$('#tripDialogArrivalTime').val('');
			$('#tripDialogBusPlate').empty();
			$('#addScheduleError').empty();
			$('#CreateScheduleDialog').modal();
			$('#tripEditDialogLabel').html("Add New Schedule");
			
			$("#tripDialogDepartureTimeDiv").datetimepicker({
				format : "hh:ii - dd/mm/yyyy",
				autoclose : true,
				todayBtn : false,
				startDate : date,
				minuteStep : 10
			}).on('changeDate', function(ev) {
				getAvailBus();
				getArrivalTime();
				checkButton();
			});
			
			$("#tripDialogDepartureTimeDiv").datetimepicker("setDate", date);
			getArrivalTime();
			getAvailBus();
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
						checkButton();
					});
			} 
		};

		function getArrivalTime() {
			var selectedRouteId = $("#routeId").val();
			var departureTime = $("#tripDialogDepartureTime").val();
			if (selectedRouteId != '-1' && departureTime != "") {$.ajax(
				{
					url : $('#contextPath')
							.val()
							+ "/schedule/getArrivalTime.html?departureTime="
							+ departureTime
							+ "&routeId="
							+ selectedRouteId,
				}).done(function(data) {
					$("#tripDialogArrivalTime").val(data.arrivalTime);
				});
			}
		}
		   
		function checkButton(){
            var departureTime = $("#tripDialogDepartureTime").val();
            var busPlate = $('#tripDialogBusPlate').val();
            var addNewSchedule = $("#addNewSchedule");

            if(busPlate != '' && busPlate != null){
            	$("#addScheduleError").text("");
            	addNewSchedule.addClass("btn-primary");
            	addNewSchedule.removeAttr("disabled"); 
            } else { 
            	$("#addScheduleError").text("There're no bus available at this time. Please select other time or click cancel!");
            	addNewSchedule.removeClass('btn-primary');
            	addNewSchedule.attr("disabled","disabled");
            }
		}
		
		$("#tripDialogBusType").change(function(){
			getAvailBus();
	      /* checkButton(); */
	   });
		
		$("#tripDialogBusPlate").change(function(){
	      /* checkButton();  */
      });
		
		$('#cancelAdd').bind('click', function() {
			$("#tripDialogRoutes").val(-1);
			$("#tripDialogDepartureTime").val('');
			$("#tripDialogArrivalTime").val('');
			$('#tripDialogBusPlate').val('');
		});

		$('#addNewSchedule').bind('click',
			function(event) {
				var selectedRouteId = $("#routeId").val();
				$("#routeBeans").val(selectedRouteId);
				var departureTime = $("#tripDialogDepartureTime").val();
				var selectedBusType = $("#tripDialogBusType").val();
				var busPlate = $('#tripDialogBusPlate').val();
				var form = $('#addNewTripForm');

				if (selectedRouteId == -1
						|| departureTime == ''
						|| !selectedBusType
						|| selectedBusType == -1
						|| !busPlate || busPlate == '') {
					return;
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
			"bSort" : false
		});

		$.each($("#editSegmentTable input"), function() {
			$("#" + this.id + "").keypress(function(event) {
				validate(event);
			});
		});

		$("#validDateDiv").datetimepicker({
			format : "yyyy/mm/dd - hh:ii",
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
   						'<button type="button" style="width: 56px !important; height: 24px !important;" data-id="'+ this.id +'" class="btn btn-danger">Delete</button>' ]);
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
   						});
   					} else {
   		            busDetailTable.dataTable().fnAddData([
   		               this.id,
   		               this.plateNumber,
   		               '<button type="button" style="width: 56px !important; height: 24px !important;" data-id="'+ this.id +'" disabled="disabled">Delete</button>' ]);
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
                           $("$addBusError").text("");
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
                   $("$addBusError").text("");
                   $("#busDetailAdd").addClass("btn-primary");    
                   $("#busDetailAdd").removeAttr("disabled");
              }
            }
         });
      });
		
	    $('#validDate').bind('change', function() {
	         var busType = $('#busTypes').val();
	         var date = $('#validDate').val();
	         getPricePrefil(busType, segments, date);
	    });    
	    
		
		var busType = $('#busType').val();
		getPrice(busType, segments, $('#validDateSelect').val());
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
				    $(this).val(element.fare);
				    temp++;
				});			
			}
		});
	};
	
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
</script>
<style type="text/css">
.dataTables_filter {
	display: none;
}

.dataTables_length {
	display: none;
}

.dataTables_info {
	display: none;
}

#scheduleTable_filter {
   display: table-header-group !important;  
}

#scheduleTable_info {
   display: table !important;
}

#editPriceDialog {
	width: 900px;
	margin-left: -440px;
}

#busDetailDialog {
   width: 700px;
   margin-left: -360px;
}
</style>
</head>
<body>
   <jsp:include page="../common/header.jsp" />
   <jsp:include page="../common/menu.jsp" />
   <div id="page" class="well">
  		<h3 style="border-bottom: 1px solid #ddd; margin-bottom: 20px;">    
				Route details
         <table class="pull-right">
            <tr>
               <td><input class="btn btn-primary" type="button" id="addBusPrice" value="Add Bus Price"
                  style="height: 30px" /> <input class="btn btn-primary" id="assignBus" type="button"
                  value="Assign Bus to Route" style="height: 30px" /> 
                  <s:if test="%{haveBus == true}">
                     <input id="busStatusInsertBtn" type="button" class="btn btn-success" value="Add New Schedule"
                        style="height: 30px" />
                  </s:if>
                  <s:else>
                     <button class="btn" disabled="disabled" value="Add New Schedule" style="height: 30px">Add New Schedule</button>
                  </s:else></td>
            </tr>
         </table>
      </h3>  
      <div class="post">
         <div style="margin-top: 10px;">
            <input type="hidden" id="routeId" value="<s:property value='routeId'/>" />
            <input type="hidden" id="active" value="<s:property value='active'/>" />
            <table class="pull-right">
               <tr>
                  <td><s:select id="busType" list="busTypeBeans" name="busTypeBeans" listKey="id"
                           listValue="name" /></td>
                  <td>
                      <input type="text" id="validDateSelect" name="departureDate" readonly>
                  </td>
               </tr>
            </table>
         </div>
         <h3>
            <s:property value="routeName" />
         </h3>
         <table id="segmentTable" align="center" class="table table-striped table-bordered dataTable" style="margin-top:20px;background-color: #fff">
            <thead>
               <tr>
                  <th style="text-align: center; width: 391px !important;">Name</th>  
                  <th style="text-align: center; width: 176px !important;">Travel Time</th>
                  <th style="text-align: center; width: 209px !important;">Price (VNĐ)</th>
               </tr>
            </thead>
            <tbody>
               <s:iterator value="segmentInfos">
                  <tr id="segment_<s:property value='id'/>" data-segment-id="<s:property value='id'/>">
                     <td><s:property value="name" /></td>
                     <td style="text-align: center;"><s:property value="duration"/></td>
                     <td style="padding-right:100px; text-align: right"><s:property value="price"/></td>
                  </tr>
               </s:iterator>
            </tbody>
            <tfoot>
               <tr>
                  <td style="text-align: right; font-weight:bold;">Total : </td>
                  <td style="text-align: center; font-weight:bold;"><s:property value='sumaryTime'/></td>
                  <td style="text-align: right;padding-right:100px; font-weight:bold;">
                     <label id="totalMoney" style="font-weight:bold;"></label>
                  </td>
               </tr>
            </tfoot>
         </table>
         </br>
         <h3>
            Schedule
         </h3>
         <table id="scheduleTable" align="center" class="table table-striped table-bordered dataTable" style="margin-top:20px;background-color: #fff">
            <thead>
               <tr>
                  <th>Bus Plate Number</th>
                  <th>Bus Type</th>
                  <th>From Date</th>
                  <th>To Date</th>
                  <th>Cancel</th>
               </tr>
            </thead>
            <tbody>
               <s:iterator value="busStatusBeans">
                  <tr>
                     <td><s:property value="bus.plateNumber" /></td>
                     <td><s:property value="bus.busType.name" /></td>
                     <td><s:date name="fromDate" format="hh:mm - dd/MM/yyyy" /></td>
                     <td><s:date name="toDate" format="hh:mm - dd/MM/yyyy" /></td>
                     <td><s:if test="%{status == 'active'}"><s:hidden name="id" value="%{id}" /><a class="btn btn-danger btn-small btn-cancel" >Cancel</a></s:if><s:elseif test="status == 'cancelled'">Cancelled</s:elseif></td>
                  </tr>
               </s:iterator>
            </tbody>
         </table>
         <br/>
         <div style="margin-bottom: 10px;">
            <input class="btn btn-primary" type="button" id="return" value="Return to Route List" />
            <input type="hidden" id="reverseRouteId" value="<s:property value='reverseRouteId'/>" />
            <input class="btn btn-primary" type="button" id="reverseRoute" value="Show the reverse route" />
         </div>
      </div>
   </div>
   
   <!-- Modal Assign bus Dialog -->
   <div id="busDetailDialog" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
      aria-hidden="true">
      <div class="modal-header">
         <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
         <h3 id="busDetailDialogLabel">List Bus In Route</h3>
      </div>
      <div class="modal-body">
         <table>
            <tr>
               <td>Bus Type : </td>
               <td><s:select id="addBus_BusType" list="busTypeBeans" name="busTypes" listKey="id" listValue="name"/><br/></td>
               <td>Select bus : </td>
               <td><select id='busDetailbusPlate' name='busDetailbusPlate'></select></td>
               <td><button style="margin-top: -8px;" type="button" id="busDetailAdd" class="btn btn-primary">Add</button></td>
            </tr>
         </table>
         <label id="addBusError" style="margin-left: 297px; color: red;"></label>
         <table id="busDetailTable" align="center" class="table table-striped table-bordered dataTable" style="margin-top:20px;background-color: #fff">
            <thead>
               <tr>
                  <th>Bus Id</th>
                  <th>Plate Number</th>
                  <th></th>
               </tr>
            </thead>
            <tbody>
            </tbody>
         </table>
      </div>
      <div class="modal-footer">
         <button type="button" class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
         <button id="busDetailSave" class="btn btn-primary" data-dismiss="modal" aria-hidden="true">Save</button>
      </div>
   </div>
   
   <!-- Modal Show Edit Price -->
   <div id="editPriceDialog" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
      aria-hidden="true">
      <div class="modal-header">
         <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
         <h3 id="editPriceDialogLabel">List Bus In Route</h3>
      </div>
      <div class="modal-body">
         <div class="post" style="margin: 0px auto; width: 95%;">
         <label id="preUpdateTariffMessage" style="width: 65%"></label>
            <table>
               <tr>
                  <td style="width: 65%">Valid date :
                     <input id="validDate" type="text" name="tripDialogDepartureTime" readonly/>
                  </td>
                  <td>Select bus type :
                     <div class="input-append date form_datetime">
                        <s:select id="busTypes" list="busTypes"
                           name="busTypes" listKey="id" listValue="name" />
                     </div>
                  </td>
               </tr>
            </table>
            <table id="editSegmentTable" class="table table-striped table-bordered dataTable" style="margin-top:20px;background-color: #fff">
               <thead>
                  <tr>
                     <th>Start At</th>
                     <th>End At</th>
                     <th>Price (VND)</th>
                  </tr>
               <thead>
               <tbody>
                  <s:iterator value="segmentBeans">
                     <tr>
                        <td><s:property value="startAt.name" /></td>
                        <td><s:property value="endAt.name" /></td>
                        <td><input id="<s:property value='id'/>" type="text" value="" maxlength="7" style="text-align: right;margin: 0" /> .000</td>
                     </tr>
                  </s:iterator>
               </tbody>
            </table>
            <div><input type="checkbox" id="addTariffRevRoute" style="margin-top: -4px;"/> Add price for reverse route too?</div>
            <p id="preUpdateTariffMessage" style="color: red"></p>
         </div>
      </div>
      <div class="modal-footer">
         <button type="button" class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
         <button id="editPriceSave" class="btn btn-primary" data-dismiss="modal" aria-hidden="true">Save</button>
      </div>
   </div>
   
   <!-- Modal add new schedule-->
   <div id="CreateScheduleDialog" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
      aria-hidden="true">
      <form id="addNewTripForm" action="save.html" method="POST">
         <input id="routeBeans" size="16" type="hidden" value="" readonly name="routeBeans">
         <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h3 id="tripEditDialogLabel"></h3>
         </div>
         <div class="modal-body">
            <label for="tripDialogDepartureTimeDiv">From Date: </label>
            <div id="tripDialogDepartureTimeDiv" class="input-append date form_datetime" data-date="">
               <input id="tripDialogDepartureTime" size="16" type="text" value="" readonly
                  name="tripDialogDepartureTime"><span
                  class="add-on"><i class="icon-calendar"></i></span>
            </div>
            <label for="tripDialogArrivalTimeDiv">To Date: </label>
            <div id="tripDialogArrivalTimeDiv" class="input-append date form_datetime" data-date="">
               <input id="tripDialogArrivalTime" size="16" type="text" value="" readonly>
            </div>
            <label for="tripDialogBusType">Bus Type: </label> <select id="tripDialogBusType" name="busTypeBeans">
               <option value="-1">Select Bus Type</option>
            </select>
            <div id="trip-plate-number"> 
               <label for="routeSelect">Bus Plate Number</label> <select id='tripDialogBusPlate'
                  name='tripDialogBusPlate'></select>
            </div>
            <div id="tripDialogStatus"></div>
         </div>
         <div>
         	<label id="addScheduleError" style="color: red; margin-left: 15px;"></label>
         </div>
         <div class="modal-footer">
            <button class="btn" id="cancelAdd" data-dismiss="modal" aria-hidden="true">Cancel</button> 
            <input disabled="disabled" type="button" id="addNewSchedule" class="btn btn-primary" value='Save changes' />
         </div>
      </form>
   </div>
   
   <jsp:include page="../common/footer.jsp" />
   
	<!-- Cancel modal -->
	<div id="cancelModal" class="modal hide fade">
		<input type="hidden" name="cancelBusStatusId" />
		<div class="modal-header">
			<button type="button" class="close close-model-btn">×</button>
			<h3 id="myModalLabel"><s:text name="header.cancelReservation" /></h3>
		</div>
		<div class="modal-body">
			Reason <s:textfield label="Reason" name="reason" value="" /><span style="padding-left: 3px; color: red; font-size: 22px;">*</span>
			<div id="message"></div>
		</div>
		<div class="modal-footer">
			<button id="btnClose" class="btn close-model-btn">Close</button>
			<button id="btnRetry" class="btn close-model-btn btn-danger">Retry</button>
			<button id="btnNo" class="btn close-model-btn">No</button>
			<button id="btnCancel" class="btn btn-danger">Yes</button>
		</div>
	</div>
</body>
</html>
