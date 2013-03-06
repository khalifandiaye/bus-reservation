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
<script src="<%=request.getContextPath()%>/js/index.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery.dataTables.min.js"></script>
<script type="text/javascript">
	function loadDetails(routeid) {
    	var url = $('#contextPath').val() + "/route/route-detail-list.html?routeId=" + routeid;
    	window.location = url;
 	};
 
	$(document).ready(
		function() {
			var oTable = $('#routeTable').dataTable({"bSort" : false});
				
			$('#addRoute').bind('click', function(event) {
				var url = $('#contextPath').val() + "/route/add.html";
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
	<div id="page">
		<div class="post" style="margin: 0px auto; width: 95%;">
			<div style="height: 45px; margin-left: 1%;">
			   <input class="btn btn-primary" id="addRoute" type="button" value="Add New Route" />
			</div>
			<table id="routeTable" align="center">
				<thead>
					<tr>
						<th>Route Name</th>
						<th>Total duration</th>
						<th></th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<s:iterator value="routeInfos">
						<tr id="route_<s:property value='id'/>">
							<td><s:property value="routeName" /></td>
							<td><s:property value="travelTime" /></td>
							<td style="width: 6%"><input class="btn btn-primary"
								type="button" value="View Details"
								onclick='javascript: loadDetails(<s:property value='id'/>)' /></td>
							<td style="width: 6%"><input
								data-delete="<s:property value='id'/>" class="btn btn-danger"
								type="button" value="Delete" /></td>
						</tr>
					</s:iterator>
				</tbody>
			</table>
		</div>
	</div>
	<div style="margin-bottom: 10px;"></div>
	<jsp:include page="../common/footer.jsp" />
</body>

</html>