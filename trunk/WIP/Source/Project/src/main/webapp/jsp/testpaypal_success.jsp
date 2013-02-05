<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC 
	"-//W3C//DTD XHTML 1.1 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Payment Success</title>
<jsp:include page="common/xheader.jsp" />
</head>
<body>
	<jsp:include page="common/header.jsp" />
	<jsp:include page="common/menu.jsp" />
	<div id="page">
		<div class="post">
			<h2 class="title">Success</h2>
			PayerID: <s:property value="payerID"/>
		</div>
	</div>
	<jsp:include page="common/footer.jsp" />
</body>
</html>
	