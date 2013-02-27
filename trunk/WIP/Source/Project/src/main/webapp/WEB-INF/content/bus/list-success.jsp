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
	$(document).ready(function() {
		var oTable = $('#busTable').dataTable();

		$('#addBus').bind().bind('click', function(event) {
			var url = $('#contextPath').val() + "/bus/add.html";
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
				<input class="btn btn-primary" id="addBus" type="button"
					value="Add New Bus" />
			</div>
			<table id="busTable" align="center">
				<thead>
					<tr>
					   <th>ID</th>
						<th>Bus Type</th>
						<th>Plate Number</th>
						<th>Status</th>
					</tr>
				</thead>
				<tbody>
					<s:iterator value="busBeans">
						<tr id="route_<s:property value='id'/>">
						   <td><s:property value="id" /></td>
							<td><s:property value="busType.name" /></td>
							<td><s:property value="plateNumber" /></td>
							<td><s:property value="status" /></td>
						</tr>
					</s:iterator>
				</tbody>
			</table>
		</div>
	</div>
	<jsp:include page="../common/footer.jsp" />
</body>

</html>