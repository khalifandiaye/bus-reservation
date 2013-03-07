<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC 
	"-//W3C//DTD XHTML 1.1 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Bus travel</title>
<jsp:include page="common/xheader.jsp" />
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css" />

<script src="<%=request.getContextPath()%>/js/index.js" ></script>
<script src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script>
<script src="<%=request.getContextPath()%>/js/search-common.js" ></script>
<script type="text/javascript">
    var d = new Date();
	var now = d.toMyString();
    
	$(function(){
        $('#dp1').datepicker({ 
        	dateFormat: 'dd-mm-yy', 
        	minDate: 0, 
        	maxDate: '+3M'
        });
        $('#dp1').val(now);

        $('#dp2').datepicker({ 
        	dateFormat: 'dd-mm-yy', 
        	minDate: 0, 
        	maxDate: '+3M'
        });
        $('#dp2').val(now);
	});
	
    function findArriveCity(){
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
        		 $('#arrivalCity').append('<option value="' + k + '">' + v + '</option>');
        	});
	  }
    });
    }
    
    function showArrive(){
    	$("#input-return").slideToggle(500);
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
		        <form class="well well-custom" id="search-result" action="search/search-result.html">
		                <fieldset>
		                    <legend>ĐẶT VÉ </legend>
		                    <div class="controls controls-row" id="radio-ticket"> 
		                        <div class="radio-ticket-type">
		                            <label class="radio">
		                                <input type="radio" name="ticketType" id="rdoOneway" value="oneway" onclick="showArrive()" checked>
		                                Vé một chiều
		                            </label>
		                            <label class="radio">
		                                <input type="radio" name="ticketType" id="rdoRoundtrip" value="roundtrip" onclick="showArrive()">
		                                Vé khứ hồi
		                            </label>
		                        </div>
		                    </div>
		                    <div class="controls controls-row">
		                        <label>Trạm khởi hành</label>
		                        <s:select list="deptCity" listKey="id" listValue="name" name="departureCity" onchange="findArriveCity()"/>
		                    </div>
		                    <div class="controls controls-row" style="margin-bottom: 10px;border-bottom: 1px #fff dashed;padding-bottom: 5px;">
		                        <label>Trạm kết thúc</label>
		                        <s:select list="arrCity" listKey="id" listValue="name" name="arrivalCity"/>
		                    </div>
		                    <div class="controls controls-row" id="select-pas" style="margin-bottom: 10px;border-bottom: 1px #fff dashed;padding-bottom: 5px;">
		                        <div class="custom-select" >
		                        	<span class="passenger-img">Số lượng hành khách</span>
		                            <select name="passengerNo"> 
		                                <option>1</option> 
		                                <option>2</option>
		                                <option>3</option>
		                                <option>4</option>
		                                <option>5</option>
		                            </select>
		                        </div>
		                    </div>
		                    <div class="controls controls-row" id="input-depart">
		                        <label>Ngày đi</label>
		                        <input type="text" id="dp1" name="departureDate">
		                    </div>
		                    <div class="controls controls-row" id="input-return">
		                        <label>Ngày về</label>
		                        <input type="text" id="dp2" name="returnDate">
		                    </div>
		                    <div class="controls controls-row" id="select-bus-type">
		                        <label>Loại xe bus</label>
		                        <s:select list="busType" listKey="id" listValue="name" name="busType"/>
		                    </div>
		                    <input type="submit" class="pull-right btn btn-large" style="width: 100%;margin-top: 9px;" value="Đặt Vé"/>
		                    <!-- <a id="btn-change" href="#" class="pull-right" style="color: #fff;padding-top: 15px;" onclick="showMore()">Đặt vé chi tiết</a> -->
		                </fieldset>
		            </form>
	        </div>
	        
    <div class="slider"> 
        <div> 
            <div id="myCarousel" class="carousel slide">
                <div class="carousel-inner">
                    <div class="active item">
                        <img src="http://wbpreview.com/previews/WB03P6MDJ/images/slides/slide_3.jpg" />
                    </div>
                    <div class="item">
                        <img src="http://wbpreview.com/previews/WB03P6MDJ/images/slides/slide_1.jpg" />
                    </div>
                </div>
                <!-- Carousel nav -->
                <a class="carousel-control left" href="#myCarousel" data-slide="prev"><i class="icon-chevron-left"></i></a>
                <a class="carousel-control right" href="#myCarousel" data-slide="next"><i class="icon-chevron-right"></i></a>
            </div>
        </div>
    </div>
	</section>
	
	
	<!-- End slider -->
	<!-- Start services -->
	<section class="services">
	    <div class="container">
	        <div class="row">
	            <div class="span3">
	                <div class="well well-small">
	                    <h5>Tp.Hồ Chí Minh - Biên Hòa</h5>
	                    <p>Nhân dịp nghỉ tết giá vé tăng 100%</p>
	                    <a class="btn btn-mini" href="#">Đặt vé ngay</a>
	                </div>
	            </div>
	            <div class="span3">
	                <div class="well well-small">
	                    <h5>Biên Hòa - Tp.Hồ Chí Minh</h5>
	                    <p>Nhân dịp tết giảm 50%</p>
	                    <a class="btn btn-mini" href="#">Đặt vé ngay</a>
	                </div>
	            </div>
	            <div class="span3">
	                <div class="well well-small">
	                    <h5>Tp.Hồ Chí Minh - Vũng Tàu</h5>
	                    <p>Nhân dịp nghỉ tết giá vé tăng 100%</p>
	                    <a class="btn btn-mini" href="#">Đặt vé ngay</a>
	                </div>
	            </div>
	            <div class="span3">
	                <div class="well well-small">
	                    <h5>Tp.Hồ Chí Minh - Vũng Tàu</h5>
	                    <p>Nhân dịp nghỉ tết giá vé tăng 100%</p>
	                    <a class="btn btn-mini" href="#">Đặt vé ngay</a>
	                </div>
	            </div>
	        </div>
	    </div>
	</section>
	<!-- End services -->
	<section class="body">
		<div class="container">
			<div class="well">
				<legend>Temporary Section</legend>
				
				<input type="submit" id="hello-world" value="Say Hello World" /><br />
				<a href="trip/list.html">Test Create Trip</a><br />
				<a href="busStatus/list.html">Test Get Route</a><br />
				<a href="pay/pay01000.html">Test Pay</a><br />
				<a href="pay/pay02000.html">Test Cancel</a><br />
				<a href="rsv/rsv01000.html">Test Reservation List</a><br />
				<a href="search/search-trip.html">Test Search</a><br />
				<a href="clear-session.html">Clear Session</a><br />
			</div>
		</div>
	</section>
	<!-- Start footer -->
	<jsp:include page="common/footer.jsp" />
	<!-- End footer -->
	</body>
</html>
	