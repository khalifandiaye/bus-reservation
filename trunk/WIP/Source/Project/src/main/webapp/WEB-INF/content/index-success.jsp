<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC 
	"-//W3C//DTD XHTML 1.1 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Test page</title>
<jsp:include page="common/xheader.jsp" />
<script src="<%=request.getContextPath()%>/js/index.js" ></script>
</head>
	<body>
	<jsp:include page="common/header.jsp" />
	<form method="post">
		<section class="body">
			<div class="container">
			<div class="well span11">
				<legend>Temporary Section</legend>
				
				<input type="submit" id="hello-world" value="Say Hello World" /><br />
				<a href="trip/list.html">Test Create Trip</a><br />
				<a href="busStatus/list.html">Test Get Route</a><br />
				<a href="pay/pay01000.html">Test Pay</a><br />
				<a href="pay/pay02000.html">Test Cancel</a><br />
				<a href="rsv/rsv01000.html">Test Reservation List</a><br />
				<a href="search/search-trip.html">Test Search</a><br />
				<a href="clear-session.html">Clear Session</a><br />
			</div>
			</div>
		</section>
	</form>
	<jsp:include page="common/footer.jsp" />
	</body>
</html>
	