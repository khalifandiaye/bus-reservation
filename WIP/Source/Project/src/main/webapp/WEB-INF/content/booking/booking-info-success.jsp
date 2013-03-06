<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC 
	"-//W3C//DTD XHTML 1.1 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Đặt Vé</title>
<jsp:include page="../common/xheader.jsp" />
<link href="<%=request.getContextPath()%>/styles/booking.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/jquery.validate.min.js" ></script>
<script src="<%=request.getContextPath()%>/js/booking/booking-validation.js" ></script> 
<script src="<%=request.getContextPath()%>/js/jquery.cookie.js" ></script>
<script src="<%=request.getContextPath()%>/js/pay/pay01010.js" ></script>
<script src="<%=request.getContextPath()%>/js/booking/booking-info.js" ></script>
</head>
	<body>
	<jsp:include page="../common/header.jsp" />
	<!-- Start small nav -->
	<section class="small-nav">
		<div class="nav-step-wrapper step3">
			<div class="nav-step"> 
				<div class="nav-step-des" >Chọn chuyến</div>
			</div>
			<div class="nav-step">
				<div class="nav-step-des">Chọn ghế</div> 
			</div>
			<div class="nav-step">
				<div class="nav-step-des">Điền thông tin</div>
			</div>
			<div class="nav-step">
				<div class="nav-step-des" style="color:#008EDB">Thanh Toán</div>
			</div>
		</div>
	</section> 
	<!-- End small nav -->
	<!-- Start notify message -->
	<section>
	<div class="container notify-message">
	</div>
	</section>
	<!-- End notify message -->
	<!-- Start information content -->
	<section>
		<div class="well" style="overflow: hidden;">
			<form style="width:50%;float:left" action="booking-pay.html" method="post" id="booking-form">
				<fieldset>
					<legend>Hoàn thành thông tin đăng kí vé xe</legend>
						<div class="control-group">
						    <label class="control-label" for="inputFirstName">Tên</label>
						    <div class="controls">
								<s:textfield id="inputFirstName" name="inputFirstName" placeholder="Tên"></s:textfield>
					    	</div>
					  	</div>
					  	<div class="control-group">
						    <label class="control-label" for="inputLastName">Họ</label>
						    <div class="controls">
								<s:textfield id="inputLastName" name="inputLastName" placeholder="Họ"></s:textfield>
					    	</div>
					  	</div>
					  	<div class="control-group">
						    <label class="control-label" for="inputMobile">Điện Thoại Di Động</label>
						    <div class="controls">
								<s:textfield id="inputMobile" name="inputMobile" placeholder="Điện Thoại Di Động"></s:textfield>
					    	</div>
					  	</div>
					  	<div class="control-group">
						    <label class="control-label" for="inputEmail">Email</label>
						    <div class="controls">
								<s:textfield id="inputEmail" name="inputEmail" placeholder="Email"></s:textfield>
					    	</div>
					  	</div>
					  	<div class="control-group">
						    <label class="control-label" for="selectPaymentMethod">Phương thức thanh toán</label>
						    <div class="controls">
						      <s:select list="paymentMethods" listKey="id" listValue="name" name="paymentMethodId" id="selectPaymentMethod"/>
					    	</div>
					  	</div>
					    <table class="listCheckedSeats table " style="width: 220px;">
					    	<thead>
						    	<tr>
						    		<th>Số Ghế</th>
						    		<th style="text-align: center"><button type="button" class="btn btn-mini btn-danger">Bỏ Ghế</button></th>
						    	</tr> 
					    	</thead>
					    	<tbody>
					    	</tbody>
				    	</table>
					  	
					  	<s:hidden id="selectedSeat" name="selectedSeat"></s:hidden>
					  	
					  	<button id="booking-info-submit" class="btn btn-large" type="submit"><s:text name="pay" /></button>
				</fieldset>
			</form>
			<div style="width:50%;float:left;padding-top:80px;">
				<div class="reservation_info">
					<h4><s:text name="reservation_info" /> </h4>
					<s:iterator value="reservationInfo.tickets">
						<table class="table table-bordered">
							<tr>
								<th><s:text name="reservation.ticket.from" /></th>
								<td><s:property value="departureStation" /></td>
							</tr>
							<tr>
								<th><s:text name="reservation.ticket.departureTime" /></th>
								<td><s:property value="departureDate" /></td>
							</tr>
							<tr>
								<th><s:text name="reservation.ticket.to" /></th>
								<td><s:property value="arrivalStation" /></td>
							</tr>
							<tr>
								<th><s:text name="reservation.ticket.arrivalTime" /></th>
								<td><s:property value="arrivalDate" /></td>
							</tr>
						</table>
					</s:iterator>
				</div>
				<div class="payment_info">
					<table>
		<!-- 				<tr> -->
		<%-- 					<th><s:text name="payment_method" /></th> --%>
		<%-- 					<td><s:select list="paymentMethods" listKey="id" listValue="name" name="paymentMethodId" /></td> --%>
		<!-- 				</tr> -->
						<tr>
							<th style="text-align: left"><s:text name="ticket_price" /></th>
							<td><s:property value="reservationInfo.basePrice" /> VND
								($<s:property value="reservationInfo.basePriceInUSD" />)</td>
						</tr>
						<tr>
							<th style="text-align: left"><s:text name="online_transaction_fee" /></th>
							<td id="transactionFee"><s:property value="reservationInfo.transactionFee" /> VND
								($<s:property value="reservationInfo.transactionFeeInUSD" />)</td>
						</tr>
						<tr>
							<th style="text-align: left"><s:text name="total_amount" /></th>
							<td id="totalAmount"><s:property value="reservationInfo.totalAmount" /> VND
								($<s:property value="reservationInfo.totalAmountInUSD" />)</td>
						</tr>
					</table> 
				</div>
			</div>
		</div>
	</section>
		
	<!-- End information content -->
	<jsp:include page="../common/footer.jsp" /> 
	</body>
</html>
	