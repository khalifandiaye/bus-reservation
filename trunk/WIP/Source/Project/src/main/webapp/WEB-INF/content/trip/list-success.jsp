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
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/styles/trip/jquery.dataTables.css">
<link
	href="<%=request.getContextPath()%>/styles/trip/datetimepicker.css"
	rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/index.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery.dataTables.min.js"></script>
<script
	src="<%=request.getContextPath()%>/js/bootstrap-datetimepicker.js"></script>
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
				</div>
				<h3><s:property value="tripBeans[0].routeDetails.route.name" /></h3>
				<table id="tripsTable">
					<thead>
						<tr>
							<th>Name</th>
							<th>Departure Time</th>
							<th>Arrival Time</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<s:iterator value="tripBeans" status="tripBeansStatus">
							<tr id="trip_<s:property value='id'/>">
								<td><s:property value="routeDetails.segment.startAt.city.name" /> - <s:property value="routeDetails.segment.endAt.city.name" /></td>
								<td><s:property value="departureTime" /></td>
								<td><s:property value="arrivalTime" /></td>
								<td style="width: 6%"><input
									data-edit="<s:property value='id'/>" class="btn btn-warning"
									type="button" value="Edit" /></td>
							</tr>
						</s:iterator>
					</tbody>
				</table>
			</form>
		</div>
	</div>

	<!-- Modal -->
	<div id="editTripDialog" class="modal hide fade" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<form id="addNewTripForm" action="insert.html" method="POST">
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
				<div id="tripDialogDepartureTimeDiv"
					class="input-append date form_datetime" data-date="">
					<input id="tripDialogDepartureTime" size="16" type="text" value=""
						readonly name="tripDialogDepartureTime"> <span
						class="add-on"><i class="icon-remove"></i></span> <span
						class="add-on"><i class="icon-calendar"></i></span>
				</div>
				<label for="tripDialogArrivalTimeDiv">Arrival Time: </label>
				<div id="tripDialogArrivalTimeDiv"
					class="input-append date form_datetime" data-date="">
					<input id="tripDialogArrivalTime" size="16" type="text" value=""
						readonly> <span class="add-on"><i
						class="icon-remove"></i></span> <span class="add-on"><i
						class="icon-calendar"></i></span>
				</div>
				<label for="tripDialogBusType">Bus Type: </label>
				<s:select id="tripDialogBusType" headerKey="-1"
					headerValue="--- Select Bus Type ---" list="busTypeBeans"
					name="busTypeBeans" listKey="id" listValue="name" />
				<div id="trip-plate-number">
					<label for="routeSelect">Bus Plate Number</label> <select
						id='tripDialogBusPlate' name='tripDialogBusPlate'></select>
				</div>
				<div id="tripDialogStatus"></div>
			</div>
			<div class="modal-footer">
				<button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
				<button id="addNewTrip" class="btn btn-primary">Save
					changes</button>
			</div>
		</form>
	</div>
	<jsp:include page="../common/footer.jsp" />
</body>
</html>
