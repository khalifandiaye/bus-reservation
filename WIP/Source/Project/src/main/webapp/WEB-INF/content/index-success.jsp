<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC 
	"-//W3C//DTD XHTML 1.1 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>VinaBus - Trang chủ</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/styles/jquery-ui.css" />
<jsp:include page="common/xheader.jsp" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/styles/select2.css" />
<script src="<%=request.getContextPath()%>/js/index.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery-ui.js"></script>
<script src="<%=request.getContextPath()%>/js/search-common.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery.ui.datepicker-vi.js"></script>
<script src="<%=request.getContextPath()%>/js/select2.min.js"></script>
<script type="text/javascript">
	var d = new Date();
	var now = d.toMyString();
	d.setDate(d.getDate() + 1);
	var next = d.toMyString();
	var duration = 0;
/*     $(':radio[value="oneway"]').on('click', function() {
  	 	$("#input-return").hide(500);
  	});
  
  	$(':radio[value="roundtrip"]').on('click', function() {
  		$("#input-return").show(500);
  	}); */
  
	$(function() {
		$('#dp1').datepicker({
			dateFormat : 'dd-mm-yy',
			minDate : 0,
			maxDate : '+3M',
			regional : 'vi'
		});
		$('#dp1').val(now);

		$('#dp2').datepicker({
			dateFormat : 'dd-mm-yy',
			minDate : 0,
			maxDate : '+3M',
			regional : 'vi'
		});
		$('#dp2').val(next);
			
		$("#dp1").change(function() {
		  	setMinDate();
		});
		
		getDuration();
		
		$("#departureCity").select2();
		$("#arrivalCity").select2();
		
		if($('#rdoOneway').prop('checked')){
			$("#input-return").hide(500);
		} else {
			$("#input-return").show(500);
		}
	});

	function findArriveCity() {
		$.ajax({
			type : "GET",
			url : $('#contextPath').val() + "/search/getArriveCity.html",
			data : {
				deptCity : $('#departureCity option:selected').val()
			},
			success : function(data) {
				$('#arrivalCity option').remove();
				$.each(data.cityList, function(k, v) {
					/// do stuff
					$('#arrivalCity').append(
							'<option value="' + k + '">' + v + '</option>');
				});
			}
		});
		getDuration();
	}
	
	function getDuration() {
		if(console) {
			console.log('getDuration');
		}
		$.ajax({
			type : "GET",
			url : $('#contextPath').val() + "/search/getTravelTime.html",
			data : {
				deptCity : $('#departureCity option:selected').val(),
				arrCity : $('#arrivalCity option:selected').val()
			},
			success : function(data) {
				duration = parseInt(data.duration);
				console.log(data);
				setMinDate();
			}
		});
	}
	
	function setMinDate(){
		  	test = $("#dp1").datepicker('getDate');
		    testm = new Date(test.getTime());
		    testm.setDate(testm.getDate() + duration);
		  	console.log(testm);
		    $("#dp2").datepicker("option", "minDate", testm);
	}

 	function showArrive() {
 		$("#input-return").show(500);
 	}
 	
 	function hideArrive(){
 		$("#input-return").hide(500);
 	}
