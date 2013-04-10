<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC 
	"-//W3C//DTD XHTML 1.1 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><s:text name="title.rsv01010-alt" /></title>
<jsp:include page="../common/xheader.jsp" />
<link href="<%=request.getContextPath()%>/styles/booking.css"
	rel="stylesheet">
<link href="<%=request.getContextPath()%>/styles/pay.css"
	rel="stylesheet">
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<div class="container">
	<s:actionerror />
		<div class="search-reservation well">
			<h3 style="border-bottom: 1px solid #ddd; margin-bottom: 20px;">
				Xem lại vé đã mua</h3>
			<form class="" method="post"
				action="<%=request.getContextPath()%>/rsv/rsv01021.html"
				style="width: 220px; margin: 0 auto">
				<div class="control-group">
					<label class="control-label"><s:text
							name="reservation.code" /></label>
					<div class="controls">
						<s:textfield name="reservationCode" />
					</div>
				</div>
				<div class="control-group">
					<label class="control-label"><s:text
							name="reservation.email" /></label>
					<div class="controls">
						<s:textfield name="email" />
					</div>
				</div>
				<s:submit id="pay02010" cssClass="btn btn-primary btn-large "
					key="btn.viewDetails" cssStyle="float:right;width:220px;" />
			</form>
		</div>
	</div>
	<jsp:include page="../common/footer.jsp" />
</body>
</html>
