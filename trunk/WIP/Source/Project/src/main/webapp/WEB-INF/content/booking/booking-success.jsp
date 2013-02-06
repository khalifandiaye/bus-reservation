<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC 
	"-//W3C//DTD XHTML 1.1 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Đặt Vé</title>
<jsp:include page="../common/xheader.jsp" />
<link href="<%=request.getContextPath()%>/styles/booking.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/booking.js" ></script>
</head>
	<body>
	<jsp:include page="../common/header.jsp" />
	<!-- Start small nav -->
	<section class="small-nav">
	    <div class="my-container">
	        <div class="nav-step-wrapper">
	            <div class="nav-step nav-done">
	                <span class="nav-step-num">1</span>
	                <div class="nav-step-header">Bước 1:</div>
	                <div class="nav-step-des">Chọn xe</div>
	            </div>
	            <div class="nav-step nav-in-progress" style="margin-left: 100px;">
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
	<!-- Start Boooking bus seat -->
	<setion class="booking-bus-seat">
	    <div class="my-container">
	        <div class="well well-small">
	            <div class="seat-map ">
	                <div class="seat-map-wrapper">
	                    <div class="seat-map-inner" style="">
	                    	<s:iterator status="seat" value="seatMap" >
	                  			<s:div cssClass="seat-map-row">
		                  			<s:iterator >
			                  			<s:if test="status != null">
		                   					<s:div cssClass="seat"> 
								  				<s:if test="status != 1">
								  					<span class="seat-name"><s:property value="name" /></span>
			                						<img class="seat-img" src="../images/bus-one-seat.png" alt="" data-seat="<s:property value="name" />" data-status="<s:property value="status" />">
			               						</s:if>
			               						<s:else>
			               							<span class="seat-name"><s:property value="name"/></span>
			               							<img class="seat-img" src="../images/bus-one-seat-sold.png" alt="" data-seat="<s:property value="name" />" data-status="<s:property value="status" />">
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
	            <div class="seat-description" style="overflow: hidden;padding-left:20px;"> 
	            	<div style="width: 33%;float:left">
	            		<img src="../images/bus-one-seat.png" width="20%">
	            		<span>Ghế Trống</span>
	            	</div>
	            	<div style="width: 33%;float:left">
	            		<img src="../images/bus-one-seat-selected.png" width="20%">
	            		<span>Ghế đang chọn</span>
	            	</div>
	            	<div style="width: 33%;float:left">
	            		<img src="../images/bus-one-seat-sold.png" width="20%">
	            		<span>Ghế đã được bán</span>    
	            	</div>
	            </div>
	            <div class="booking-wrapper" style="padding-left: 10px; padding-top: 30px; overflow: hidden;">
		            <form class="booking" action="booking-info.html" method="post">
	                    <div class="pull-right" style="padding-right: 30px;">Bạn đã chọn <span class="seat-number">0</span> trên tổng số 5 ghế được chọn</div>
	                    <input id="selectedSeat" style="display:none" type="text" name="selectedSeat">
	                    <div style="overflow: hidden;width: 100%;">
	                    	<button class="btn btn-large pull-right" style="margin-top: 15px;margin-right: 30px;">Tiếp Tục</button>
	                    </div>
		            </form>
	        	</div>
	        </div>
	        
	    </div>
	</setion>
	<!-- End Booking bus seat -->

	<!-- Start Modal -->
	<section>
	    <div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	        <div class="modal-header">
	            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	            <h3 id="myModalLabel">Thông Báo</h3>
	        </div>
	        <div class="modal-body">
	            <p></p>
	        </div>
	        <div class="modal-footer">
	            <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
	        </div>
	    </div>
	</section>
	<!-- End Modal -->
	<jsp:include page="../common/footer.jsp" /> 
	</body>
</html>
	