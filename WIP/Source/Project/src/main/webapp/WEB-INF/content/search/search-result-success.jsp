<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC 
	"-//W3C//DTD XHTML 1.1 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>VinaBus - Chọn chuyến</title>
<jsp:include page="../common/xheader.jsp" />
<link href="<%=request.getContextPath()%>/styles/search-result.css"
	rel="stylesheet">
<link href="<%=request.getContextPath()%>/styles/booking.css"
	rel="stylesheet">

<link
	href="<%=request.getContextPath()%>/styles/trip/datetimepicker.css"
	rel="stylesheet">
<link href="<%=request.getContextPath()%>/styles/gmap.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/index.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery.dataTables.min.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery.json-2.4.min.js"></script>
<script
	src="<%=request.getContextPath()%>/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBwRnLXPkJ6gSAug6fUJst2Nomn1fLnlAI&sensor=false&region=VN&language=vi"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/markerwithlabel_packed.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/customGMap.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/search/search-result.js"></script>
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<!-- Start small nav -->
	<section class="small-nav">
	<div class="nav-step-wrapper step1">
		<div class="nav-step">
			<div class="nav-step-des"><s:text name="step_1_description"/></div>
		</div>
		<div class="nav-step">
			<div class="nav-step-des" style="color: #008EDB"><s:text name="step_2_description"/></div>
		</div>
		<div class="nav-step">
			<div class="nav-step-des" style="color: #008EDB"><s:text name="step_3_description"/></div>
		</div>
		<div class="nav-step">
			<div class="nav-step-des" style="color: #008EDB"><s:text name="step_4_description"/></div>
		</div>
	</div>
	</section>
	<!-- End small nav -->
	<!-- Start notify message -->
	<section>
	<div class="notify-message"></div>
	</section>
	<!-- End notify message -->
	<section class="body">
	<div class="container">
		<div class="well">
			<!-- Start contents -->
			<s:set name="pssgrNo" value="passengerNo" />
			<s:set name="msgRtn" value="searchMessage"/>
			<script type="text/javascript">				
				
			</script>
			<div>
			<form action="../booking/booking.html">
			
			<!-- <<<***ONWARD INFORMATION***>>> -->
			<s:set name="pssgrNo" value="passengerNo"/>
			<div class="onward-info">
				<legend>
					<span>Chuyến đi</span>
					<span class="map-active onward" title="Hiện bản đồ cho chuyến đi"></span></legend>
				<div class="trip-details" style="display:block;width:100%">
					<span class="blue-bus-ico"></span>
					<span><span class="dept-city"><h5>${deptCity}</h5></span>
					 	<span class="arrow-left"></span><span class="arr-city"><h5>${arrCity}</h5></span>
					</span>
				</div>
				<br/>
				<s:set name="result1" value="resultNo1" />
				<s:set name="result2" value="resultNo2" />
				<s:set name="result3" value="resultNo3" />
				<s:set name="result4" value="resultNo4" />
				<s:set name="result5" value="resultNo5" />
				<s:set name="result6" value="resultNo6" />
				<s:set name="result7" value="resultNo7" />
				<s:if test="%{#result4.size == 0 && #msgRtn != ''}">
				<div style="display:block; margin-left:10px; margin-bottom:15px;">Hiện tại không có chuyến nào vào ngày <strong>${departureDate}</strong>. 
					 Dưới đây là những chuyến có ngày gần với ngày quý khách mong muốn.</div>
					 <br/>
					 </s:if>
				<s:if test="%{#msgRtn == ''}">
					 Hiện tại chuyến đi từ <strong>${deptCity}</strong> đến <strong>${arrCity}</strong> vào ngày <strong>${departureDate}</strong> không có hoặc đã hết vé. Xin quý khách vui lòng thử tìm chuyến vào ngày khác.
				</s:if>	 
				<s:if test="%{#result4.size != 0}">
					<div style="display:block; margin-left:10px; margin-bottom:15px">Vui lòng chọn chuyến đi và nhấn <strong>"Tiếp tục"</strong></div>
				</s:if>
				<!-- ONWARD RESULT HEADER -->
					<div class="result-header onward">
						<s:if test="%{#result1.size != 0}">			
							<span class="list-header onward1">
								<s:date name="resultNo1[0].departureTime" format="dd-MM" />
							</span>		
						</s:if>	
						<s:if test="%{#result2.size != 0}">
							<span class="list-header onward2">
								<s:date name="resultNo2[0].departureTime" format="dd-MM" />
							</span>
						</s:if>	
						<s:if test="%{#result3.size != 0}">
							<span class="list-header onward3">
								<s:date name="resultNo3[0].departureTime" format="dd-MM" />
							</span>	
						</s:if>
						<s:if test="%{#result4.size != 0}">
							<span class="list-header onward4">
								<s:date name="resultNo4[0].departureTime" format="dd-MM"/>
							</span>
						</s:if>
						<s:if test="%{#result5.size != 0}">
							<span class="list-header onward5">
								<s:date name="resultNo5[0].departureTime" format="dd-MM" />
							</span>
						</s:if>
						<s:if test="%{#result6.size != 0}">	
							<span class="list-header onward6">
								<s:date name="resultNo6[0].departureTime" format="dd-MM" />				
							</span>
						</s:if>
						<s:if test="%{#result7.size != 0}">	
							<span class="list-header onward7">
								<s:date name="resultNo7[0].departureTime" format="dd-MM" />							
							</span>
						</s:if>
						</div>
						<!-- ONWARD RESULT TABLE DETAILS -->
					<div class="result-table onward">
						<s:if test="%{#result1.size != 0}">			
							<div class="search-rs-dtl onward1">
								<table class="tbl-trip-list onward1">
									<jsp:include page="../search/search-table-header.jsp" />
									<s:iterator value="resultNo1" status="srStatus" var="sr">
										<jsp:include page="../search/search-table-detail.jsp" />
									</s:iterator>
								</table>	
							</div>							
						</s:if>	
						<s:if test="%{#result2.size != 0}">
							<div class="search-rs-dtl onward2">
								<table class="tbl-trip-list onward2">
									<jsp:include page="../search/search-table-header.jsp" />
									<s:iterator value="resultNo2" status="srStatus" var="sr">
										<jsp:include page="../search/search-table-detail.jsp" />
									</s:iterator>
								</table>	
							</div>
						</s:if>	
						<s:if test="%{#result3.size != 0}">
							<div class="search-rs-dtl onward3">
								<table class="tbl-trip-list onward3">
									<jsp:include page="../search/search-table-header.jsp" />
									<s:iterator value="resultNo3" status="srStatus" var="sr">
										<jsp:include page="../search/search-table-detail.jsp" />
									</s:iterator>
								</table>	
							</div>
						</s:if>
						<s:if test="%{#result4.size != 0}">
							<div class="search-rs-dtl onward4">
								<table class="tbl-trip-list onward4">
									<jsp:include page="../search/search-table-header.jsp" />
									<s:iterator value="resultNo4" status="srStatus" var="sr">
										<jsp:include page="../search/search-table-detail.jsp" />
									</s:iterator>
								</table>	
							</div>
						</s:if>
						<s:if test="%{#result5.size != 0}">
							<div class="search-rs-dtl onward5">
								<table class="tbl-trip-list onward5">
									<jsp:include page="../search/search-table-header.jsp" />
									<s:iterator value="resultNo5" status="srStatus" var="sr">
										<jsp:include page="../search/search-table-detail.jsp" />
									</s:iterator>
								</table>	
							</div>
						</s:if>
						<s:if test="%{#result6.size != 0}">	
							<div class="search-rs-dtl onward6">
								<table class="tbl-trip-list onward6">
									<jsp:include page="../search/search-table-header.jsp" />
									<s:iterator value="resultNo6" status="srStatus" var="sr">
										<jsp:include page="../search/search-table-detail.jsp" />
									</s:iterator>
								</table>	
							</div>
						</s:if>
						<s:if test="%{#result7.size != 0}">	
							<div class="search-rs-dtl onward7">
								<table class="tbl-trip-list onward7">
									<jsp:include page="../search/search-table-header.jsp" />
									<s:iterator value="resultNo7" status="srStatus" var="sr">
										<jsp:include page="../search/search-table-detail.jsp" />
									</s:iterator>
								</table>	
							</div>
						</s:if>
						</div>
			</div>
			
			<!-- <<<***SHOW MAP***>>> -->
			<div class="map-slider">
    			<div id="map" class="map-container"></div>
   			</div>		
   			
			<s:set name="ticketType" value="ticketType" />
			<s:if test="%{#ticketType=='roundtrip'}"> 			
			<!-- <<<***RETURN INFORMATION***>>> -->
			<div class="return-info">
				<legend><span>Chuyến về</span>
						<span class="map-active return" title="Hiện bản đồ cho chuyến về"></span></legend>
				<div class="trip-details" style="display:block;width:100%">
					<span class="blue-bus-ico-ret"></span>
					<span><span class="dept-city"><h5>${deptCity}</h5></span>
					 	<span class="arrow-right"></span><span class="arr-city"><h5>${arrCity}</h5></span>
					</span>
				</div>
				<br/>
				<s:set name="rtnResult1" value="rtnResultNo1" />
				<s:set name="rtnResult2" value="rtnResultNo2" />
				<s:set name="rtnResult3" value="rtnResultNo3" />
				<s:set name="rtnResult4" value="rtnResultNo4" />
				<s:set name="rtnResult5" value="rtnResultNo5" />
				<s:set name="rtnResult6" value="rtnResultNo6" />
				<s:set name="rtnResult7" value="rtnResultNo7" />
				<s:set name="flgRtn" value="rtnExistResultFlag"/>
				<s:if test="%{#rtnResult4.size == 0 && #flgRtn != ''}">
				<div style="display:block; margin-left:10px; margin-bottom:15px;">Hiện tại không có chuyến nào vào ngày <strong>${returnDate}</strong>. 
					 Dưới đây là những chuyến có ngày gần với ngày quý khách mong muốn.</div>
					 <br/>
					 </s:if>
				<s:if test="%{#flgRtn == ''}">
					 Hiện tại chuyến về từ <strong>${arrCity}</strong> đến <strong>${deptCity}</strong> vào ngày <strong>${returnDate}</strong> không có hoặc đã hết vé. Xin quý khách vui lòng thử tìm chuyến vào ngày khác.
				</s:if>	 
				<s:if test="%{#rtnResult4.size != 0}">
					<div style="display:block; margin-left:10px; margin-bottom:15px">Vui lòng chọn chuyến về và nhấn <strong>"Tiếp tục"</strong></div>
				</s:if>
				<!-- RETURN RESULT HEADER -->
					<div class="result-header return">
						<s:if test="%{#rtnResult1.size != 0}">			
							<span class="list-header-rtn return1">
								<s:date name="rtnResultNo1[0].departureTime" format="dd-MM" />
							</span>		
						</s:if>	
						<s:if test="%{#rtnResult2.size != 0}">
							<span class="list-header-rtn return2">
								<s:date name="rtnResultNo2[0].departureTime" format="dd-MM" />
							</span>
						</s:if>	
						<s:if test="%{#rtnResult3.size != 0}">
							<span class="list-header-rtn return3">
								<s:date name="rtnResultNo3[0].departureTime" format="dd-MM" />
							</span>	
						</s:if>
						<s:if test="%{#rtnResult4.size != 0}">
							<span class="list-header-rtn return4">
								<s:date name="rtnResultNo4[0].departureTime" format="dd-MM"/>
							</span>
						</s:if>
						<s:if test="%{#rtnResult5.size != 0}">
							<span class="list-header-rtn return5">
								<s:date name="rtnResultNo5[0].departureTime" format="dd-MM" />
							</span>
						</s:if>
						<s:if test="%{#rtnResult6.size != 0}">	
							<span class="list-header-rtn return6">
								<s:date name="rtnResultNo6[0].departureTime" format="dd-MM" />				
							</span>
						</s:if>
						<s:if test="%{#rtnResult7.size != 0}">	
							<span class="list-header-rtn return7">
								<s:date name="rtnResultNo7[0].departureTime" format="dd-MM" />							
							</span>
						</s:if>
						</div>
						<!-- RETURN RESULT TABLE DETAILS -->
					<div class="result-table return">
						<s:if test="%{#rtnResult1.size != 0}">			
							<div class="search-rs-dtl-rtn return1">
								<table class="tbl-trip-list return1">
									<jsp:include page="../search/search-table-header.jsp" />
									<s:iterator value="rtnResultNo1" status="srStatus" var="sr">
										<jsp:include page="../search/search-table-detail-rtn.jsp" />
									</s:iterator>
								</table>	
							</div>							
						</s:if>	
						<s:if test="%{#rtnResult2.size != 0}">
							<div class="search-rs-dtl-rtn return2">
								<table class="tbl-trip-list return2">
									<jsp:include page="../search/search-table-header.jsp" />
									<s:iterator value="rtnResultNo2" status="srStatus" var="sr">
										<jsp:include page="../search/search-table-detail-rtn.jsp" />
									</s:iterator>
								</table>	
							</div>
						</s:if>	
						<s:if test="%{#rtnResult3.size != 0}">
							<div class="search-rs-dtl-rtn return3">
								<table class="tbl-trip-list return3">
									<jsp:include page="../search/search-table-header.jsp" />
									<s:iterator value="rtnResultNo3" status="srStatus" var="sr">
										<jsp:include page="../search/search-table-detail-rtn.jsp" />
									</s:iterator>
								</table>	
							</div>
						</s:if>
						<s:if test="%{#rtnResult4.size != 0}">
							<div class="search-rs-dtl-rtn return4">
								<table class="tbl-trip-list return4">
									<jsp:include page="../search/search-table-header.jsp" />
									<s:iterator value="rtnResultNo4" status="srStatus" var="sr">
										<jsp:include page="../search/search-table-detail-rtn.jsp" />
									</s:iterator>
								</table>	
							</div>
						</s:if>
						<s:if test="%{#rtnResult5.size != 0}">
							<div class="search-rs-dtl-rtn return5">
								<table class="tbl-trip-list return5">
									<jsp:include page="../search/search-table-header.jsp" />
									<s:iterator value="rtnResultNo5" status="srStatus" var="sr">
										<jsp:include page="../search/search-table-detail-rtn.jsp" />
									</s:iterator>
								</table>	
							</div>
						</s:if>
						<s:if test="%{#rtnResult6.size != 0}">	
							<div class="search-rs-dtl-rtn return6">
								<table class="tbl-trip-list return6">
									<jsp:include page="../search/search-table-header.jsp" />
									<s:iterator value="rtnResultNo6" status="srStatus" var="sr">
										<jsp:include page="../search/search-table-detail-rtn.jsp" />
									</s:iterator>
								</table>	
							</div>
						</s:if>
						<s:if test="%{#rtnResult7.size != 0}">	
							<div class="search-rs-dtl-rtn return7">
								<table class="tbl-trip-list return7">
									<jsp:include page="../search/search-table-header.jsp" />
									<s:iterator value="rtnResultNo7" status="srStatus" var="sr">
										<jsp:include page="../search/search-table-detail-rtn.jsp" />
									</s:iterator>
								</table>	
							</div>
						</s:if>
						</div>
			</div>
			</s:if>
			<input type="hidden" id="passengerNo" value="${passengerNo}" name="passengerNo" /> 
			<input type="hidden" name="outBusStatus" />
			<input type="hidden" name="outDepartTime" /> 
			<input type="hidden" name="outArriveTime" /> 
			<input type="hidden" name="outFare" />	
			<input type="hidden" name="rtnBusStatus" />
			<input type="hidden" name="rtnDepartTime" /> 
			<input type="hidden" name="rtnArriveTime" /> 
			<input type="hidden" name="rtnFare" />	
			</form>
				<div style="overflow: hidden; width: 100%;">
					<button id="confirm-submit"
							class="btn btn-large pull-right btn-primary"
							style="margin-top: 15px; margin-right: 10px;" title="Xác nhận chọn chuyến và chuyển đến trang chọn ghế"><s:text name="next"/></button>
					<a style="margin-top: 15px; margin-right: 30px;" class="btn btn-large pull-right" href="../index.html" title="Quay lại tìm chuyến khác"><s:text name="button.back"/></a>
				</div>	
			</div>
		</div>
			<s:hidden id="rtnFlg" name="rtnExistResultFlag"></s:hidden>
			<s:hidden id="outFlg" name="searchMessage"></s:hidden>
			<s:hidden id="message" name="message"></s:hidden>
	</div>
	</section>

	<!-- Modal trip details-->
	<div id="trip-details" class="modal hide fade" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal"
				aria-hidden="true">×</button>
			<h3 id="myModalLabel">Chi tiết chuyến đi</h3>
		</div>
		<div class="modal-body">
			<table border="0" cellspacing="0" cellpadding="0" id="trips-list" class="tbl-trip-list">
 			<tbody>
			</tbody>
			</table>
		</div>
		<div class="modal-footer">
			<button class="btn" data-dismiss="modal" aria-hidden="true">Đóng</button>
		</div>
	</div>

	<!-- Modal confirm message-->
	<div id="confirm-message" class="modal hide fade" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal"
				aria-hidden="true">×</button>
			<h3 id="myModalLabel">Xác nhận chọn chuyến</h3>
		</div>
		<div class="modal-body">
		</div>
		<div class="modal-footer">
			<button class="btn" data-dismiss="modal" aria-hidden="true">Hủy</button>
			<button class="btn btn-primary">Xác nhận</button>
		</div>
	</div>
	
	<jsp:include page="../common/footer.jsp" />
</body>
</html>
