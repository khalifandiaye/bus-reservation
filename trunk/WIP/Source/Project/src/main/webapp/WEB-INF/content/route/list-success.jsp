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
 
 	function deleteRoute(id) {
 	      $('#routeId').val(id);
 	      $("#deleteRouteDialog").modal();
 	    };
 	    
	$(document).ready(
		function() {
			var oTable = $('#routeTable').dataTable({"bSort" : false});
				
			$('#addRoute').bind('click', function(event) {
				var url = $('#contextPath').val() + "/route/add.html";
		        window.location = url;
			});
			
			$('#routeDeleteDialogOk').click(function() {
                var busStatusId = $('#routeId').val();
                $.ajax({
                           url: "deleteRoute.html?routeId=" + busStatusId,
                         }).done(function(data) {
                            alert(data);
                            var url = $('#contextPath').val() + "/route/list.html";
                            window.location = url;
                         });
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
				<input class="btn btn-primary" id="addRoute" type="button"
					value="Add New Route" />
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
								type="button" value="Delete"
								onclick='javascript: deleteRoute(<s:property value='id'/>)' /></td>
						</tr>
					</s:iterator>
				</tbody>
			</table>
		</div>
	</div>

	<!-- Modal Delete Dialog -->
	<div id="deleteRouteDialog" class="modal hide fade" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal"
				aria-hidden="true">×</button>
			<h3 id="routeDeleteDialogLabel">Delete</h3>
		</div>
		<div class="modal-body">
			<p>Do you want to delete this route?</p>
		</div>
		<div class="modal-footer">
			<button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
			<button id="routeDeleteDialogOk" class="btn btn-danger">Delete</button>
		</div>
	</div>
	<input id="routeId" value="" type="hidden" />
	<jsp:include page="../common/footer.jsp" />
</body>

</html>