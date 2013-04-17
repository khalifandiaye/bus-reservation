<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC 
	"-//W3C//DTD XHTML 1.1 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>VinaBus - Trip list</title>
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
	$(document).ready(
			function() {
				oTable = $('#tripsTable').dataTable({
					'bSort' : false
				});

				$('input.btn-primary').bind('click', function(){
					var url = $('#contextPath').val() + "/schedule/list.html";
					window.location = url;
				});
			});
</script>
<style type="text/css">
.dataTables_filter {
   display: none;
}

.dataTables_length {
   display: none;
}
</style>
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<jsp:include page="../common/menu.jsp" />
	<div id="page" class="well">
		<div class="post"> 
				<h3 style="border-bottom: 1px solid #ddd; margin-bottom: 20px;">
				<s:property value="tripBeans[0].routeDetails.route.name" /> 
				</h3>  
				<table id="tripsTable" class="table table-striped table-bordered dataTable" style="margin-top:20px;background-color: #fff">
					<thead>
						<tr>
							<th>Segment Name</th>
							<th>Departure Time</th>
							<th>Arrival Time</th>
						</tr>
					</thead>
					<tbody>
						<s:iterator value="tripBeans" status="tripBeansStatus">
							<tr id="trip_<s:property value='id'/>">
								<td><s:property value="routeDetails.segment.startAt.city.name" /> - <s:property value="routeDetails.segment.endAt.city.name" /></td>
								<td><s:date name="departureTime" format="HH:mm - dd/MM/yyyy" /></td>
								<td><s:date name="arrivalTime" format="HH:mm - dd/MM/yyyy" /></td>
							</tr>
						</s:iterator>
					</tbody>
				</table>
				</br>
				<input class="btn btn-primary" type="button" value="Return to Schedule" />
		</div>
	</div>
	<jsp:include page="../common/footer.jsp" />
</body>
</html>
