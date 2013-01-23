<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC 
	"-//W3C//DTD XHTML 1.1 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Hello World</title>
<jsp:include page="common/xheader.jsp" />
</head>
<body>
	<jsp:include page="common/header.jsp" />
	<form method="post">
		<section class="body">
			<div class="container">
			<h4>Test</h4>
			<s:iterator value="stationList">
				<s:property value="name"/> <br/>
			</s:iterator>
			</div>
		</section>
	</form>
	<jsp:include page="common/footer.jsp" />
</body>
</html>
	