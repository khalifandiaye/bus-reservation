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
<script src="<%=request.getContextPath()%>/js/index.js"></script>
<script src="<%=request.getContextPath()%>/js/trip/jquery-1.8.3.min.js"></script>
<script src="<%=request.getContextPath()%>/js/trip/bootstrap-datetimepicker.js"></script>
<link href="<%=request.getContextPath()%>/styles/trip/datetimepicker.css" rel="stylesheet">
<script type="text/javascript">
	$(document).ready(function() {
		$("#departDate").datetimepicker({
	        format: "yyyy/mm/dd hh:ii",
	        autoclose: true,
	        todayBtn: true,
	    }).on('changeDate', function(ev){
	    		var routeId = $("#routeSelect").val();
	    		var departDate = $("#departDate").val();
	    		if (routeId != "" && departDate != "") {
	    			var travelTime = $("option[value="+routeId+"]").data('traveltime');
	    			// calculate arriveTime here
	    			$.ajax({
	    				  url: "updateTripTime.html?date=" + departDate,
	    				}).done(function(data) {
	    					// cleare bus selection
	    					$('#busPlateSelect').empty();
	    					
	    					// process over response data
	    					// add new avaible bus plateNumber
	    					$.each(data.busBeans, function() {
	    						$('#busPlateSelect').append('<option value="'+this.id+'">'+this.plateNumber+'</option>');
	    					});
	    				});
	        };
	    });
		
		$("#arrivalDate").datetimepicker({
	        format: "dd MM yyyy - hh:ii",
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
				<div id="trip-add-content" style="margin-left: 20px; width: 45%">
					<div id="trip-title">
						<h2 class="title">Create Trip</h2>
					</div>
					<div id="trip-route">
						<label id="trip-route-label" style="float: left; width: 25%" for="routeSelect">Select Route</label> 
						<select id='routeSelect' name='routeSelect'>
						</select>
					</div>
					<div id="trip-departure">
						<label id="trip-departDate-label" style="float: left; width: 25%" for="routeSelect">Departure date</label> 
						<input type="text" value="" id="departDate" name="departDate">
					</div>
					<div id="trip-arrival">
						<label id="trip-arrivalDate-label" style="float: left; width: 25%" for="routeSelect">Arrival date</label> 
						<input type="text" value="" id="arrivalDate" name="arrivalDate" disabled="disabled">
					</div>
					<div id="trip-plate-number">
						<label id="trip-arrivalDate-label" style="float: left; width: 25%" for="routeSelect">Bus Plate Number</label>
						<select id='busPlateSelect' name='busPlateSelect'></select>
					</div>
					<div>
						<input type="submit" style="height: 27px; margin-left: 44%;" id="insertNewTrip" value="Add This Trip">
					</div>
				</div>
			</form>
		</div>
	</div>
	<jsp:include page="../common/footer.jsp" />
</body>
</html>