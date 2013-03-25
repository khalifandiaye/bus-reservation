<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC 
   "-//W3C//DTD XHTML 1.1 Transitional//EN"
   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Test page</title>
<jsp:include page="../common/xheader.jsp" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/styles/trip/jquery.dataTables.css">
<link href="<%=request.getContextPath()%>/styles/trip/datetimepicker.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/index.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery.dataTables.min.js"></script>
<script src="<%=request.getContextPath()%>/js/accounting.min.js"></script>
<script src="<%=request.getContextPath()%>/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript">
	function validate(evt) {
		var theEvent = evt || window.event;
		var key = theEvent.keyCode || theEvent.which;
		if (theEvent.keyCode != 0) {
			return;
		}
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
				alert(response);
				var url = $('#contextPath').val() + "/route/route-detail-list.html?routeId="
						+ $('#routeId').val();
				window.location = url;
			},
			error : function() {
				alert("Save new route failed!");
			}
		});
	}

	$(document).ready(function() {
		var selectedRouteId = $("#routeId").val();
		if (selectedRouteId != '-1') 
		{$.ajax({url : $('#contextPath').val()
			+ "/schedule/busTypes.html?&routeId="
			+ selectedRouteId,}).done(
			function(data) {$('#tripDialogBusType').empty();
				$.each(data.busTypeInfos,function() {
					   $('#tripDialogBusType').append('<option value="' + this.id + '">'
							+ this.type
							+ '</option>');
				});
			});
		};

		$('#busStatusInsertBtn').click(function() {
			var date = new Date();
			date.setDate(date.getDate() + 1);
			$("#addNewSchedule").attr("disabled","disabled");
			$('#tripDialogRoutes').val(-1);
			$('#tripDialogDepartureTime').val('');
			$('#tripDialogArrivalTime').val('');
			$('#tripDialogBusPlate').empty();
			$('#CreateScheduleDialog').modal();
			$('#tripEditDialogLabel').html("Add New Schedule");
			$("#tripDialogDepartureTimeDiv").datetimepicker({
				format : "yyyy/mm/dd - hh:ii",
				autoclose : true,
				todayBtn : false,
				startDate : date,
				minuteStep : 10
			}).on('changeDate', function(ev) {
				getAvailBus();
				getArrivalTime();
				checkButton();
			});
			
			$("#tripDialogDepartureTimeDiv").datetimepicker("setDate", new Date());
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
					});
			} 
			checkButton();
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

            if(departureTime != "" && busPlate != null && busPlate != ''){
            	addNewSchedule.removeAttr("disabled"); 
            } else { 
            	addNewSchedule.attr("disabled","disabled");
            }
		}
		
		$("#tripDialogBusType").change(function(){
	      checkButton();
	   });
		
		$("#tripDialogBusPlate").change(function(){
	      checkButton(); 
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
						alert(response);
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
				symbol : ".000 VNĐ", // default currency symbol is '$'
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
		
		$("#validDateSelectDiv").datetimepicker({
	      format : "yyyy/mm/dd - hh:ii",
	      autoclose : true,
	      todayBtn : true,
	      startDate : new Date(),
	      minuteStep : 10
	   });
		$('#validDateSelectDiv').datetimepicker("setDate", new Date() );

		$("#editPriceSave").bind('click',function() {
			var info = {};
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
			$.ajax({
				type : "GET",
				url : 'getPreUpdateTariffAction.html?routeId=' + $("#routeId").val(),
				contentType : "application/x-www-form-urlencoded; charset=utf-8",
				success : function(response) {
					if (response.message.trim() != '') {
						var result = confirm(response.message);
						if (result == true) {
							updateTarrif(info);
						}
					}
				},
				error : function() {
					alert("Save new route failed!");
				}
			})
		});

		$("#addBusPrice").click(function() {
			$.each($("#editSegmentTable input"),
			function() {$(this).val('');});
			$('#busTypes').val('-1');
			$('#validDateDiv').datetimepicker('setDate', (new Date()));
			$("#editPriceDialog").modal();
		});

		$("#assignBus").click(function() {
			var routeId = $("#routeId").val();
			var busType = $("#busType").val();
			$.ajax({
				type : "GET",
				url : 'getBusInRoute.html?routeId='+ routeId+ '&type='+ busType,contentType : "application/x-www-form-urlencoded; charset=utf-8",
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
   							});
   					} else {
   		            busDetailTable.dataTable().fnAddData([
   		               this.id,
   		               this.plateNumber,
   		               '<button type="button" data-id="'+ this.id +'" class="btn btn-danger" disabled="disabled">Delete</button>' ]);
   		         };
   				});

					$('#busDetailbusPlate').empty();
					$.each(busNotInRoute,function() {$('#busDetailbusPlate').append(
						'<option value="'+ this.id +'">'+ this.plateNumber + '</option>');
					});
					$("#busDetailDialog").modal();
				}
			});
		});

		$("#busDetailAdd").click(function() {
				var busId = $("#busDetailbusPlate").val();
				if (!busId || busId == '') {
					return;
				}
				var plateNumber = $("#busDetailbusPlate option:selected").text();
				busDetailTable.dataTable().fnAddData([
					busId,plateNumber,
					'<button type="button" data-id="'+ busId +'" class="btn btn-danger">Delete</button>' ]);
				$("#busDetailbusPlate option[value="+ busId + "]").remove();
				$("#busDetailTable tr button[data-id="+ busId + "]").click(
				function() {
					var td = this.parentNode;
					var tr = td.parentNode;
					var aPos = busDetailTable.dataTable().fnGetPosition(td);
					var data = busDetailTable.fnGetData(tr);
					$('#busDetailbusPlate').append('<option value="'+ data[0] +'">'+ data[1]+ '</option>');
					busDetailTable.dataTable().fnDeleteRow(aPos[0]);
				});
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
						alert(response);
					}
				});
			});

