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
	
	 //notification message on error cases.
	function showPopup(message){
		if($(".notify-message").html().trim()!=""){
			$(".notify-message").empty();
		}
		$(".notify-message").append('<div class="alert fade in"><button type="button" class="close" data-dismiss="alert">×</button>'+message+'</div>');
	}
	
	 //document ready
	$(function() {
		var rtnFlg = $('#rtnFlg').val();
		var outFlg = $('#outFlg').val();
		
		//disable submit button if there're no trips
		if(rtnFlg == '' && outFlg ==''){
			$('#confirm-submit').attr("disabled", "disabled");
			$('#confirm-submit').removeClass('btn-primary');
		}else {
			$('#confirm-submit').removeAttr("disabled");
			$('#confirm-submit').addClass('btn-primary');
		};
		
		//onclick submit button
		$("#confirm-submit").bind("click",function(){
			var outRadio = $('form input[name="out_journey"]:checked');
			var rtnRadio = $('form input[name="rtn_journey"]:checked');
					
			if(rtnRadio.size != 0) {
				
				var depart = $(rtnRadio).siblings('.rtn_deptTime').val();
				var arrive = $(outRadio).siblings('.out_arrTime').val();
				
				//cannot arrive before depart
				if(depart <= arrive){
					if($(".notify-message").html().trim()!=""){
						$(".notify-message").empty();
					}
					$(".notify-message").append('<div class="alert fade in">'+
							'<button type="button" class="close" data-dismiss="alert">×</button>'+
							'Vui lòng chọn chuyến về có thời gian khởi hành sau khi chuyến đi kết thúc.'
							+'</div>');
					return;
				}
				
				//set parameter for return journey
				$('input[name="rtnBusStatus"]').val(
						$(rtnRadio).siblings('.rtn_status').val());
				$('input[name="rtnDepartTime"]').val(
						$(rtnRadio).siblings('.rtn_deptTime').val());
				$('input[name="rtnArriveTime"]').val(
						$(rtnRadio).siblings('.rtn_arrTime').val());
				$('input[name="rtnFare"]').val($(rtnRadio).siblings('.rtn_fare').val());
			}
			//set parameter for onward journey
			$('input[name="outBusStatus"]').val(
					$(outRadio).siblings('.out_status').val());
			$('input[name="outDepartTime"]').val(
					$(outRadio).siblings('.out_deptTime').val());
			$('input[name="outArriveTime"]').val(
					$(outRadio).siblings('.out_arrTime').val());
			$('input[name="outFare"]').val($(outRadio).siblings('.out_fare').val());
			
			$('form').submit(); 
		});
		
		//view trip details
		$('.trip-details').bind(
				'click',
				(function() {
					var className = $(this).attr('class').split(' ')[1];
					//set param for onward journey
					if(className == 'onward') {
					var busStatus = $(this).parent("td").next().next().next().find(
							'.out_status').val();
					var departTime = $(this).parent("td").next().next().next().find(
							'.out_deptTime').val();
					var arriveTime = $(this).parent("td").next().next().next().find(
							'.out_arrTime').val();
					} else {
					//for return journey
					var	busStatus = $(this).parent("td").next().next().next().find(
						'.rtn_status').val();
					var	departTime = $(this).parent("td").next().next().next().find(
						'.rtn_deptTime').val();
					var	arriveTime = $(this).parent("td").next().next().next().find(
						'.rtn_arrTime').val();
					}
					//call ajax
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
							//set data to screen
							//console.log(data.tripList);
							$('#trips-list tbody').empty();
							$('#trips-list tbody').append('<tr class="row">' + 
							'<th class="head">Giờ khởi hành</th>' +
							'<th class="head">Giờ dừng nghỉ</th>' +
							'<th class="head">Trạm khởi hành</th>' +
							'<th class="head">Trạm dừng nghỉ</th>' +
						'</tr>');
							var loop = data.tripList;
							for (var i = 0; i < loop.length; i++) {
								$('#trips-list tbody').append('<tr class="row">'+
										'<td class="cell">' + loop[i]['deptDate'] + '<br/>' + loop[i]['deptTime'] + '</td>' + 
								        '<td class="cell">' + loop[i]['arrDate'] + '<br/>' + loop[i]['arrTime'] + '</td>' +
										'<td class="cell">' + loop[i]['deptCity'] + '<br/>' + loop[i]['deptStat'] + '</td>' +
										'<td class="cell">' + loop[i]['arrCity'] + '<br/>' + loop[i]['arrStat'] + '</td>' +
										'</tr>');
							}
						}
				});
		}));
		
		var $unique = $('input.chb-out');
		var $uniqueRet = $('input.chb-ret');
		//make checkbox act like radio
		$unique.click(function() {
	    	$unique.filter(':checked').not(this).removeAttr('checked');
	   		checkChecked001();
		});
	
	
		$uniqueRet.click(function() {
	    	$uniqueRet.filter(':checked').not(this).removeAttr('checked');
	    	checkChecked001();
		});
	
		//check if at least one journey (onward or return) is checked
		function checkChecked001(){
		 	if($unique.filter(':checked').size() == 0 && 
		 			$uniqueRet.filter(':checked').size() == 0 ){
		    	$('#confirm-submit').attr("disabled", "disabled");
				$('#confirm-submit').removeClass('btn-primary');
		    } else {
		    	$('#confirm-submit').removeAttr("disabled");
				$('#confirm-submit').addClass('btn-primary');
		    }
		}
		
		//show message on error
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
				function checkChecked(){
				 	if($('.chb-out:checked').size() == 0 && $('.chb-ret:checked').size() == 0 ){
				    	$('#confirm-submit').attr("disabled", "disabled");
						$('#confirm-submit').removeClass('btn-primary');
				    } else {
				    	$('#confirm-submit').removeAttr("disabled");
						$('#confirm-submit').addClass('btn-primary');
				    }
				}
				//show result details for onward journey
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
					
					//show result details on click header for return journey
					if($('.list-header-rtn.return4').size()!=0){
						showResultDetailsRtn('return4');
					} else if($('.list-header-rtn.return3').size()!=0){
						showResultDetailsRtn('return3');
					} else if($('.list-header-rtn.return5').size()!=0){
						showResultDetailsRtn('return5');
					} else if($('.list-header-rtn.return2').size()!=0){
						showResultDetailsRtn('return2');
					} else if($('.list-header-rtn.return6').size()!=0){
						showResultDetailsRtn('return6');
					} else if($('.list-header-rtn.return1').size()!=0){
						showResultDetailsRtn('return1');
					} else if($('.list-header-rtn.return7').size()!=0){
						showResultDetailsRtn('return7');
					}
					
					//onlick list-header
					$('.list-header').bind('click',(function() {
						var className = $(this).attr('class').split(' ')[1];
						showResultDetails(className);
					}));
				
					$('.list-header-rtn').bind('click',(function() {
						var rtnClassName = $(this).attr('class').split(' ')[1];
						showResultDetailsRtn(rtnClassName);
					}));				
								
				});
							
				function showResultDetails(headerName){
					$('.search-rs-dtl').hide();	
					$('.search-rs-dtl.' + headerName).show();
					//var checkbox = $('table.' + headerName + ' tr.tripDetails #out_journey')[0];
					$(".chb-out").attr('checked',false);
					$('table.' + headerName + ' tr.tripDetails #out_journey')[0].checked = true;
					checkChecked();
					$('.list-header').removeClass('header-current');
					$('.list-header').addClass('header-default');
					$('.list-header.' + headerName).removeClass('header-default');
					$('.list-header.' + headerName).addClass('header-current');
				}
				
				function showResultDetailsRtn(headerName){
					$('.search-rs-dtl-rtn').hide();	
					$('.search-rs-dtl-rtn.' + headerName).show();
					$(".chb-ret").attr('checked',false);
					$('table.' + headerName + ' tr.tripDetails #rtn_journey')[0].checked = true;
					checkChecked();
					$('.list-header-rtn').removeClass('header-current');
					$('.list-header-rtn').addClass('header-default');
					$('.list-header-rtn.' + headerName).removeClass('header-default');
					$('.list-header-rtn.' + headerName).addClass('header-current');
				}
			</script>
			<div>
			<form action="../booking/booking.html">
			<!-- <<<***ONWARD INFORMATION***>>> -->
			<s:set name="pssgrNo" value="passengerNo"/>
			<div class="onward-info">
				<legend>Chuyến đi</legend>
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
				<div style="display:block; margin-left:10px; margin-bottom:15px;">Hiện tại không có chuyến đi nào vào ngày <strong>${departureDate}</strong>. 
					 Dưới đây là những chuyến đi có ngày gần với ngày quý khách mong muốn.</div>
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
			<s:set name="ticketType" value="ticketType" />
			<s:if test="%{#ticketType=='roundtrip'}">
			<!-- <<<***RETURN INFORMATION***>>> -->
			<div class="return-info">
				<legend>Chuyến về</legend>
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
				<div style="display:block; margin-left:10px; margin-bottom:15px;">Hiện tại không có chuyến đi nào vào ngày <strong>${returnDate}</strong>. 
					 Dưới đây là những chuyến đi có ngày gần với ngày quý khách mong muốn.</div>
					 <br/>
					 </s:if>
				<s:if test="%{#flgRtn == ''}">
					 Hiện tại chuyến đi từ <strong>${arrCity}</strong> đến <strong>${deptCity}</strong> vào ngày <strong>${returnDate}</strong> không có hoặc đã hết vé. Xin quý khách vui lòng thử tìm chuyến vào ngày khác.
				</s:if>	 
				<s:if test="%{#rtnResult4.size != 0}">
					<div style="display:block; margin-left:10px; margin-bottom:15px">Vui lòng chọn chuyến đi và nhấn <strong>"Tiếp tục"</strong></div>
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
							style="margin-top: 15px; margin-right: 10px;" ><s:text name="next"/></button>
					<a style="margin-top: 15px; margin-right: 30px;" class="btn btn-large pull-right" href="../index.html"><s:text name="button.back"/></a>
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
