<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Test page</title>
<jsp:include page="../common/xheader.jsp" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/styles/trip/jquery.dataTables.css">
<link href="<%=request.getContextPath()%>/styles/trip/datetimepicker.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/index.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery.dataTables.min.js"></script>
<script src="<%=request.getContextPath()%>/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript">
	$(document).ready(
			function() {
				var oTable;
				oTable = $('#scheduleTable').dataTable();

				$('#BusStatusInsertBtn').click(function() {
					$('#CreateScheduleDialog').modal();
					$('#tripEditDialogLabel').html("Add New Schedule");
					$("#tripDialogDepartureTimeDiv").datetimepicker({
						format : "yyyy/mm/dd - hh:ii",
						autoclose : true,
						todayBtn : true,
						startDate : new Date(),
						minuteStep : 10
					}).on('changeDate', function(ev) {
						var d1 = new Date(ev.date);
						d1.setHours(d1.getHours() - 6);
						$('#tripDialogArrivalTime').datetimepicker('setStartDate', d1);
						
						var d2 = new Date(ev.date);
						d2.setMonth( d2.getMonth( ) + 1 );
						$('#tripDialogArrivalTime').datetimepicker('setEndDate', d2);
						
						getAvailBus();
					});

					$("#tripDialogArrivalTimeDiv").datetimepicker({
						format : "yyyy/mm/dd - hh:ii",
						autoclose : true,
						todayBtn : true,
						startDate : new Date(),
						minuteStep : 10
					});
				});
				
				$('#tripDialogBusType').change(function() {
					getAvailBus();
				});
				
				function getAvailBus() {
					var selectedRouteId = $("#tripDialogRoutes").val();
					var departureTime = $("#tripDialogDepartureTime").val();
					var arrivalTime = $("#tripDialogArrivalTime").val();
					var selectedBusType = $("#tripDialogBusType").val();
					if (selectedRouteId != '-1' && departureTime != ""
							&& selectedBusType != '-1') {
						$.ajax({
		    				  url: "availBus.html?departureTime=" + departureTime + "&busType=" + selectedBusType + "&routeId=" + selectedRouteId,
		    				}).done(function(data) {
		    					// cleare bus selection
		    					$('#tripDialogBusPlate').empty();
		    					
		    					// process over response data
		    					// add new avaible bus plateNumber
		    					$.each(data.busInfos, function() {
		    						$('#tripDialogBusPlate').append('<option value="'+this.id+'">'+this.plateNumber+'</option>');
		    					});
		    					$("#tripDialogArrivalTime").val(data.arrivalTime);
		    				});
					}
				}
				$('input.btn-warning').bind('click', function(){
					var url = $('#contextPath').val() + "/trip/list.html?id=" + $(this).data('view-details');
					window.location = url;
				});
			});
</script>
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<jsp:include page="../common/menu.jsp" />
	<div id="page">
		<div class="post">
			<div style="height: 45px; margin-left: 1%;">
				<input id="BusStatusInsertBtn" type="button" class="btn btn-success"
					value="Add New" />
			</div>
			<table id="scheduleTable">
				<thead>
					<tr>
						<th>Bus Number</th>
						<th>From Date</th>
						<th>To Date</th>
						<th>Status</th>
						<th>End Station</th>
						<th></th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<s:iterator value="busStatusBeans">
						<tr id="busStatus_<s:property value='id'/>">
							<td><s:property value="bus.plateNumber"/></td>
							<td><s:property value="fromDate"/></td>
							<td><s:property value="toDate"/></td>
							<td><s:property value="status"/></td>
							<td><s:property value="endStation.city.name"/></td>
							<td style="width: 6%">
								<input data-view-details="<s:property value='id'/>"
								class="btn btn-warning" type="button" value="View Details" /></td>
							<td><input data-delete="<s:property value='id'/>"
								class="btn btn-danger" type="button" value="Delete" /></td>
						</tr>
					</s:iterator>
				</tbody>
			</table>
		</div>
	</div>
	
	<!-- Modal -->
	<div id="CreateScheduleDialog" class="modal hide fade" tabindex="-1" role="dialog" 
		aria-labelledby="myModalLabel" aria-hidden="true">
		<form id="addNewTripForm" action="save.html" method="POST">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal"
				aria-hidden="true">×</button>
			<h3 id="tripEditDialogLabel"></h3>
		</div>
		<div class="modal-body">
			<div id="trip-route">
				<label id="trip-route-label" for="routeSelect">Select Route</label>
				<s:select id="tripDialogRoutes" headerKey="-1"
					headerValue="--- Select Route ---" list="routeBeans"
					name="routeBeans" listKey="id" listValue="name" />
			</div>
			<label for="tripDialogDepartureTimeDiv">From Date: </label>
			<div id="tripDialogDepartureTimeDiv" class="input-append date form_datetime" data-date="">
				<input id="tripDialogDepartureTime" size="16" type="text" value="" readonly
					name="tripDialogDepartureTime"> <span class="add-on"><i
					class="icon-remove"></i></span> <span class="add-on"><i
					class="icon-calendar"></i></span>
			</div>
			<label for="tripDialogArrivalTimeDiv">To Date: </label>
			<div id="tripDialogArrivalTimeDiv" class="input-append date form_datetime"
				data-date="">
				<input id="tripDialogArrivalTime" size="16" type="text" value="" readonly> <span
					class="add-on"><i class="icon-remove"></i></span> <span
					class="add-on"><i class="icon-calendar"></i></span>
			</div>
			<label for="tripDialogBusType">Bus Type: </label>
			<s:select id="tripDialogBusType" headerKey="-1"
				headerValue="--- Select Bus Type ---" list="busTypeBeans"
				name="busTypeBeans" listKey="id" listValue="name" />
			<div id="trip-plate-number">
				<label for="routeSelect">Bus Plate Number</label> 
				<select id='tripDialogBusPlate' name='tripDialogBusPlate'></select>
			</div>
			<div id="tripDialogStatus"></div>
		</div>
		<div class="modal-footer">
			<button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
			<button id="addNewTrip" class="btn btn-primary">Save changes</button>
		</div>
		</form>
	</div>
	
	<!-- Modal Delete Dialog -->
	<div id="deleteTripDialog" class="modal hide fade" tabindex="-1" role="dialog" 
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal"
				aria-hidden="true">×</button>
			<h3 id="tripDeleteDialogLabel"></h3>
		</div>
		<div class="modal-body">
			<p>Do you want to delete this trip?</p>
		</div>
		<div class="modal-footer">
			<button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
			<button id="tripDeleteDialogOk" class="btn btn-danger">Delete</button>
		</div>
	</div>
	<jsp:include page="../common/footer.jsp" />
</body>

</html>