// 		$('#viewPrice').click(function() {
// 			$("#priceDialog").modal();
// 		});

		$('#return').bind('click', function() {
			var url = $('#contextPath').val() + "/route/list.html";
			window.location = url;
		});

		$('tr[data-segment-id]').each(function() {
			var id = this.dataset.segmentId;
			var segment = {};
			segment['id'] = id;
			segments.push(segment);
		});

		$('#busType').bind('change', function() {
			var busType = $('#busType').val();
			var date = $('#validDateSelect').val();
			getPrice(busType, segments, date);
		});

	    $('#validDateSelect').bind('change', function() {
	         var busType = $('#busType').val();
	         var date = $('#validDateSelect').val();
	         getPrice(busType, segments, date);
	    });
		
		var busType = $('#busType').val();
		getPrice(busType, segments, $('#validDateSelect').val());
	});

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
				for ( var i = 0; i < data.length; i++) {
					element = data[i];
					$('#segmentTable').dataTable().fnUpdate(accounting.formatMoney(element.fare),i,2);
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

.dataTables_paginate {
	display: none;
}

#editPriceDialog {
	width: 900px;
	margin-left: -440px;
}
</style>
</head>
<body>
   <jsp:include page="../common/header.jsp" />
   <jsp:include page="../common/menu.jsp" />
   <div id="page">
      <div class="post" style="margin: 0px auto; width: 95%;">
         <div style="margin-left: 10px; margin-top: 10px;">
            <input type="hidden" id="routeId" value="<s:property value='routeId'/>" />
            <table>
               <tr>
                  <td><s:select id="busType" list="busTypeBeans" name="busTypeBeans" listKey="id"
                           listValue="name" /></td>
                  <td><div id="validDateSelectDiv" class="input-append date form_datetime" data-date="" style="margin-top: -8px;">
                        <input id="validDateSelect" size="16" type="text" value="" readonly ><span
                           class="add-on"><i class="icon-calendar"></i></span>
                     </div></td>
               </tr>
            </table>
            <table>
               <tr>
                  <td><input class="btn btn-primary" type="button" id="addBusPrice" value="Add Bus Price"
                        style="height: 30px" />
