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
	<div class="reservation-details">
		<div class="container">
			<div class="well">
				<h3><s:text name="reservationInfo" /></h3>
				<div class="general-info">
					<div class="item">
						<label><s:text name="reservation.booker" /></label>
						<span><s:property value="reservationInfo.bookerName" /></span>
					</div>
					<div class="item">
					<s:if test="%{reservation.code != null && reservation.code != ''}">
						<label><s:text name="reservation.code" /></label>
						<span><s:property value="reservationInfo.code"/></span>
					</s:if>
					</div>
					<div class="item">
						<label><s:text name="reservation.phone" /></label>
						<span><s:property value="reservationInfo.phone" /></span>
					</div>
					<div class="item">
						<label><s:text name="reservation.email" /></label>
						<span><s:property value="reservationInfo.email" /></span>
					</div>
					<div class="item">
						<label><s:text name="reservation.departureDate" /></label>
						<span><s:property value="reservationInfo.tickets[0].departureDate" /></span>
					</div>
					<div class="item">
						<label><s:text name="reservation.status" /></label>
						<span><s:text name="%{reservationInfo.status}" /></span>
					</div>
				</div>
				<div class="ticket-list">
					<table>
						<thead>
							<tr>
								<th><s:text name="index" /></th>
								<th colspan="2"><s:text name="reservation.ticket.station" /></th>
								<th class="datetime"><s:text name="reservation.ticket.departureTime" /> / <s:text name="reservation.ticket.arrivalTime" /></th>
								<th><s:text name="reservation.ticket.seatNumbers" /></th>
								<th><s:text name="reservation.ticket.busType" /></th>
							</tr>
						</thead>
						<tbody>
							<s:iterator value="reservationInfo.tickets" status="status">
								<tr>
									<td class="index" rowspan="2"><s:property value="#status.count" /></td>
									<td class="small"><s:text name="reservation.ticket.from" /></td><td><s:property value="departureStation" /></td>
									<td class="center"><s:property value="departureDate" /></td>
									<td rowspan="2">
										<s:iterator value="seats" ><s:property/> </s:iterator>
									</td>
									<td rowspan="2"><s:property value="busType" /></td>
								</tr>
								<tr>
									<td class="small"><s:text name="reservation.ticket.to" /></td><td><s:property value="arrivalStation" /></td>
									<td class="center"><s:property value="arrivalDate" /></td>
								</tr>
							</s:iterator>
						</tbody>
					</table>
				</div>
				<div class="payment-info">
					<div class="item">
						<label><s:text name="resevation.ticketPrice" /></label>
						<span class="vnd"><s:property value="%{reservationInfo.basePrice + ' đồng'}" /></span>
						<span class="usd"><s:property value="%{'($' + reservationInfo.basePriceInUSD + ')'}" /></span>
					</div>
					<s:if test="%{reservation.transactionFee != null && reservation.transactionFee != ''}">
						<div class="item">
							<label><s:text name="resevation.transactionFee" /></label>
							<span class="vnd"><s:property value="%{reservationInfo.transactionFee + ' đồng'}" /></span>
							<span class="usd"><s:property value="%{'($' + reservationInfo.transactionFeeInUSD + ')'}" /></span>
						</div>
					</s:if>
					<s:if test="%{reservation.totalAmount != null && reservation.totalAmount != ''}">
						<div class="item">
							<label><s:text name="reservation.totalAmount" /></label>
							<span class="vnd"><s:property value="%{reservationInfo.totalAmount + ' đồng'}" /></span>
							<span class="usd"><s:property value="%{'($' + reservationInfo.totalAmountInUSD + ')'}" /></span>
						</div>
					</s:if>
					<s:if test="%{reservation.refundedAmount != null && reservation.refundedAmount != ''}">
						<div class="item">
							<label><s:text name="reservation.refundedAmount" /></label>
							<span class="vnd"><s:property value="%{reservationInfo.refundedAmount + ' đồng'}" /></span>
							<span class="usd"><s:property value="%{'($' + reservationInfo.refundedAmountInUSD + ')'}" /></span>
							<span class="rate"><s:property value="%{'(' + reservationInfo.refundRate + '%)'}" /></span>
						</div>
					</s:if>
				</div>
				<s:url action="rsv01010.html" var="urlBack"></s:url>
	  			<s:a href="%{#urlBack}"><s:text name="button.back" /></s:a>
			</div>
		</div>
	</div>
	<jsp:include page="../common/footer.jsp" />
</body>
</html>
	