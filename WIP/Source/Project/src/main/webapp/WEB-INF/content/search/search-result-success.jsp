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
	<s:set name="onwardMap" value="onwardMap"/>
	<s:set name="departDayMonth" value="%{departureDate.substring(0,5)}" />
	<s:set name="ticketType" value="ticketType" />
	<s:if test="%{#ticketType == 'roundtrip'}">
		<s:set name="returnMap" value="returnMap"/>
		<s:set name="returnDayMonth" value="%{returnDate.substring(0,5)}" />
	</s:if>
	<div class="notify-message"></div>
<!-- Alert -->	
	<div class="alert alert-info alert-block">
              <button type="button" class="close" data-dismiss="alert">&times;</button>
              <ul>	
              <s:if test="%{!#onwardMap.containsKey(#departDayMonth) && #onwardMap.size != 0 && !#returnMap.containsKey(#returnDayMonth) && #returnMap.size != 0}">
				<li>Chuyến đi từ <strong>${deptCity}</strong> đến <strong>${arrCity}</strong> vào ngày <strong>${departureDate}</strong>
				và chuyến về từ <strong>${arrCity}</strong> đến <strong>${deptCity}</strong> vào ngày <strong>${returnDate}</strong> đều không có hoặc đã hết vé. 
				Chúng tôi đã chọn ra những chuyến có ngày gần với ngày quý khách mong muốn.</li>
			  </s:if>
			  <s:else>
			   <s:if test="%{!#onwardMap.containsKey(#departDayMonth) && #onwardMap.size != 0}">
				<li>Chuyến đi từ <strong>${deptCity}</strong> đến <strong>${arrCity}</strong> vào ngày <strong>${departureDate}</strong> không có hoặc đã hết vé. 
				Chúng tôi đã chọn ra những chuyến có ngày gần với ngày quý khách mong muốn.</li>
			  </s:if>
			   <s:if test="%{!#returnMap.containsKey(#returnDayMonth) && #returnMap.size != 0}">
					<li>Chuyến về từ <strong>${arrCity}</strong> đến <strong>${deptCity}</strong> vào ngày <strong>${returnDate}</strong> không có hoặc đã hết vé. 
					Chúng tôi đã chọn ra những chuyến có ngày gần với ngày quý khách mong muốn.</li>
			  	</s:if>
			  </s:else>
			  <s:if test="%{#ticketType == 'roundtrip'}">
			  		<s:if test="%{#onwardMap.size == 0 && #returnMap.size == 0}">
			  			<li>Chuyến đi từ <strong>${deptCity}</strong> đến <strong>${arrCity}</strong> vào ngày <strong>${departureDate}</strong> và chuyến về từ <strong>${arrCity}</strong> đến <strong>${deptCity}</strong> vào ngày <strong>${returnDate}</strong> đều không có hoặc đã hết vé. 
			  			Xin quý khách vui lòng nhấn <span class="label"><s:text name="button.back"/></span> để tìm chuyến vào ngày khác.</li>
			  		</s:if>
			  		<s:else>
			  			<s:if test="%{#onwardMap.size == 0}">
					 		<li>Chuyến đi từ <strong>${deptCity}</strong> đến <strong>${arrCity}</strong> vào ngày <strong>${departureDate}</strong> không có hoặc đã hết vé. Quý khách có thể chọn chuyến về và nhấn <span class="label label-info"><s:text name="next"/></span> hoặc nhấn <span class="label"><s:text name="button.back"/></span> để tìm chuyến vào ngày khác.</li>
						</s:if>
			  			<s:if test="%{#returnMap.size == 0}">
					 		<li>Chuyến về từ <strong>${arrCity}</strong> đến <strong>${deptCity}</strong> vào ngày <strong>${returnDate}</strong> không có hoặc đã hết vé. Quý khách có thể chọn chuyến đi và nhấn <span class="label label-info"><s:text name="next"/></span> hoặc nhấn <span class="label"><s:text name="button.back"/></span> để tìm chuyến vào ngày khác.</li>
						</s:if>
			  		</s:else>
			  		<s:if test="%{#onwardMap.containsKey(#departDayMonth) && #returnMap.containsKey(#returnDayMonth)}">
						<li>Vui lòng chọn một chuyến đi và một chuyến về rồi nhấn <span class="label label-info"><s:text name="next"/></span></li>
					</s:if>
			  </s:if>
			  <s:else>
			  	<s:if test="%{#onwardMap.size == 0}">
			    <li>Chuyến đi từ <strong>${deptCity}</strong> đến <strong>${arrCity}</strong> vào ngày <strong>${departureDate}</strong> không có hoặc đã hết vé.
			  			Xin quý khách vui lòng nhấn <span class="label"><s:text name="button.back"/></span> để tìm chuyến vào ngày khác.</li>
			  </s:if>
			  <s:if test="%{#onwardMap.containsKey(#departDayMonth)}">
						<li>Vui lòng chọn một chuyến đi rồi nhấn <span class="label label-info"><s:text name="next"/></span></li>
					</s:if>
			</s:else>
			</ul>
    </div>
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
				<div class="trip-result" style="display:block;width:100%">
					<span class="blue-bus-ico"></span>
					<span><span class="dept-city"><h5>${deptCity}</h5></span>
					 	<span class="arrow-left"></span><span class="arr-city"><h5>${arrCity}</h5></span>
					</span>
					<s:if test="%{#onwardMap.size == 0}">
					<span class="label label-warning" style="font-size: 16pt; padding: 6px 5px; -webkit-transform: rotate(-15deg); -moz-transform: rotate(-15deg); margin-left: 20px; margin-bottom: 20px">
						Hết vé</span>
				</s:if>
				</div>
				<br/>
				<s:hidden id="departDayMonth" value="%{departDayMonth}"/>
				<!-- ONWARD RESULT HEADER -->						
				<div class="result-header onward">
					<s:iterator value="onwardMap" status="onwardStt" var="owd">		
							<span class="list-header onward<s:property value="#onwardStt.count" />">
									<s:property	value="key" />
							</span>
					</s:iterator>
				</div>
				<!-- ONWARD RESULT TABLE DETAILS -->
				<div class="tab-content">
					<s:iterator value="onwardMap" status="dateStatus" >
						<div class="search-rs-dtl onward<s:property value="#dateStatus.count" />" id="<s:property value="key"/>">
							<table class="tbl-trip-list onward<s:property value="#dateStatus.count" /> result-table">
								<jsp:include page="../search/search-table-header.jsp" />
								<tbody>
									<s:iterator value="value" status="busTypeStatus">
										<s:iterator value="value" status="listStatus" var="sr">
											<tr class="tripDetails">
												<s:if test="%{#listStatus.index == 0 }">
													<td rowspan="<s:property value="value.size"/>">
														<div style="float: left;"><s:property value="key" /></div>
													</td>
												</s:if>		
												<td class="row choose-item">
													<s:date name="departureTime" format="HH:mm" />
													<s:set name="deptDate" value="%{getText('{0,date,yyyy/MM/dd}',{departureTime})}"/>
													<s:set name="arrDate" value="%{getText('{0,date,yyyy/MM/dd}',{arrivalTime})}"/>
												</td>
												<s:if test="%{#deptDate == #arrDate}">
													<td class="row choose-item" align="center">
				   										<s:date name="arrivalTime" format="HH:mm" />
				   									</td>
												</s:if>
												<s:else>
													<td class="row choose-item">
														<s:date name="arrivalTime" format="dd-MM" /><br>
				   										<s:date name="arrivalTime" format="HH:mm" />
				   									</td> 
												</s:else> 	
												<td class="row">
													<span href="#trip-details" role="button" data-toggle="modal" class="trip-details onward view-details-icon" title="Xem thông tin chi tiết chuyến đi">
													</span>
												</td>
												</td>
												<s:if test="%{segmentNumbers == tripNumbers}">
													<td class="row choose-item">
															<s:property value="getText('{0,number,#,##0}',{(fare - (fare * discountFullRoute)) * 1000})" />
													</td>
												</s:if>
												<s:else>
													<td class="row choose-item"><s:property value="getText('{0,number,#,##0}',{fare * 1000})" /></td>
												</s:else>
												<td class="row choose-item"><s:property value="remainedSeats"/></td>
												<td class="row out-journey-rdo choose-item">
													<input title="Chọn chuyến này" type="checkbox" name="out_journey" id="out_journey" class="chb-out" />		
													<input type="hidden" class="out_status" value="${sr.busStatusId}" />
													<input type="hidden" class="out_deptTime" value="${sr.departureTime}" />
													<input type="hidden" class="out_arrTime" value="${sr.arrivalTime}" />
													<input type="hidden" class="out_fare" value="${sr.fare}" />
													<s:hidden id="routeId" value="%{route}" /></td>
											</tr>
										</s:iterator>
									</s:iterator>
								</tbody>
							</table>
						</div>
					</s:iterator>
				</div>
			</div>
			
			<!-- <<<***SHOW MAP***>>> -->
			<div class="map-slider">
    			<div id="map" class="map-container"></div>
   			</div>		
   			
			<s:if test="%{#ticketType=='roundtrip'}"> 			
			<!-- <<<***RETURN INFORMATION***>>> -->
			<div class="return-info">
				<legend><span>Chuyến về</span>
						<span class="map-active return" title="Hiện bản đồ cho chuyến về"></span></legend>
				<div class="trip-result" style="display:block;width:100%">
					<span class="blue-bus-ico-ret"></span>
					<span><span class="dept-city"><h5>${deptCity}</h5></span>
					 	<span class="arrow-right"></span><span class="arr-city"><h5>${arrCity}</h5></span>
					</span>
					<s:if test="%{#returnMap.size == 0}">
					<span class="label label-warning" style="font-size: 16pt; padding: 6px 5px; -webkit-transform: rotate(-15deg); -moz-transform: rotate(-15deg); margin-left: 20px; margin-bottom: 20px">
						Hết vé</span>
				</s:if>
				</div>
				<br/>
				
				<s:hidden id="returnDayMonth" value="%{returnDayMonth}"/>

				<!-- RETURN RESULT HEADER -->
					<div class="result-header return">
						<s:iterator value="returnMap" status="returnStt" var="ret">		
							<span class="list-header-rtn return<s:property value="#returnStt.count" />">
									<s:property	value="key" />
							</span>
						</s:iterator>
					</div>
				<!-- RETURN RESULT TABLE DETAILS -->
				<div class="tab-content">
					<s:iterator value="returnMap" status="retDateStatus" >
						<div class="search-rs-dtl-rtn return<s:property value="#retDateStatus.count" />" id="<s:property value="key"/>">
							<table class="tbl-trip-list return<s:property value="#retDateStatus.count" /> result-table">
								<jsp:include page="../search/search-table-header.jsp" />
								<tbody>
									<s:iterator value="value" status="retBusTypeStatus">
										<s:iterator value="value" status="retListStatus" var="re">
											<tr class="tripDetails">
												<s:if test="%{#retListStatus.index == 0 }">
													<td rowspan="<s:property value="value.size"/>">
														<div style="float: left;"><s:property value="key" /></div>
													</td>
												</s:if>		
												<td class="row choose-item">
													<s:date name="departureTime" format="HH:mm" />
													<s:set name="deptDate" value="%{getText('{0,date,yyyy/MM/dd}',{departureTime})}"/>
													<s:set name="arrDate" value="%{getText('{0,date,yyyy/MM/dd}',{arrivalTime})}"/>
												</td>
												<s:if test="%{#deptDate == #arrDate}">
													<td class="row choose-item" align="center">
				   										<s:date name="arrivalTime" format="HH:mm" />
				   									</td>
												</s:if>
												<s:else>
													<td class="row choose-item">
														<s:date name="arrivalTime" format="dd-MM" /><br>
				   										<s:date name="arrivalTime" format="HH:mm" />
				   									</td> 
												</s:else> 	
												<td class="row">
													<span href="#trip-details" role="button" data-toggle="modal" class="trip-details return view-details-icon" title="Xem thông tin chi tiết chuyến đi">
													</span>
												</td>
												<s:if test="%{segmentNumbers == tripNumbers}">
													<td class="row choose-item discount">
														<s:property value="getText('{0,number,#,##0}',{(fare - (fare * discountFullRoute)) * 1000})" />
													</td>
												</s:if>
												<s:else>
													<td class="row choose-item"><s:property value="getText('{0,number,#,##0}',{fare * 1000})" /></td>
												</s:else>
												<td class="row choose-item"><s:property value="remainedSeats"/></td>
												<td class="row rtn-journey-rdo choose-item">
													<input title="Chọn chuyến này" type="checkbox" name="rtn_journey" id="rtn_journey" class="chb-ret" />		
													<input type="hidden" class="rtn_status" value="${re.busStatusId}" />
													<input type="hidden" class="rtn_deptTime" value="${re.departureTime}" />
													<input type="hidden" class="rtn_arrTime" value="${re.arrivalTime}" />
													<input type="hidden" class="rtn_fare" value="${re.fare}" />
													<s:hidden id="routeId" value="%{route}" /></td>
											</tr>
										</s:iterator>
									</s:iterator>
								</tbody>
							</table>
						</div>
					</s:iterator>
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
			<span class="confirm-one-way"></span>
		</div>
		<div class="modal-footer">
			<button id="btnCancel" class="btn close-model-btn" data-dismiss="modal" aria-hidden="true">Hủy</button>
			<button id="btnOK" class="btn btn-primary">Xác nhận</button>
		</div>
	</div>
	
	<jsp:include page="../common/footer.jsp" />
</body>
</html>