<!--                   <input class="btn btn-primary" type="button" id="viewPrice" value="View Price" style="height: 30px"/> -->
                  <input class="btn btn-primary" id="assignBus" type="button" value="Assign Bus to Route" style="height: 30px"/>
                  <input id="busStatusInsertBtn" type="button" class="btn btn-success" value="Add New Schedule" style="height: 30px"/></td>
               </tr>
            </table>
         </div>
         <h3>
            <s:property value="routeName" />
         </h3>
         <table id="segmentTable">
            <thead>
               <tr>
                  <th>Name</th>
                  <th>Travel Time</th>
                  <th>Price</th>
               </tr>
            </thead>
            <tbody>
               <s:iterator value="segmentInfos">
                  <tr id="segment_<s:property value='id'/>" data-segment-id="<s:property value='id'/>">
                     <td><s:property value="name" /></td>
                     <td><s:property value="duration" /></td>
                     <td><s:property value="price" /></td>
                  </tr>
               </s:iterator>
            </tbody>
         </table>
         </br>
         <div style="margin-bottom: 10px;">
            <input class="btn btn-primary" type="button" id="return" value="Return to Route List" />
         </div>
      </div>
   </div>
   
   <!-- Modal Show Route Details Price By BusType Dialog -->
   <div id="busDetailDialog" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
      aria-hidden="true">
      <div class="modal-header">
         <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
         <h3 id="busDetailDialogLabel">List Bus In Route</h3>
      </div>
      <div class="modal-body">
         Select bus : <select id='busDetailbusPlate' name='busDetailBusPlate' style='margin-top: -6px;'></select>
         <button style="margin-top: -10px;" type="button" id="busDetailAdd" class="btn btn-primary">Add</button>
         <table id="busDetailTable">
            <thead>
               <tr>
                  <th>id</th>
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
            <table>
               <tr>
                  <td style="width: 65%">Valid date :
                     <div id="validDateDiv" class="input-append date form_datetime" data-date="">
                        <input id="validDate" size="16" type="text" value="" readonly name="tripDialogDepartureTime"><span
                           class="add-on"><i class="icon-calendar"></i></span>
                     </div>
                  </td>
                  <td>Select bus type :
                     <div class="input-append date form_datetime">
                        <s:select id="busTypes" headerKey="-1" headerValue="--- Select Bus Type ---" list="busTypes"
                           name="busTypes" listKey="id" listValue="name" />
                     </div>
                  </td>
               </tr>
            </table>
            <table id="editSegmentTable">
               <thead>
                  <tr>
                     <td>Start At</td>
                     <td>End At</td>
                     <td>Price</td>
                  </tr>
               <thead>
               <tbody>
                  <s:iterator value="segmentBeans">
                     <tr>
                        <td><s:property value="startAt.name" /></td>
                        <td><s:property value="endAt.name" /></td>
                        <td><input id="<s:property value='id'/>" type="text" value="" maxlength="7" style="text-align: right;" /> .000 VNĐ</td>
                     </tr>
                  </s:iterator>
               </tbody>
            </table>
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
            <%-- <div id="trip-route">
               <label id="trip-route-label" for="routeSelect">Select Route</label>
               <s:select id="tripDialogRoutes" headerKey="-1"
                  headerValue="--- Select Route ---" list="routeBeans"
                  name="routeBeans" listKey="id" listValue="name" />
            </div> --%>
            <label for="tripDialogDepartureTimeDiv">From Date: </label>
            <div id="tripDialogDepartureTimeDiv" class="input-append date form_datetime" data-date="">
               <input id="tripDialogDepartureTime" size="16" type="text" value="" readonly
                  name="tripDialogDepartureTime"> <span class="add-on"><i class="icon-remove"></i></span> <span
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
         <div class="modal-footer">
            <button class="btn" id="cancelAdd" data-dismiss="modal" aria-hidden="true">Cancel</button> 
            <input disabled="disabled" type="button" id="addNewSchedule" class="btn btn-primary" value='Save changes' />
         </div>
      </form>
   </div>
   <jsp:include page="../common/footer.jsp" />
</body>
</html>
