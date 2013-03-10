<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

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
	function loadDetails(id) {
	    var url = $('#contextPath').val() + "/trip/list.html?id=" + id;
	    window.location = url;
	 };
	 
	function deleteTrip(id) {
		$('#busStatusId').val(id);
		$("#deleteTripDialog").modal();
	 };
	 
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
						getAvailBus();
						getArrivalTime();
					});
				});
				
				$('#tripDeleteDialogOk').click(function() {
					var busStatusId = $('#busStatusId').val();
					$.ajax({
	                       url: "deleteSchedule.html?busStatusId=" + busStatusId,
	                     }).done(function(data) {
	                        alert(data.message);
	                        var url = $('#contextPath').val() + "/schedule/list.html";
	                        window.location = url;
	                     });
				});
				
				$('#tripDialogBusType').change(function() {
					getAvailBus();
					getArrivalTime();
				});
				
				$('#tripDialogRoutes').change(function() {
					getBusTypesInRoute();
					getAvailBus();
					getArrivalTime();
		      });
				
				function getAvailBus() {
					var selectedRouteId = $("#tripDialogRoutes").val();
					var departureTime = $("#tripDialogDepartureTime").val();
					var selectedBusType = $("#tripDialogBusType").val();
					if (selectedRouteId != '-1' && departureTime != ""
							&& selectedBusType != '-1') {
						$.ajax({
		    				  url: "availBus.html?departureTime=" + departureTime + "&busType=" + selectedBusType + "&routeId=" + selectedRouteId,
		    				}).done(function(data) {
		    					$('#tripDialogBusPlate').empty();
		    					$.each(data.busInfos, function() {
		    						$('#tripDialogBusPlate').append('<option value="'+this.id+'">'+this.plateNumber+'</option>');
		    					});
		    				});
					}
				};
				
				function getBusTypesInRoute() {
					var selectedRouteId = $("#tripDialogRoutes").val();
		         if (selectedRouteId != '-1') {
		            $.ajax({
		                 url: "busTypes.html?&routeId=" + selectedRouteId,
		                }).done(function(data) {
		                 $('#tripDialogBusType').empty();
		                 $.each(data.busTypeInfos, function() {
		                 $('#tripDialogBusType').append('<option value="'+this.id+'">'+this.type+'</option>');
		                });
		              });
		         }
				}
				
				function getArrivalTime() {
					var selectedRouteId = $("#tripDialogRoutes").val();
		         var departureTime = $("#tripDialogDepartureTime").val();
		         if (selectedRouteId != '-1' && departureTime != "") {
		        	   $.ajax({
		        		   url: "getArrivalTime.html?departureTime=" + departureTime + "&routeId=" + selectedRouteId,
		        	   }).done(function(data) {
		        		   $("#tripDialogArrivalTime").val(data.arrivalTime);
		        		});
		         }
				}
				
				$('#addNewSchedule').bind('click', function(event) {
					var selectedRouteId = $("#tripDialogRoutes").val();
		         var departureTime = $("#tripDialogDepartureTime").val();
		         var selectedBusType = $("#tripDialogBusType").val();
		         var busPlate = $('#tripDialogBusPlate').val();
					var form = $('#addNewTripForm');
					
					if (selectedRouteId == -1 || departureTime == '' || !selectedBusType
							|| selectedBusType == -1 || !busPlate
							|| busPlate == '') {
						alert('please field all field');
						return;
					}
					
					event.preventDefault();
					$.ajax({
					      type: "POST",
					      url: form.attr('action'),
					      data: form.serialize(),
					      success: function( response ) {
					    	  $('#CreateScheduleDialog').modal('hide');
					    	  $("#saveSuccessDialogLabeMessage").html(response);
					    	  $("#saveSuccess").modal();
					      }
					});
				});
				
				$('#saveSuccessDialogOk').bind('click', function(){
					var url = $('#contextPath').val() + "/schedule/list.html";
					window.location = url;
				});
			});
</script>
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<jsp:include page="../common/menu.jsp" />
	<div id="page">
		<div class="post" style="margin: 0px auto; width: 95%;">
			<div style="height: 45px; margin-left: 1%;">
				<input id="BusStatusInsertBtn" type="button" class="btn btn-success"
					value="Add New Schedule" />
			</div>
			<table id="scheduleTable" align="center">
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
							<td><s:property value="bus.plateNumber" /></td>
							<td><s:property value="fromDate" /></td>
							<td><s:property value="toDate" /></td>
							<td><s:property value="status" /></td>
							<td><s:property value="endStation.city.name" /></td>
							<td style="width: 6%"><input class="btn btn-primary"
								type="button" value="View Details"
								onclick='javascript: loadDetails(<s:property value='id'/>)' /></td>
							<td><input data-delete="<s:property value='id'/>"
								class="btn btn-danger" type="button" value="Delete"
								onclick='javascript: deleteTrip(<s:property value='id'/>)' /></td>
						</tr>
					</s:iterator>
				</tbody>
			</table>
		</div>
	</div>

	<!-- Modal -->
	<div id="CreateScheduleDialog" class="modal hide fade" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
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
				<div id="tripDialogDepartureTimeDiv"
					class="input-append date form_datetime" data-date="">
					<input id="tripDialogDepartureTime" size="16" type="text" value=""
						readonly name="tripDialogDepartureTime"> <span
						class="add-on"><i class="icon-remove"></i></span> <span
						class="add-on"><i class="icon-calendar"></i></span>
				</div>
				<label for="tripDialogArrivalTimeDiv">To Date: </label>
				<div id="tripDialogArrivalTimeDiv"
					class="input-append date form_datetime" data-date="">
					<input id="tripDialogArrivalTime" size="16" type="text" value=""
						readonly>
				</div>
				<label for="tripDialogBusType">Bus Type: </label>
					<select id="tripDialogBusType" name="busTypeBeans">
					 <option value="-1">Select Bus Type</option>
					</select>
				<div id="trip-plate-number">
					<label for="routeSelect">Bus Plate Number</label> <select
						id='tripDialogBusPlate' name='tripDialogBusPlate'></select>
				</div>
				<div id="tripDialogStatus"></div>
			</div>
			<div class="modal-footer">
				<button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
				<input type="button" id="addNewSchedule" class="btn btn-primary" value='Save changes'/>
			</div>
		</form>
	</div>

	<!-- Modal Delete Dialog -->
	<div id="deleteTripDialog" class="modal hide fade" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal"
				aria-hidden="true">×</button>
			<h3 id="tripDeleteDialogLabel">Delete</h3>
		</div>
		<div class="modal-body">
			<p>Do you want to delete this trip?</p>
		</div>
		<div class="modal-footer">
			<button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
			<button id="tripDeleteDialogOk" class="btn btn-danger">Delete</button>
		</div>
	</div>

	<!-- Modal Save success Dialog -->
	<div id="saveSuccess" class="modal hide fade" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal"
				aria-hidden="true">×</button>
			<h3 id="saveSuccessDialogLabel">Message</h3>
		</div>
		<div class="modal-body">
			<p id="saveSuccessDialogLabeMessage"></p>
		</div>
		<div class="modal-footer">
			<button class="btn" id="saveSuccessDialogOk" data-dismiss="modal"
				aria-hidden="true">Ok</button>
		</div>
	</div>

	<input id="busStatusId" value="" type="hidden" />
	<jsp:include page="../common/footer.jsp" />
</body>

</html>