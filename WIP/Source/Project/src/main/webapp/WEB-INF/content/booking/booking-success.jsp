<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC 
	"-//W3C//DTD XHTML 1.1 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Đặt Vé</title>
<jsp:include page="../common/xheader.jsp" />
<link href="<%=request.getContextPath()%>/styles/booking.css"
	rel="stylesheet"> 
<script src="<%=request.getContextPath()%>/js/booking/booking.js"></script>
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<!-- Start small nav -->
	<section class="small-nav">
	<div class="nav-step-wrapper step2">
		<div class="nav-step">
			<div class="nav-step-des">Chọn chuyến</div>
		</div>
		<div class="nav-step">
			<div class="nav-step-des">Chọn ghế</div>
		</div>
		<div class="nav-step">
			<div class="nav-step-des" style="color: #008EDB">Điền thông tin</div>
		</div>
		<div class="nav-step">
			<div class="nav-step-des" style="color: #008EDB">Thanh Toán</div>
		</div>
	</div>
	</section>
	<!-- End small nav -->
	<!-- Start notify message -->
	<section>
	<div class="notify-message"></div>
	</section>
	<!-- End notify message -->
	<!-- Start Boooking bus seat -->
	<setion class="booking-bus-seat">
	<div class="well">
		<div
			style="font-size: 21px; line-height: 41px; margin: 0 0px 10px 0px;">Vui
			lòng chọn ghế</div>
		<ul class="nav nav-tabs" id="myTab">
			<s:if test="seatMapOut != null">
				<li><a href="#seat-map-out">Chuyến đi</a></li>
			</s:if>
			<s:if test="seatMapReturn != null">
				<li><a href="#seat-map-return">Chuyến về</a></li>
			</s:if>
		</ul>
		<div class="tab-content">
		<s:if test="seatMapOut != null">
			<div id="seat-map-out" class="tab-pane" style="overflow: hidden;">
				<s:if test="seatMapOut.size == 1">
					<div class="seat-map">
						<div class="seat-map-wrapper">
							<div class="seat-map-inner" style="">
								<s:iterator value="seatMapOut">
									<s:iterator>
										<s:div cssClass="seat-map-row">
											<s:iterator>
												<s:if test="status != null">
													<s:div cssClass="seat">
														<s:if test="status != 1">
															<span class="seat-name"><s:property value="name" /></span>
															<img class="seat-img" src="../images/seat-available.png"
																alt="" data-seat="<s:property value="name" />"
																data-status="<s:property value="status"/>"
																data-type="out">
														</s:if>
														<s:else>
															<span class="seat-name"><s:property value="name" /></span>
															<img class="seat-img" src="../images/seat-sold.png"
																alt="" data-seat="<s:property value="name" />"
																data-status="<s:property value="status"/>"
																data-type="out">
														</s:else>
													</s:div>
												</s:if>
												<s:else>
													<!--  no  seat  here -->
												</s:else>
											</s:iterator>
										</s:div>
									</s:iterator>
								</s:iterator>
							</div>
						</div>
					</div>
				</s:if>
				<s:else>
					<s:iterator value="seatMapOut">
						<div class="seat-map ">
							<div class="seat-map-wrapper">
								<div class="seat-map-inner" style="">
									<s:iterator>
										<s:div cssClass="seat-map-row bed-row">
											<s:iterator>
												<s:if test="status != null">
													<s:div cssClass="seat bed-seat">
														<s:if test="status != 1">
															<span class="seat-name"><s:property value="name" /></span>
															<img class="seat-img" src="../img/bed-seat-available.png"
																alt="" data-seat="<s:property value="name" />"
																data-status="<s:property value="status" />">
														</s:if>
														<s:else>
															<span class="seat-name"><s:property value="name" /></span>
															<img class="seat-img" src="../img/bed-seat-sold.png"
																alt="" data-seat="<s:property value="name" />"
																data-status="<s:property value="status" />">
														</s:else>
													</s:div>
												</s:if>
												<s:else>
													<!--  no  seat  here -->
												</s:else>
											</s:iterator>
										</s:div>
									</s:iterator>
								</div>
							</div>
						</div>
					</s:iterator>
				</s:else>
			</div>
		</s:if> 
		<s:if test="seatMapReturn != null">
			<div id="seat-map-return" class="tab-pane" style="overflow: hidden;">
				<s:if test="seatMapReturn.size == 1">
					<div class="seat-map ">
						<div class="seat-map-wrapper">
							<div class="seat-map-inner" style="">
								<s:iterator value="seatMapReturn">
									<s:iterator>
										<s:div cssClass="seat-map-row">
											<s:iterator>
												<s:if test="status != null">
													<s:div cssClass="seat">
														<s:if test="status != 1">
															<span class="seat-name"><s:property value="name" /></span>
															<img class="seat-img" src="../images/seat-available.png"
																alt="" data-seat="<s:property value="name" />"
																data-status="<s:property value="status"/>"
																data-type="return">
														</s:if>
														<s:else>
															<span class="seat-name"><s:property value="name" /></span>
															<img class="seat-img" src="../images/seat-sold.png"
																alt="" data-seat="<s:property value="name" />"
																data-status="<s:property value="status"/>"
																data-type="return">
														</s:else>
													</s:div>
												</s:if>
												<s:else>
													<!--  no  seat  here -->
												</s:else>
											</s:iterator>
										</s:div>
									</s:iterator>
								</s:iterator>
							</div>
						</div>
					</div>
				</s:if>
				<s:else>
					<s:iterator value="seatMapReturn">
						<div class="seat-map ">
							<div class="seat-map-wrapper">
								<div class="seat-map-inner" style="">
									<s:iterator>
										<s:div cssClass="seat-map-row bed-row">
											<s:iterator>
												<s:if test="status != null">
													<s:div cssClass="seat bed-seat">
														<s:if test="status != 1">
															<span class="seat-name"><s:property value="name" /></span>
															<img class="seat-img" src="../img/bed-seat-available.png"
																alt="" data-seat="<s:property value="name" />"
																data-status="<s:property value="status" />">
														</s:if>
														<s:else>
															<span class="seat-name"><s:property value="name" /></span>
															<img class="seat-img" src="../img/bed-seat-sold.png"
																alt="" data-seat="<s:property value="name" />"
																data-status="<s:property value="status" />">
														</s:else>
													</s:div>
												</s:if>
												<s:else>
													<!--  no  seat  here -->
												</s:else>
											</s:iterator>
										</s:div>
									</s:iterator>
								</div>
							</div>
						</div>
					</s:iterator>
				</s:else>
			</div>
		</s:if>
		</div>
		<div class="seat-description"
			style="overflow: hidden; padding-left: 20px;">
			<div style="width: 25%; float: left">
				<img src="../images/seat-available.png" width="25%"> <span>Ghế
					Trống</span>
			</div>
			<div style="width: 25%; float: left">
				<img src="../images/seat-selected.png" width="25%"> <span>Ghế
					đang chọn</span>
			</div>
			<div style="width: 25%; float: left">
				<img src="../images/seat-sold.png" width="25%"> <span>Ghế
					đã được bán</span>
			</div>
			<div style="width: 25%; float: left">
				<img src="../images/seat-block.png" width="25%"> <span>Ghế
					Không được chọn</span>
			</div>
		</div>
		<div class="booking-wrapper"
			style="padding-left: 10px; padding-top: 30px; overflow: hidden;">
			<form class="booking" action="booking-info.html" method="post">
				<div class="pull-right" style="padding-right: 30px;">
					Bạn đã chọn <span class="seat-number">0</span> trên tổng số <span
						class="seat-number-selected"></span> ghế được chọn
				</div>
				<s:hidden id="forwardSeats" name="forwardSeats"></s:hidden>
				<s:hidden id="returnSeats" name="returnSeats"></s:hidden>
			</form>
			<div style="overflow: hidden; width: 100%;">
				<a style="margin-top: 15px; margin-right: 30px;"
					class="btn btn-large pull-left" href="#"
					onclick="history.go(-1);return false;">Quay lại</a>
				<button id="booking-submit"
					class="btn btn-large pull-right btn-primary"
					style="margin-top: 15px; margin-right: 30px;">Tiếp Tục</button>
			</div>
			<s:hidden id="message" name="message"></s:hidden>
			<s:hidden id="selectedOutSeat" name="selectedOutSeat"></s:hidden>
			<s:hidden id="selectedReturnSeat" name="selectedReturnSeat"></s:hidden>
			<s:hidden id="passengerNo" name="passengerNo"></s:hidden>
		</div>
	</div>
	</setion>
	<!-- End Booking bus seat -->
	<jsp:include page="../common/footer.jsp" />
</body>
</html>
