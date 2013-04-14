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
	<!-- Start notify message -->
	<section>
	<div class="notify-message">
		<div class="alert fade in"><button type="button" class="close" data-dismiss="alert">×</button>Có lỗi đã xảy ra vui lòng thực hiện lại việc chọn xe.</div>
	</div>
	</section>
	<!-- End notify message -->
	<s:actionerror />
	<jsp:include page="../common/footer.jsp" />
</body>
</html>
	