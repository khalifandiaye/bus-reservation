<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC 
	"-//W3C//DTD XHTML 1.1 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="s" uri="/struts-tags" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Test page</title>
<jsp:include page="../common/xheader.jsp" />
<script src="<%=request.getContextPath()%>/js/index.js" ></script>
</head>
	<body>
	<jsp:include page="../common/header.jsp" />
	<form method="post" action="<%=request.getContextPath()%>/pay/pay-paypal">
		<div class="container">
			<s:textfield name="reservationCode" label="Reservation Code" />
			<s:submit id="pay02010" value="Test Pay"/>
		</div>
	</form>
	<jsp:include page="../common/footer.jsp" />
	</body>
</html>
	