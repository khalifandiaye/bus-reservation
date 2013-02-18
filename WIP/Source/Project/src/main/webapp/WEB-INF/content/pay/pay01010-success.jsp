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
	<link href="<%=request.getContextPath()%>/styles/pay.css" rel="stylesheet">
	<script src="<%=request.getContextPath()%>/js/pay/pay01010.js" ></script>
	</head>
	<body>
	<jsp:include page="../common/header.jsp" />
	<form id="form" method="post" action="<%=request.getContextPath()%>/pay/pay-paypal">
		<div class="reservation_info">
			<h4><s:text name="reservation_info" /> </h4>
			<table>
				<tr>
					<th><s:text name="subroute" /></th>
					<td><s:property value="reservationInfo.subRouteName" /></td>
				</tr>
				<tr>
					<th><s:text name="departure_date" /></th>
					<td><s:property value="reservationInfo.departureDate" /></td>
				</tr>
				<tr>
					<th><s:text name="departure_station_address" /></th>
					<td><s:property value="reservationInfo.departureStationAddress" /></td>
				</tr>
				<tr>
					<th><s:text name="arrival_date" /></th>
					<td><s:property value="reservationInfo.arrivalDate" /></td>
				</tr>
				<tr>
					<th><s:text name="arrival_station_address" /></th>
					<td><s:property value="reservationInfo.arrivalStationAddress" /></td>
				</tr>
				<tr>
					<th><s:text name="seat_numbers" /></th>
					<td><s:property value="reservationInfo.seatNumbers" /></td>
				</tr>
			</table>
		</div>
		<div class="payment_info">
			<table>
				<tr>
					<th><s:text name="payment_method" /></th>
					<td><s:select list="paymentMethods" listKey="id" listValue="name" name="paymentMethodId" /></td>
				</tr>
				<tr>
					<th><s:text name="ticket_price" /></th>
					<td><s:property value="reservationInfo.basePrice" /> <s:property value="reservationInfo.currency" /><br />
						= $<s:property value="reservationInfo.basePriceInUSD" /></td>
				</tr>
				<tr>
					<th><s:text name="online_transaction_fee" /></th>
					<td id="transactionFee"><s:property value="reservationInfo.transactionFee" /> <s:property value="reservationInfo.currency" /><br />
						= $<s:property value="reservationInfo.transactionFeeInUSD" /></td>
				</tr>
				<tr>
					<th><s:text name="total_amount" /></th>
					<td id="totalAmount"><s:property value="reservationInfo.totalAmount" /> <s:property value="reservationInfo.currency" /><br />
						= $<s:property value="reservationInfo.totalAmountInUSD" /></td>
				</tr>
			</table>
			<input type="button" class="pay" id="pay01020" value='<s:text name="pay" />' />
		</div>
	</form>
	<jsp:include page="../common/footer.jsp" />
	</body>
</html>
	