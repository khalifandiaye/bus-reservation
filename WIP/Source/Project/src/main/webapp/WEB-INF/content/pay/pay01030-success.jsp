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
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<!-- Start small nav -->
	<section class="small-nav">
	    <div class="my-container">
	        <div class="nav-step-wrapper">
	            <div class="nav-step nav-done">
	                <span class="nav-step-num">1</span>
	                <div class="nav-step-header"><s:text name="step_1_header" /></div>
	                <div class="nav-step-des"><s:text name="step_1_description" /></div>
	            </div>
	            <div class="nav-step nav-done" style="margin-left: 100px;">
	                <span class="nav-step-num">2</span>
	                <div class="nav-step-header"><s:text name="step_2_header" /></div>
	                <div class="nav-step-des"><s:text name="step_2_description" /></div>
	            </div>
	            <div class="nav-step nav-done" style="margin-left: 100px;">
	                <span class="nav-step-num">3</span>
	                <div class="nav-step-header"><s:text name="step_3_header" /></div>
	                <div class="nav-step-des"><s:text name="step_3_description" /></div>
	            </div>
	            <div class="nav-step nav-done" style="margin-left: 100px;">
	                <span class="nav-step-num">4</span>
	                <div class="nav-step-header"><s:text name="step_4_header" /></div>
	                <div class="nav-step-des"><s:text name="step_4_description" /></div>
	            </div>
	        </div>
	    </div>
	</section>
	<!-- End small nav -->
	<div class="container">
		<h4><s:text name="reservation_complete" /></h4>
			<div style="width:50%;float:left;padding-top:80px;">
				<div class="reservation_info">
					<h4><s:text name="reservation_info" /> </h4>
					<table class="table table-bordered">
						<tr>
							<th><s:text name="booker" /></th>
							<td><s:property value="reservationInfo.bookerName" /></td>
						</tr>
						<tr>
							<th><s:text name="phone" /></th>
							<td><s:property value="reservationInfo.phone" /></td>
						</tr>
						<tr>
							<th><s:text name="email" /></th>
							<td><s:property value="reservationInfo.email" /></td>
						</tr>
						<tr>
							<th><s:text name="reservation_code" /></th>
							<td><s:property value="reservationCode"/></td>
						</tr>
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
						<tr>
							<th><s:text name="ticket_price" /></th>
							<td><s:property value="reservationInfo.basePrice" /> VND
								= $<s:property value="reservationInfo.basePriceInUSD" /></td>
						</tr>
						<tr>
							<th><s:text name="online_transaction_fee" /></th>
							<td id="transactionFee"><s:property value="reservationInfo.transactionFee" /> VND
								= $<s:property value="reservationInfo.transactionFeeInUSD" /></td>
						</tr>
						<tr>
							<th><s:text name="total_amount" /></th>
							<td id="totalAmount"><s:property value="reservationInfo.totalAmount" /> VND
								= $<s:property value="reservationInfo.totalAmountInUSD" /></td>
						</tr>
					</table>
				</div>
			</div>
	</div>
	<jsp:include page="../common/footer.jsp" />
</body>
</html>
	