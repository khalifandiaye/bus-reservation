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
<script src="<%=request.getContextPath()%>/js/bootstrap-datepicker.js"></script>
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<jsp:include page="../common/menu.jsp" />
	<div id="page">
		<div class="post">
				<h2 class="title">Create Trip</h2>
				Select Route <s:select list="routeList" name="routeID" ></s:select>
				Departure date <input type="text" value="01-01-2013" id="departDate">
				Arrival date <input type="text" value="arrivalDate" id="arrivalDate">
				Bus Plate Number <input type="text" id="busPlate"> 
				<input type="submit" id="addTrip" value="Add This Trip">
			<script type="text/javascript">
				$(function() {
					$('#departDate').datepicker();
					$('#arrivalDate').datepicker();
				});
			</script>
		</div>
	</div>
	<jsp:include page="../common/footer.jsp" />
</body>
</html>
