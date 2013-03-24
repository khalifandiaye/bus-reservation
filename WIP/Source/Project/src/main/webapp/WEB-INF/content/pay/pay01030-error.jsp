<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC 
	"-//W3C//DTD XHTML 1.1 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><s:text name="title.pay01030-error" /></title>
<jsp:include page="../common/xheader.jsp" />
<link href="<%=request.getContextPath()%>/styles/booking.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<!-- Start small nav -->
	<div class="small-nav">
		<div class="nav-step-wrapper step4"> 
			<div class="nav-step"> 
				<div class="nav-step-des" ><s:text name="step_1_description" /></div>
			</div>
			<div class="nav-step">
				<div class="nav-step-des"><s:text name="step_2_description" /></div> 
			</div>
			<div class="nav-step">
				<div class="nav-step-des"><s:text name="step_3_description" /></div>
			</div>
			<div class="nav-step">
				<div class="nav-step-des"><s:text name="step_4_description" /></div>
			</div>
		</div>
	</div> 
	<!-- End small nav -->
	<div class="reservation-details">
		<div class="container">
			<s:actionerror />
		</div>
	</div>
	<jsp:include page="../common/footer.jsp" />
</body>
</html>
	