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
<link
	href="<%=request.getContextPath()%>/styles/route/jquery-ui-1.10.1.custom.min.css"
	rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/index.js"></script>
<script
	src="<%=request.getContextPath()%>/js/route/jquery-ui-1.10.1.custom.min.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery.dataTables.min.js"></script>
<script src="<%=request.getContextPath()%>/js/accounting.min.js"></script>
<script
	src="<%=request.getContextPath()%>/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript">
	function validate() {
		var errorMessage = "";
		var isValid = true;
		var plateNumber = $("#plateNumber").val();
		var busType = $("#busType").val();
		var forwardRoute = $("#assignRouteForward").val();
		var returnRoute = $("#assignRouteReturn").val();
		if (plateNumber == '') {
			errorMessage += "\nPlease input bus plate number";
			isValid = false;
		}
		if (busType == -1) {
			errorMessage += "\nPlease select bus type";
			isValid = false;
		}
		if (!isValid) {
			alert(errorMessage);
		}
		return isValid;
	}
</script>
<style type="text/css">
.dataTables_filter {
	display: none;
}

.dataTables_length {
	display: none;
}

.dataTables_paginate {
	display: none;
}

.dataTables_info {
	display: none;
}
</style>
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<jsp:include page="../common/menu.jsp" />
	<div id="page">
		<form action="save-bus.html" method="post">
			<div class="post" style="margin: 0px auto; width: 95%;">
				<div style="margin-left: 10px; margin-top: 10px;">
				   Plate Number :
					<input type="text" id="plateNumber" name="plateNumber" value="">
					Select Bus Type :
					<s:select id="busType" headerKey="-1"
						headerValue="--- Select Bus Type ---" list="busTypeBeans"
						name="busTypeBeans" listKey="id" listValue="name" />
				</div>
				<div style="margin-left: 10px; margin-top: 10px;">
					<input class="btn btn-primary" type="submit" id="save" value="Save"
						onclick="return validate()" />
				</div>
			</div>
		</form>
	</div>
	<jsp:include page="../common/footer.jsp" />
</body>

</html>