</script>
</head>
<body>
	<!-- Start header -->
	<jsp:include page="common/header.jsp" />
	<!-- End header -->
	<!-- Start slider -->
	<section class="slider-search" style="float:left;width:100%">
	<div class="search" style="margin-left: 0px">
		<form class="well well-custom" id="search-result"
			action="search/search-result.html">
			<fieldset>
				<legend>ĐẶT VÉ </legend>
				<div class="controls controls-row" id="radio-ticket">
					<div class="radio-ticket-type">
						<label class="radio"> <input type="radio"
							name="ticketType" id="rdoOneway" value="oneway"
							checked onclick="hideArrive()"> Vé một chiều
						</label> <label class="radio"> <input type="radio"
							name="ticketType" id="rdoRoundtrip" value="roundtrip"
							onclick="showArrive()">Vé khứ hồi
						</label>
					</div>
				</div>
				<div class="controls controls-row">
					<label>Điểm đi</label>
					<s:select list="deptCity" listKey="id" listValue="name"
						name="departureCity" onchange="findArriveCity()" style="width:100%;"/>
				</div>
				<div class="controls controls-row"
					style="margin-bottom: 10px; padding-top:10px; border-bottom: 1px #fff dashed; padding-bottom: 15px;">
					<label>Điểm đến</label>
					<s:select list="arrCity" listKey="id" listValue="name"
						name="arrivalCity" onchange="getDuration()" style="width:100%"/>
				</div>
				<div class="controls controls-row" id="input-depart">
					<label>Ngày đi</label> <input type="text" id="dp1"
						name="departureDate">
				</div>
				<div class="controls controls-row" id="input-return">
					<label>Ngày về</label> <input type="text" id="dp2"
						name="returnDate">
				</div>
				<input type="submit" class="pull-right btn btn-large"
					style="width: 100%; margin-top: 9px;" value="Đặt Vé" />
				<!-- <a id="btn-change" href="#" class="pull-right" style="color: #fff;padding-top: 15px;" onclick="showMore()">Đặt vé chi tiết</a> -->
			</fieldset>
		</form>
	</div>

	<div class="slider">
		<div id="myCarousel" class="carousel slide">
			<div class="carousel-inner"> 
				<div class="active item">
					<img src="<%=request.getContextPath()%>/img/image1.jpg" />
				</div>
				<div class="item">
					<img src="<%=request.getContextPath()%>/img/image2.jpg" />
				</div>
				<div class="item">
					<img src="<%=request.getContextPath()%>/img/image3.jpg" />
				</div>
				<div class="item">
					<img src="<%=request.getContextPath()%>/img/image4.jpg" />
				</div>
			</div>
			<!-- Carousel nav -->
			<a class="carousel-control left" href="#myCarousel" data-slide="prev"><i
				class="icon-chevron-left"></i></a> <a class="carousel-control right"
				href="#myCarousel" data-slide="next"><i
				class="icon-chevron-right"></i></a>
		</div>
		 
		<div class="news" style="margin-top: 20px;">
			<h4>Chuyến sắp khởi hành</h4>
			<table width="100%">    
			<s:iterator value="list4Info">
				<tr height="35px;"> 
					<td style="padding-left: 15px;">  
						<s:property value="name"/>
					</td>
					<td>
						<s:property value="departureTime"/>
					</td>
					<td>
						<a href="booking/booking.html?out_journey=on&outBusStatus=<s:property value="busStatusId"/>&outDepartTime=<s:property value="departureTimeFull"/>&outArriveTime=<s:property value="arrivalTimeFull"/>" class="btn btn-primary btn-mini">Đặt vé ngay</a>
					</td>
				</tr>
			</s:iterator>
			</table>
		</div> 
	</div>
	</section>
	<!-- End slider -->

<%-- 	<section class="body"> --%>
<!-- 	<div class="container"> -->
<!-- 		<div class="well"> -->
<!-- 			<legend>Temporary Section</legend> -->

<!-- 			<input type="submit" id="hello-world" value="Say Hello World" /><br /> -->
<!-- 			<a href="trip/list.html">Test Create Trip</a><br /> <a -->
<!-- 				href="busStatus/list.html">Test Get Route</a><br /> <a -->
<!-- 				href="pay/pay01000.html">Test Pay</a><br /> <a -->
<!-- 				href="pay/pay02000.html">Test Cancel</a><br /> <a -->
<!-- 				href="rsv/rsv01000.html">Test Reservation List</a><br /> <a -->
<!-- 				href="search/search-trip.html">Test Search</a><br /> <a -->
<!-- 				href="clear-session.html">Clear Session</a><br /> -->
<!-- 		</div> -->
<!-- 	</div> -->
<%-- 	</section> --%>
	<!-- Start footer -->
	<jsp:include page="common/footer.jsp" />
	<!-- End footer -->
</body>
</html>
