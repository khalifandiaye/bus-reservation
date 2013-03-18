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
<link href="<%=request.getContextPath()%>/styles/search-result.css"
	rel="stylesheet">
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
	/* 	function setValue(depart, arrive, fare, status){
	 var obj = { departureTime: depart,
	 arrivalTime: arrive,
	 busStatus: status,
	 fare: fare};
	 var myString = JSON.stringify(obj);
	 $("#tripData").val(myString);
	 } */

	function setParam() {
		var outRadio = $('form input[name="out_journey"]:checked');
		$('input[name="outBusStatus"]').val(
				$(outRadio).siblings('.out_status').val());
		$('input[name="outDepartTime"]').val(
				$(outRadio).siblings('.out_deptTime').val());
		$('input[name="outArriveTime"]').val(
				$(outRadio).siblings('.out_arrTime').val());
		$('input[name="outFare"]').val($(outRadio).siblings('.out_fare').val());
		return true;
	}

	
	function showPopup(message){
		if($(".notify-message").html().trim()!=""){
			$(".notify-message").empty();
		}
		$(".notify-message").append('<div class="alert fade in"><button type="button" class="close" data-dismiss="alert">×</button>'+message+'</div>');
	}
	
	$(function() {
		$('.trip-details').bind(
				'click',
				(function() {
					var busStatus = $(this).parent("td").next().next().find(
							'.out_status').val();
					var departTime = $(this).parent("td").next().next().find(
							'.out_deptTime').val();
					var arriveTime = $(this).parent("td").next().next().find(
							'.out_arrTime').val();
					//console.log(departTime);
					$.ajax({
						type : "GET",
						url : $('#contextPath').val()
								+ "/search/getTripDetails.html",
						data : {
							busStatus : busStatus,
							departTime : departTime,
							arriveTime : arriveTime
						},
						success : function(data) {
							console.log(data.tripList);
							//$.each(data.tripList, function(k, v) {
							//$('#trips-list tbody').append();
						}
				});
		}));
		if($("#message").val() != null && $("#message").val() != ""){
			showPopup($("#message").val());
		}
		
	});
</script>
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
				$(document).ready(function() {
					if($('.list-header.onward4').size()!=0){
						showResultDetails('onward4');
					} else if($('.list-header.onward3').size()!=0){
						showResultDetails('onward3');
					} else if($('.list-header.onward5').size()!=0){
						showResultDetails('onward5');
					} else if($('.list-header.onward2').size()!=0){
						showResultDetails('onward2');
					} else if($('.list-header.onward6').size()!=0){
						showResultDetails('onward6');
					} else if($('.list-header.onward1').size()!=0){
						showResultDetails('onward1');
					} else if($('.list-header.onward7').size()!=0){
						showResultDetails('onward7');
					}
					
					$('.list-header').bind('click',(function() {
						var className = $(this).attr('class').split(' ')[1];
						showResultDetails(className);
					}));
					
					$('#out_journey').bind(
							'click', (function(){
						
					}));
				});

				function showResultDetails(headerName){
					$('.search-rs-dtl').hide();	
					$('.search-rs-dtl.' + headerName).show();
					$('table.' + headerName + ' tr.tripDetails #out_journey')[0].checked = true;
					$('.list-header').removeClass('header-current');
					$('.list-header').addClass('header-default');
					$('.list-header.' + headerName).removeClass('header-default');
					$('.list-header.' + headerName).addClass('header-current');
				}
				
			</script>
			<div>
			<form action="../booking/booking.html">
			<div class="onward-info">
				<legend>Chuyến đi</legend>
				<div class="trip-details" style="display:block;width:100%">
					<span class="blue-bus-ico"></span>
					<span><h5>${deptCity}</h5>
					 	<span class="arrow-right"></span><h5>${arrCity}</h5>
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
				<s:if test="%{#result4.size == 0 && #msgRtn == ''}">
				<div style="display:block; margin-left:10px; margin-bottom:15px;">Hiện tại không có chuyến đi nào vào ngày <strong>${departureDate}</strong>. 
					 Dưới đây là những chuyến đi có ngày gần với ngày quý khách mong muốn.</div>
					 <br/>
					 </s:if>
				<s:if test="%{#msgRtn != ''}">
					<s:property value="msgRtn"/>. Xin quý khách vui lòng thử lại.
				</s:if>	 
				<s:if test="%{#result4.size != 0}">
					<div style="display:block; margin-left:10px; margin-bottom:15px">Vui lòng chọn chuyến đi và nhấn <strong>"Tiếp tục"</strong></div>
				</s:if>
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
							<div class="search-rs-dtl onward4">
								<table class="tbl-trip-list onward7">
									<jsp:include page="../search/search-table-header.jsp" />
									<s:iterator value="resultNo7" status="srStatus" var="sr">
										<jsp:include page="../search/search-table-detail.jsp" />
									</s:iterator>
								</table>	
							</div>
						</s:if>
						</div>
						<input type="submit"
												onclick="setParam()" class="btn btn-large pull-right btn-primary"
												style="margin-top: 15px; margin-right: 10px;" value="<s:text name="next"/>" />	
			</div>
			<input type="hidden" id="passengerNo" value="${passengerNo}"
									name="passengerNo" /> <input type="hidden" name="outBusStatus" />
								<input type="hidden" name="outDepartTime" /> <input
									type="hidden" name="outArriveTime" /> <input type="hidden"
									name="outFare" />				
			</form>
			</div>
		</div>
			<s:hidden id="message" name="message"></s:hidden>
	</div>
	</section>

	<!-- Modal -->
	<div id="trip-details" class="modal hide fade" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal"
				aria-hidden="true">×</button>
			<h3 id="myModalLabel">Chi tiết chuyến đi</h3>
		</div>
		<div class="modal-body">
			<table border="0" cellspacing="0" cellpadding="0" id="trips-list">
				<thead>
					<tr>
						<th>Giờ khởi hành</th>
						<th>Giờ dừng nghỉ</th>
						<th>Trạm khởi hành</th>
						<th>Trạm dừng nghỉ</th>
					</tr>
				</thead>
				<tbody>

				</tbody>
			</table>
		</div>
		<div class="modal-footer">
			<button class="btn" data-dismiss="modal" aria-hidden="true">Đóng</button>
		</div>
	</div>


	<jsp:include page="../common/footer.jsp" />
</body>
</html>
