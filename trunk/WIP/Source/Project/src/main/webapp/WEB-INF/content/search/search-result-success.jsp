<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC 
	"-//W3C//DTD XHTML 1.1 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Test page</title>
<jsp:include page="../common/xheader.jsp" />
<link href="<%=request.getContextPath()%>/styles/booking.css"
	rel="stylesheet">

<link
	href="<%=request.getContextPath()%>/styles/trip/datetimepicker.css"
	rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/index.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery.dataTables.min.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery.json-2.4.min.js"></script>
<script
	src="<%=request.getContextPath()%>/js/bootstrap-datetimepicker.js"></script>
	<script type="text/javascript">
	function setValue(depart, arrive, fare, status){
		var obj = { departureTime: depart,
					arrivalTime: arrive,
					busStatus: status,
					fare: fare};
		var myString = JSON.stringify(obj);
		$("#tripData").val(myString);
	}
	</script>
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<!-- Start small nav -->
	<section class="small-nav">
	<div class="my-container">
		<div class="nav-step-wrapper">
			<div class="nav-step nav-in-progress">
				<span class="nav-step-num">1</span>
				<div class="nav-step-header">Bước 1:</div>
				<div class="nav-step-des">Chọn chuyến</div>
			</div>
			<div class="nav-step nav-undone" style="margin-left: 100px;">
				<span class="nav-step-num">2</span>
				<div class="nav-step-header">Bước 2:</div>
				<div class="nav-step-des">Chọn ghế</div>
			</div>
			<div class="nav-step nav-undone" style="margin-left: 100px;">
				<span class="nav-step-num">3</span>
				<div class="nav-step-header">Bước 3:</div>
				<div class="nav-step-des">Điền thông tin</div>
			</div>
			<div class="nav-step nav-undone" style="margin-left: 100px;">
				<span class="nav-step-num">4</span>
				<div class="nav-step-header">Bước 4:</div>
				<div class="nav-step-des">Thanh Toán</div>
			</div>
		</div>
	</div>
	</section>
	<!-- End small nav -->
	<section class="body">
	<div class="container">
		<div class="well span11">
			<!-- Start contents -->
			<s:set name="deptCity" value="deptCity" />
			<s:set name="arrCity" value="arrCity" />
			<s:if test="%{#deptCity==''}">
				<legend>Không tìm thấy chuyến</legend>
				<div>Không có chuyến đi nào phù hợp với điều kiện của quý
					khách. Xin vui lòng thử lại.</div>
			</s:if>
			<s:else>
				<legend>Vui lòng chọn chuyến</legend>
				<div id="page">
					<div class="post">
						<form action="../booking/booking.html">
							<div align="center">
								<table border="0" cellspacing="0" cellpadding="0"
									class="bookingPages">
									<tbody>
										<tr>
											<td colspan="4">
												<table width="100%">
													<tbody>
														<tr>
															<td rowspan="3" class="textstyle1" valign="middle">
																<h4>Chuyến đi&nbsp;</h4>
															</td>
															<td class="textstyle1">Từ:&nbsp;</td>
															<td class="textstyle1"><strong><s:property
																		value="#deptCity" /></strong>&nbsp;</td>
															<td rowspan="2" class="textstyle1" align="right"
																valign="middle">Ngày:&nbsp;<strong>${departureDate}</strong></td>
														</tr>
														<tr>
															<td class="textstyle1">Đến:&nbsp;</td>
															<td class="textstyle1"><strong><s:property
																		value="#arrCity" /></strong>&nbsp;</td>
														</tr>
													</tbody>
												</table>
											</td>
										</tr>
										<tr>
											<td colspan="9"><img
												src="http://www.nationalexpress.com/images/shared/s.gif"
												alt="" width="1" height="3" border="0"></td>
										</tr>
										<tr>
											<td colspan="4">
												<table border="0" cellspacing="2" cellpadding="5"
													class="bookingPages"
													summary="A selection of travel times for your outward journey will follow. Please select the journey you would like to book.">
													<tbody>
														<tr>
															<th id="outward_departs">Ngày giờ đi</th>
															<th id="outward_arrive">Ngày giờ đến</th>
															<th id="outward_departs_station">Trạm khởi hành</th>
															<th id="outward_arrive_station">Trạm kết thúc</th>
															<th id="outward_details">Xem chi tiết</th>
															<th id="outward_funfares">Giá vé</th>
															<th id="outward_select" align="left"
																class="bookingHeader">Chọn</th>
														</tr>
														<s:iterator value="searchResult" status="srStatus" var="sr">
															<s:if test="#srStatus.even == true">
																<tr style="background: #CCCCCC">
															</s:if>
																	<td align="center"><s:date name="departureTime"
																			format="dd-MM-yyyy" />&nbsp;<br> <s:date
																			name="departureTime" format="HH:mm" /></td>
																	<td align="center"><s:date name="arrivalTime"
																			format="dd-MM-yyyy" />&nbsp;<br> <s:date
																			name="arrivalTime" format="HH:mm" /></td>
																	<td><s:property value="departureStation" />&nbsp;</td>
																	<td><s:property value="arrivalStation" />&nbsp;</td>
																	<td></td>
																	<td><s:property value="fare" />&nbsp;</td> 
																	<td align="center"><input title="Chọn chuyến này" type="radio"
																		name="out_journey" id="out_journey" value="" /></td>
															<s:if test="#srStatus.even == true">
																</tr>
															</s:if>
														</s:iterator>

													</tbody>
												</table>
											</td>
										</tr>

										<tr>
											<td></td>
											<td valign="middle" align="right" colspan="4"><br>
											</td>
											<td></td>
										</tr>
										<tr>
										<td colspan="3"></td>
										<td><input type="submit" class="pull-right btn btn-small" style="width: 20%;margin-top: 9px;" value="Tiếp tục"/></td>
										</tr>
									</tbody>
								</table>            
								<input type="hidden" id="passengerNo" value="${passengerNo}" name="passengerNo"/>
							</div>
						</form>
			</s:else>
		</div>
	</div>
	</section>

	<jsp:include page="../common/footer.jsp" />
</body>
</html>
