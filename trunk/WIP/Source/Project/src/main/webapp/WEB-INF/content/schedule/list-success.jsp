<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>VinaBus - Schedule list</title>
<jsp:include page="../common/xheader.jsp" />
<link
	href="<%=request.getContextPath()%>/styles/trip/datetimepicker.css"
	rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/index.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery.dataTables.min.js"></script>
<script
	src="<%=request.getContextPath()%>/js/bootstrap-datetimepicker.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/styles/custom-data-table.css" />
<script src="<%=request.getContextPath()%>/js/common/custom-data-table.js"></script>
<script type="text/javascript">
	function loadDetails(id) {
	    var url = $('#contextPath').val() + "/trip/list.html?id=" + id;
	    window.location = url;
	 };
	 
	function deleteTrip(id) {
		$('#busStatusId').val(id);
		$("#deleteTripDialog").modal();
	};
	
	function checkButton(){
		var route = $('#tripDialogRoutes').val();
      var departureTime = $("#tripDialogDepartureTime").val();
      var busPlate = $('#tripDialogBusPlate').val();
      var addNewSchedule = $("#addNewSchedule");

      if(route != -1 && departureTime != "" && busPlate != null && busPlate != ''){
         addNewSchedule.removeAttr("disabled"); 
      } else { 
         addNewSchedule.attr("disabled","disabled");
      }
   }
	 
	$(document).ready(
			function() {
				var oTable = $('#scheduleTable').dataTable({
					"aoColumnDefs": [
					                 { 'bSortable': false, 'aTargets': [ 4,5 ] }   
					              ]
				});
				
		      $("#tripDialogBusPlate").change(function(){
		         checkButton(); 
		      });
		      
				$('#busStatusInsertBtn').click(function() {
					var date = new Date();
			      date.setDate(date.getDate() + 1);
			         
					$('#tripDialogRoutes').val(-1);
					$('#tripDialogDepartureTime').val('');
					$('#tripDialogArrivalTime').val('');
					$('#tripDialogBusType').empty();
               $('#tripDialogBusType').append('<option value="-1">Select Bus Type</option>');
               $('#tripDialogBusPlate').empty();
					
					$('#CreateScheduleDialog').modal();
					$('#tripEditDialogLabel').html("Add New Schedule");
					$("#tripDialogDepartureTimeDiv").datetimepicker({
						format : "hh:ii - dd/mm/yyyy",
						autoclose : true,
						todayBtn : true,
						startDate : date,
						minuteStep : 10
					}).on('changeDate', function(ev) {
						getAvailBus();
						getArrivalTime();
						checkButton();
					});
					
					$("#tripDialogDepartureTimeDiv").datetimepicker("setDate", date);
				});
				
				$('#tripDeleteDialogOk').click(function() {
					var busStatusId = $('#busStatusId').val();
					$.ajax({url: "deleteSchedule.html?busStatusId=" + busStatusId,}).done(function(data) {
						   alert(data.message);
						   var url = $('#contextPath').val() + "/schedule/list.html";
						   window.location = url;
					});
				});
				
				$('#tripDialogBusType').change(function() {
					getAvailBus();
					getArrivalTime();
					checkButton();
				});
				
				$('#tripDialogRoutes').change(function() {
					getBusTypesInRoute();
					getAvailBus();
					getArrivalTime();
		      });
				
				$('#tripDialogBusPlate').change(function() {
					checkButton();
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
				
				$('#cancelAdd').bind('click', function(){
					$("#tripDialogRoutes").val(-1);
		         $("#tripDialogDepartureTime").val('');
		         $("#tripDialogArrivalTime").val('');
		         $("#tripDialogBusType").empty();
		         $('#tripDialogBusPlate').val('');
				});
				
				$('#addNewSchedule').bind('click', function(event) {
					var selectedRouteId = $("#tripDialogRoutes").val();
		         var departureTime = $("#tripDialogDepartureTime").val();
		         var selectedBusType = $("#tripDialogBusType").val();
		         var busPlate = $('#tripDialogBusPlate').val();
					var form = $('#addNewTripForm');
					
					if (selectedRouteId == -1 || departureTime == '' || !selectedBusType
							|| selectedBusType == -1 || !busPlate
							|| busPlate == '') {
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
	<div id="page" class="well small-well">
		<h3 style="border-bottom: 1px solid #ddd; margin-bottom: 20px;">    
				Manage schedule  
				<input style="display: none" id="busStatusInsertBtn" type="button" class="btn btn-primary pull-right" 
					value="Add New Schedule" />
		</h3>  
		<div class="post">
			<table id="scheduleTable" align="center" class="table table-striped table-bordered dataTable" style="margin-top:20px;background-color: #fff">
				<thead>
					<tr>
					   <th>Route Name</th>
						<th>Bus Number</th>
						<th>From Date</th>
						<th>To Date</th>
						<th></th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<s:iterator value="busStatusBeans">
						<tr id="busStatus_<s:property value='id'/>">
						   <td><s:property value="trips[0].routeDetails.route.name" /></td>
							<td><s:property value="bus.plateNumber" /></td>
							<td><s:date name="fromDate" format="HH:mm - dd/MM/yyyy" /></td>
							<td><s:date name="toDate" format="HH:mm - dd/MM/yyyy" /></td>
							<td style="width:6%"><input class="btn btn-info btn-small"
								type="button" value="View Details" 
								onclick='javascript: loadDetails(<s:property value='id'/>)' /></td>
							<td><input data-delete="<s:property value='id'/>"
								class="btn btn-danger btn-small" type="button" value="Delete"  
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
				<button class="btn" id="cancelAdd" data-dismiss="modal" aria-hidden="true">Cancel</button>
				<input type="button" id="addNewSchedule" class="btn btn-primary" value='Save changes' disabled="disabled"/>
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
			<h3 id="saveSuccessDialogLabel">Result Message</h3>
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