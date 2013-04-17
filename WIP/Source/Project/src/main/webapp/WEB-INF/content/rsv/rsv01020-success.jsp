<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC 
	"-//W3C//DTD XHTML 1.1 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><s:text name="title.rsv01020" /></title>
<jsp:include page="../common/xheader.jsp" />
<link href="<%=request.getContextPath()%>/styles/booking.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/styles/pay.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/rsv/rsv01020.js"></script>
</head>
<body>
	<div class="not-printable">
	<jsp:include page="../common/header.jsp" />
	<div class="reservation-details">
		<div class="container">
			<div class="well">
				<legend>
					<s:text name="reservationInfo" />
					<img id="btnPrint" class="click-able" src="<%=request.getContextPath()%>/images/print.png" alt="<s:text name="label.print" />" style="margin-left: 40px;"/>
					<s:url action="rsv01030.html" namespace="/rsv/" var="pdfUrl">
						<s:param name="id" value="%{reservationInfo.id}" />
					</s:url>
					<s:a href="%{#pdfUrl}"><img id="btnPrintPDF" class="click-able" src="<%=request.getContextPath()%>/images/print-pdf.png" alt="<s:text name="label.print-pdf" />" style="margin-left:10px;"/></s:a>
				</legend>
				<div class="general-info">
					<div class="item">
						<label><s:text name="reservation.booker" /></label>
						<span><s:property value="reservationInfo.bookerName" /></span>
					</div>
					<div class="item">
					<s:if test="%{reservationInfo.code != null && reservationInfo.code != ''}">
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
				 	<s:if test="%{reservationInfo.status == 'cancelled' || reservationInfo.status == 'refunded' || reservationInfo.status == 'refunded2'}" >
					<div class="item long">
						<label><s:text name="label.reservation.cancelReason" /></label>
						<span>
							<s:if test="%{reservationInfo.status == 'cancelled' || reservationInfo.status == 'refunded2'}" >
								<s:text name="message.cancelReason.companySide">
									<s:param><s:property value="reservationInfo.cancelReason" /></s:param>
								</s:text>
							</s:if>
							<s:else>
								<s:text name="message.cancelReason.customerSide">Cancelled by customer</s:text>
							</s:else>
						</span>
					</div>
			 		</s:if>
				</div>
				<div class="clear-fix">
					<table class="ticket-list">
						<thead>
							<tr>
								<th><s:text name="index" /></th>
								<th colspan="2"><s:text name="reservation.ticket.station" /></th>
								<th class="datetime"><s:text name="reservation.ticket.departureTime" /> / <s:text name="reservation.ticket.arrivalTime" /></th>
								<th><s:text name="reservation.ticket.seatNumbers" /></th>
								<th><s:text name="reservation.ticket.busType" /></th>
								<th><s:text name="cancel" /></th>
							</tr>
						</thead>
						<tbody>
							<s:iterator value="reservationInfo.tickets" status="status">
							<s:if test="returnTrip">
								<tr class="return">
							</s:if>
							<s:else>
								<tr>
							</s:else>
									<td class="index" rowspan="2"><s:property value="#status.count" /></td>
									<td class="small"><s:text name="reservation.ticket.from" /></td><td><s:property value="departureStation" /></td>
									<td class="center"><s:property value="departureDate" /></td>
									<td rowspan="2">
										<s:iterator value="seats" ><s:property/> </s:iterator>
									</td>
									<td rowspan="2"><s:property value="busType" /></td>
									<td rowspan="2">
										<s:if test="%{status == 'active' && reservationInfo.status != unpaid}" >
											<a id="<s:property value="%{'cancel_' + id}"/>" href="#">
												<s:text name="cancel" />
											</a>
										</s:if>
										<s:else ><s:text name="%{status}" /></s:else> <s:if test="%{status == 'cancelled' || status == 'refunded2'}" ><br /><span><s:text name="label.reason" /> <s:text name="message.cancelReason.companySide"><s:param><s:property value="cancelReason" /></s:param></s:text></span></s:if>
										<s:elseif test="%{status == 'refunded'}" ><br /><span><s:text name="label.reason" /> <s:text name="message.cancelReason.customerSide" /></span></s:elseif>
									</td>
								</tr>
							<s:if test="returnTrip">
								<tr class="return">
							</s:if>
							<s:else>
								<tr>
							</s:else>
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
					<s:if test="%{reservationInfo.transactionFee != null && reservationInfo.transactionFee != ''}">
						<div class="item">
							<label><s:text name="resevation.transactionFee" /></label>
							<span class="vnd"><s:property value="%{reservationInfo.transactionFee + ' đồng'}" /></span>
							<span class="usd"><s:property value="%{'($' + reservationInfo.transactionFeeInUSD + ')'}" /></span>
						</div>
					</s:if>
					<s:if test="%{reservationInfo.totalAmount != null && reservationInfo.totalAmount != ''}">
						<div class="item">
							<label><s:text name="reservation.totalAmount" /></label>
							<span class="vnd"><s:property value="%{reservationInfo.totalAmount + ' đồng'}" /></span>
							<span class="usd"><s:property value="%{'($' + reservationInfo.totalAmountInUSD + ')'}" /></span>
						</div>
					</s:if>
					<s:if test="%{reservationInfo.refundedAmount != null && reservationInfo.refundedAmount != ''}">
						<div class="item">
							<label><s:text name="reservation.refundedAmount" /></label>
							<span class="vnd"><s:property value="%{reservationInfo.refundedAmount + ' đồng'}" /></span>
							<span class="usd"><s:property value="%{'($' + reservationInfo.refundedAmountInUSD + ')'}" /></span>
						</div>
					</s:if>
				</div>
				<s:url action="rsv01010.html" var="urlBack"></s:url>
	  			<s:a cssClass="btn btn-large" href="%{#urlBack}"><s:text name="button.back" /></s:a>
			</div>
		</div>
	</div>
	<jsp:include page="../common/footer.jsp" />
	<!-- Cancel modal -->
	<div id="cancelModal" class="modal hide fade">
		<input type="hidden" name="cancelReservationId" />
		<div class="modal-header">
			<button type="button" class="close close-model-btn">×</button>
			<h3 id="myModalLabel"><s:text name="header.cancelReservation" /></h3>
		</div>
		<div class="modal-body">
			<p id="cancelErrorMessage" class="error"></p>
			<p id="cancelConfirmMessage"></p>
		</div>
		<div class="modal-footer">
			<button id="btnClose" class="btn close-model-btn btn-primary hidden"><s:text name="button.close" /></button>
			<button id="btnNo" class="btn close-model-btn"><s:text name="button.close" /></button>
			<button id="btnCancel" class="btn btn-danger"><s:text name="cancel" /></button>
		</div>
	</div>
	</div>
	<div class="printable">
		<legend>
			<s:text name="reservationInfo" />
		</legend>
		<div class="general-info">
			<div class="item">
				<label><s:text name="reservation.booker" /></label>
				<span><s:property value="reservationInfo.bookerName" /></span>
			</div>
			<div class="item">
			<s:if test="%{reservationInfo.code != null && reservationInfo.code != ''}">
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
		 	<s:if test="%{reservationInfo.status == 'cancelled' || reservationInfo.status == 'refunded' || reservationInfo.status == 'refunded2'}" >
			<div class="item long">
				<label><s:text name="label.reservation.cancelReason" /></label>
				<span>
					<s:if test="%{reservationInfo.status == 'cancelled' || reservationInfo.status == 'refunded2'}" >
						<s:text name="message.cancelReason.companySide">
							<s:param><s:property value="reservationInfo.cancelReason" /></s:param>
						</s:text>
					</s:if>
					<s:else>
						<s:text name="message.cancelReason.customerSide">Cancelled by customer</s:text>
					</s:else>
				</span>
			</div>
	 		</s:if>
		</div>
		<div class="clear-fix">
			<table class="ticket-list">
				<thead>
					<tr>
						<th><s:text name="index" /></th>
						<th colspan="2"><s:text name="reservation.ticket.station" /></th>
						<th class="datetime"><s:text name="reservation.ticket.departureTime" /> / <s:text name="reservation.ticket.arrivalTime" /></th>
						<th><s:text name="reservation.ticket.seatNumbers" /></th>
						<th><s:text name="reservation.ticket.busType" /></th>
						<th><s:text name="cancel" /></th>
					</tr>
				</thead>
				<tbody>
					<s:iterator value="reservationInfo.tickets" status="status">
					<s:if test="returnTrip">
						<tr class="return">
					</s:if>
					<s:else>
						<tr>
					</s:else>
							<td class="index" rowspan="2"><s:property value="#status.count" /></td>
							<td class="small"><s:text name="reservation.ticket.from" /></td><td><s:property value="departureStation" /></td>
							<td class="center"><s:property value="departureDate" /></td>
							<td rowspan="2">
								<s:iterator value="seats" ><s:property/> </s:iterator>
							</td>
							<td rowspan="2"><s:property value="busType" /></td>
							<td rowspan="2">
								<s:if test="%{status == 'active' && reservationInfo.status != unpaid}" >
									<a id="<s:property value="%{'cancel_' + id}"/>" href="#">
										<s:text name="cancel" />
									</a>
								</s:if>
								<s:else ><s:text name="%{status}" /></s:else> <s:if test="%{status == 'cancelled' || status == 'refunded2'}" ><br /><span><s:text name="label.reason" /> <s:text name="message.cancelReason.companySide"><s:param><s:property value="cancelReason" /></s:param></s:text></span></s:if>
								<s:elseif test="%{status == 'refunded'}" ><br /><span><s:text name="label.reason" /> <s:text name="message.cancelReason.customerSide" /></span></s:elseif>
							</td>
						</tr>
					<s:if test="returnTrip">
						<tr class="return">
					</s:if>
					<s:else>
						<tr>
					</s:else>
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
			<s:if test="%{reservationInfo.transactionFee != null && reservationInfo.transactionFee != ''}">
				<div class="item">
					<label><s:text name="resevation.transactionFee" /></label>
					<span class="vnd"><s:property value="%{reservationInfo.transactionFee + ' đồng'}" /></span>
					<span class="usd"><s:property value="%{'($' + reservationInfo.transactionFeeInUSD + ')'}" /></span>
				</div>
			</s:if>
			<s:if test="%{reservationInfo.totalAmount != null && reservationInfo.totalAmount != ''}">
				<div class="item">
					<label><s:text name="reservation.totalAmount" /></label>
					<span class="vnd"><s:property value="%{reservationInfo.totalAmount + ' đồng'}" /></span>
					<span class="usd"><s:property value="%{'($' + reservationInfo.totalAmountInUSD + ')'}" /></span>
				</div>
			</s:if>
			<s:if test="%{reservationInfo.refundedAmount != null && reservationInfo.refundedAmount != ''}">
				<div class="item">
					<label><s:text name="reservation.refundedAmount" /></label>
					<span class="vnd"><s:property value="%{reservationInfo.refundedAmount + ' đồng'}" /></span>
					<span class="usd"><s:property value="%{'($' + reservationInfo.refundedAmountInUSD + ')'}" /></span>
				</div>
			</s:if>
		</div>
	</div>
</body>
</html>
	