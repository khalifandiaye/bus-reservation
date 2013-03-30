<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC 
	"-//W3C//DTD XHTML 1.1 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><s:text name="title.activateUser" /></title>
<jsp:include page="../common/xheader.jsp" />
<link href="<%=request.getContextPath()%>/styles/booking.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/styles/pay.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/user/activate-user.js" ></script>
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<div class="notice">
		<div class="container">
			<div class="well">
			<s:text name="message.actSuccess" />
			<a href="<%=request.getContextPath()%>/"><s:text name="button.toHomePage" /></a>
			</div>
		</div>
	</div>
	<jsp:include page="../common/footer.jsp" />
</body>
</html>
	