<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<script src="<%=request.getContextPath()%>/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript">
	$(document).ready(
			function() {
				var oTable;
				var selectedTripId = "";
				oTable = $('#tripsTable').dataTable();

				$('input[data-edit]').click(function() {
					var tripId = this.dataset['edit'];
				});

				$('input[data-delete]').click(
						function() {
							var tripId = this.dataset['delete'];
							$('#tripDeleteDialogLabel').html(
									$("#trip_" + tripId + " td")[0].innerHTML);
							$('#deleteTripDialog').modal();
							selectedTripId = tripId;
						});

				$('#tripDeleteDialogOk').click(function() {
					$.ajax({
						url : "delete.html?id=" + selectedTripId,
					}).done(function(data) {
						oTable.fnDeleteRow($("#trip_" + selectedTripId + ""));
						$('#deleteTripDialog').modal('hide');
					});
				});

				$('#tripInsertBtn').click(function() {
					$('#editTripDialog').modal();
					$('#tripEditDialogLabel').html("Add New Trip");
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
				
				function getAvailBus() {
					var selectedRouteId = $("#tripDialogRoutes").val()
					var departureTime = $("#tripDialogDepartureTime").val();
					var arrivalTime = $("#tripDialogArrivalTime").val();
					var selectedBusType = $("#tripDialogBusType").val();
					if (selectedRouteId != '-1' && departureTime != ""
							&& selectedBusType != '-1') {
						$.ajax({
		    				  url: "availBus.html?departureTime=" + departureTime + "&busType=" + selectedBusType,
		    				}).done(function(data) {
		    					// cleare bus selection
		    					$('#busPlateSelect').empty();
		    					
		    					// process over response data
		    					// add new avaible bus plateNumber
		    					$.each(data.busBeans, function() {
		    						$('#busPlateSelect').append('<option value="'+this.id+'">'+this.plateNumber+'</option>');
		    					});
		    				});
					}
				}
			});
</script>
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<jsp:include page="../common/menu.jsp" />
	<div id="page">
		<div class="post">
			<form action="insertNewTrip" method="post">
				<div style="height: 45px; margin-left: 1%;">
					<input id="tripInsertBtn" type="button" class="btn btn-success" value="Add New"/>
				</div>
				<table id="tripsTable">
					<thead>
						<tr>
							<th>Name</th>
							<th>Bus Number</th>
							<th>Departure Time</th>
							<th>Arrival Time</th>
							<th>Status</th>
							<th></th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<s:iterator value="tripBeans" status="tripBeansStatus">
							<tr id="trip_<s:property value='id'/>">
								<td><s:property value="routeDetails.route.name" /></td>
								<td><s:property value="busStatus.bus.plateNumber" /></td>
								<td><s:property value="departureTime" /></td>
								<td><s:property value="arrivalTime" /></td>
								<td><s:property value="status" /></td>
								<td style="width: 6%"><input data-edit="<s:property value='id'/>" class="btn btn-warning" type="button" value="Edit"/></td>
								<td><input data-delete="<s:property value='id'/>" class="btn btn-danger" type="button" value="Delete"/></td>
							</tr>
						</s:iterator>
					</tbody>
				</table>
			</form>
		</div>
	</div>
	
	<!-- Modal -->
	<div id="editTripDialog" class="modal hide fade" tabindex="-1" role="dialog" 
		aria-labelledby="myModalLabel" aria-hidden="true">
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
			<label for="tripDialogDepartureTimeDiv">Departure Time: </label>
			<div id="tripDialogDepartureTimeDiv" class="input-append date form_datetime" data-date="">
				<input id="tripDialogDepartureTime" size="16" type="text" value="" readonly
					name="tripDialogDepartureTime"> <span class="add-on"><i
					class="icon-remove"></i></span> <span class="add-on"><i
					class="icon-calendar"></i></span>
			</div>
			<label for="tripDialogArrivalTimeDiv">Arrival Time: </label>
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
			<button class="btn btn-primary">Save changes</button>
		</div>
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