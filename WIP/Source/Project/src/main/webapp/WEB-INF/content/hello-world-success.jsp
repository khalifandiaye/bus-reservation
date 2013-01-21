<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
			<legend>Hello World</legend>
			Attribute: <%=request.getAttribute("name") %><br/>
			Parameter: <%=request.getParameter("name") %>
			<p>Hello ${name}</p>
			</div>
		</section>
	</form>
	<jsp:include page="common/footer.jsp" />
</body>
</html>
	