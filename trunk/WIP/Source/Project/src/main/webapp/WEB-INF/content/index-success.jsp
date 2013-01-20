<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	<jsp:include page="common/menu.jsp" />
			<div id="page">
				<div class="post">
					<h2 class="title">Temporary Section</h2>
					<p>Name&nbsp;<input type="text" name="name" />
					<input type="submit" id="hello-world" value="Say Hello World" /><br />
					<input type="submit" id="testPaypalStart" value="Test paypal" /></p>
				</div>
			</div>
	<jsp:include page="common/footer.jsp" />
	</body>
</html>
	