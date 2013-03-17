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
<jsp:include page="../common/xheader.jsp" />
<link href="<%=request.getContextPath()%>/styles/booking.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/styles/pay.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<div class="search-reservation">
		<form method="post" action="<%=request.getContextPath()%>/rsv/rsv01021.html">
			<div class="container">
				<div class="well error">
					<s:actionerror/>
				</div>
				<div class="well">
					<div class="item">
						<label><s:text name="reservation.code" /></label><s:textfield name="reservationCode" />
					</div>
					<div class="item">
						<label><s:text name="reservation.email" /></label><s:textfield name="email" />
					</div>
					<div class="item">
						<s:submit id="pay02010" cssClass="btn btn-primary" key="btn.viewDetails"/>
					</div>
				</div>
			</div>
		</form>
	</div>
	<jsp:include page="../common/footer.jsp" />
</body>
</html>
	