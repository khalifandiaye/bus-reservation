<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC 
	"-//W3C//DTD XHTML 1.1 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="s" uri="/struts-tags" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Test page</title>
<jsp:include page="../common/xheader.jsp" />
<script src="<%=request.getContextPath()%>/js/index.js" ></script>
<script src="<%=request.getContextPath()%>/js/pay/pay02010.js"></script>
</head>
	<body>
	<jsp:include page="../common/header.jsp" />
	<span id="subRouteName"></span>
	<span id="seatNumbers"></span>
	<div id="strings"></div>
	<button>Click here</button>
	<!-- <form method="post" action="<%=request.getContextPath()%>/pay/pay-paypal">
		<section class="reservation_info">
			<div class="container">
				<h4>Thông tin đặt vé</h4>
				<div class="labeled_list">
				<label>Tuyến</label>
				<span><s:property value="reservationInfo.routeName" /></span>
				<label>Chặng</label>
				<span><s:property value="reservationInfo.subRouteName" /></span>
				<label>Ngày giờ khởi hành</label>
				<span><s:property value="reservationInfo.departureDate" /></span>
				<label>Ngày giờ tới dự kiến</label>
				<span><s:property value="reservationInfo.arrivalDate" /></span>
				<label>Số ghế</label>
				<span><s:property value="reservationInfo.seatNumbers" /></span>
				<label>Giá vé</label>
				<span><s:property value="reservationInfo.basePrice" /> <s:property value="reservationInfo.currency" /><br />
				= $<s:property value="reservationInfo.basePriceInUSD" /></span>
				<label>Phí thanh toán trực tuyến</label>
				<span><s:property value="reservationInfo.transactionFee" /> <s:property value="reservationInfo.currency" /><br />
				= $<s:property value="reservationInfo.transactionFeeInUSD" /></span>
				<label>Thành tiền</label>
				<span><s:property value="reservationInfo.totalAmount" /> <s:property value="reservationInfo.currency" /><br />
				= $<s:property value="reservationInfo.totalAmountInUSD" /></span>
				</div>
				<s:submit id="pay02020" value="Cancel" disabled="true"/>
			</div>
		</section>
	</form> -->
	<jsp:include page="../common/footer.jsp" />
	</body>
</html>
	