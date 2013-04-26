<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC 
	"-//W3C//DTD XHTML 1.1 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title><s:title /></title>
<jsp:include page="../common/xheader.jsp" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/styles/style.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/styles/custom-data-table.css">

<script src="<%=request.getContextPath()%>/js/jquery.validate.min.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery.dataTables.min.js"></script>
<script src="<%=request.getContextPath()%>/js/admin/admin-user.js"></script>
</head>
<body> 
	<jsp:include page="../common/header.jsp" />
	<div class="container">
	<s:actionerror/>
	<div class="well">
		<div>
		<legend>
			Configuration
		</legend>
		<s:form action="settings">
		<s:hidden name="model.updateSettings" value="%{true}" />
		<div>
			<h5>Segment</h5>
			<div class="item" title="Maximum number of segments in a route">
				<label>Max Count</label>
				<span><s:textfield name="model.segment.maxCount" /> segments</span>
			</div>
			<div class="item" title="Default travel time of a segment in hour:minute">
				<label>Default Travel Time</label>
				<span><s:textfield name="model.segment.defaultTravelTime.hour" maxlength="2" />:<s:textfield name="model.segment.defaultTravelTime.minute" maxlength="2" /></span>
			</div>
			<div class="item" title="Default ticket price for a segment">
				<label>Default Price</label>
				<span><s:textfield name="model.segment.defaultPrice" />,000 VND</span>
			</div>
			<div class="item" title="Time for the bus to stop at each station on a trip">
				<label>Rest Interval</label>
				<span><s:textfield name="model.segment.rest" /> minutes</span>
			</div>
		</div>
		<div>
			<h5>Reservation</h5>
			<div class="item" title="Maximum number of seats per reservation">
				<label>Max Seats</label>
				<span><s:textfield name="model.reservation.maxSeat" /> seats</span>
			</div>
			<div class="item" title="Time for unpaid reservation to be deleted">
				<label>Time Out Interval</label>
				<span><s:textfield name="model.reservation.timeout" /> minutes</span>
			</div>
			<div class="item" title="Time before departure day to apply refund rate 1. After this time has passed, the ticket cannot be cancelled">
				<label>Refund limit 1</label>
				<span><s:textfield name="model.reservation.refundTime1" /> days</span>
			</div>
			<div class="item" title="Refund rate 1">
				<label>Refund rate 1</label>
				<span><s:textfield name="model.reservation.refundRate1" />%</span>
			</div>
			<div class="item" title="Time before departure day to apply refund rate 2">
				<label>Refund limit 2</label>
				<span><s:textfield name="model.reservation.refundTime2" /> days before departure</span>
			</div>
			<div class="item" title="Refund rate 2">
				<label>Refund rate 2</label>
				<span><s:textfield name="model.reservation.refundRate2" />%</span>
			</div>
		</div>
		<div>
			<h5>Discount</h5>
			<div class="item" title="Discount amount when a customer books the whole route">
				<label>Whole route</label>
				<span><s:textfield name="model.discount.fullRoute" /> seats</span>
			</div>
		</div>
		<s:submit value="Update" /><s:reset value="Clear" />
		</s:form>
		</div>
		</div>
	</div>
	</div> 
	<jsp:include page="../common/footer.jsp" />
</body>
</html>