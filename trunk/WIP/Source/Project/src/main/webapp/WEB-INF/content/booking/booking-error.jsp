<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC 
	"-//W3C//DTD XHTML 1.1 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>VinaBus - Thông báo lỗi</title>
<jsp:include page="../common/xheader.jsp" />
<link href="<%=request.getContextPath()%>/styles/booking.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<div class="well" style="min-height: 150px;">  
		<h3 style="line-height: 150px; text-align: center;">Có lỗi đã xảy ra vui lòng thực hiện lại việc chọn xe.</h3>
	</div>
	<s:actionerror />
	<jsp:include page="../common/footer.jsp" />
</body>
</html>
	