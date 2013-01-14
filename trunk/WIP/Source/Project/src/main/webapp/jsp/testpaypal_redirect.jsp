
<%//System.out.println(request.getParameter("redirectUrl")); %>
<% response.sendRedirect(request.getAttribute("redirectUrl").toString()); %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC 
	"-//W3C//DTD XHTML 1.1 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Test</title>
<jsp:include page="common/xheader.jsp" />
</head>
<body>
			Attribute: <%=request.getAttribute("redirectUrl") %>
</body>
</html>
	