<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	    <div class="container">
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
	    <div class="container">
	        <div class="span8" style="margin-left: 0px;">
	            <div class="seat-map well well-small">
	                <div class="seat-map-wrapper">
	                    <div class="seat-map-inner" style="">
	                        <div class="seat-map-row">
	                            <div class="seat"><img class="seat-img" src="../images/bus-one-seat.png" alt="" data-seat="11"></div>
	                            <div class="seat"><img class="seat-img" src="../images/bus-one-seat.png" alt="" data-seat="10"></div>
	                            <div class="seat"><img class="seat-img" src="../images/bus-one-seat.png" alt="" data-seat="9"></div>
	                            <div class="seat"><img class="seat-img" src="../images/bus-one-seat.png" alt="" data-seat="8"></div>
	                            <div class="seat"><img class="seat-img" src="../images/bus-one-seat.png" alt="" data-seat="7"></div>
	                            <div class="seat"><img class="seat-img" src="../images/bus-one-seat.png" alt="" data-seat="6"></div>
	                            <div class="seat"><img class="seat-img" src="../images/bus-one-seat.png" alt="" data-seat="5"></div>
	                            <div class="seat"><img class="seat-img" src="../images/bus-one-seat.png" alt="" data-seat="4"></div>
	                            <div class="seat"><img class="seat-img" src="../images/bus-one-seat.png" alt="" data-seat="3"></div>
	                            <div class="seat"><img class="seat-img" src="../images/bus-one-seat.png" alt="" data-seat="2"></div>
	                            <div class="seat"><img class="seat-img" src="../images/bus-one-seat.png" alt="" data-seat="1"></div>
	                        </div>
	                        <div class="seat-map-row">
	                            <div class="seat"><img class="seat-img" src="../images/bus-one-seat.png" alt="" data-seat="12"></div>
	                            <div class="seat"><img class="seat-img" src="../images/bus-one-seat.png" alt="" data-seat="13"></div>
	                            <div class="seat"><img class="seat-img" src="../images/bus-one-seat.png" alt="" data-seat="14"></div>
	                            <div class="seat"><img class="seat-img" src="../images/bus-one-seat.png" alt="" data-seat="15"></div>
	                            <div class="seat"><img class="seat-img" src="../images/bus-one-seat.png" alt="" data-seat="16"></div>
	                            <div class="seat"><img class="seat-img" src="../images/bus-one-seat.png" alt="" data-seat="17"></div>
	                            <div class="seat"><img class="seat-img" src="../images/bus-one-seat.png" alt="" data-seat="18"></div>
	                            <div class="seat"><img class="seat-img" src="../images/bus-one-seat.png" alt="" data-seat="19"></div>
	                            <div class="seat"><img class="seat-img" src="../images/bus-one-seat.png" alt="" data-seat="20"></div>
	                            <div class="seat"><img class="seat-img" src="../images/bus-one-seat.png" alt="" data-seat="21"></div>
	                            <div class="seat"><img class="seat-img" src="../images/bus-one-seat.png" alt="" data-seat="22"></div>
	                        </div>
	                        <div class="seat-map-row">
	                            <div class="seat"><img class="seat-img" src="../images/bus-one-seat.png" alt="" data-seat="23"></div>
	                        </div>
	                        <div class="seat-map-row">
	                            <div class="seat"><img class="seat-img" src="../images/bus-one-seat.png" alt="" data-seat="24"></div>
	                            <div class="seat"><img class="seat-img" src="../images/bus-one-seat.png" alt="" data-seat="25"></div>
	                            <div class="seat"><img class="seat-img" src="../images/bus-one-seat.png" alt="" data-seat="26"></div>
	                            <div class="seat"><img class="seat-img" src="../images/bus-one-seat.png" alt="" data-seat="27"></div>
	                            <div class="seat"><img class="seat-img" src="../images/bus-one-seat.png" alt="" data-seat="28"></div>
	                            <div class="seat"><img class="seat-img" src="../images/bus-one-seat.png" alt="" data-seat="29"></div>
	                            <div class="seat"><img class="seat-img" src="../images/bus-one-seat.png" alt="" data-seat="30"></div>
	                            <div class="seat"><img class="seat-img" src="../images/bus-one-seat.png" alt="" data-seat="31"></div>
	                            <div class="seat"><img class="seat-img" src="../images/bus-one-seat.png" alt="" data-seat="32"></div>
	                            <div class="seat"><img class="seat-img" src="../images/bus-one-seat.png" alt="" data-seat="33"></div>
	                            <div class="seat"><img class="seat-img" src="../images/bus-one-seat.png" alt="" data-seat="34"></div>
	                        </div>
	                        <div class="seat-map-row">
	                            <div class="seat"><img class="seat-img" src="../images/bus-one-seat.png" alt="" data-seat="35"></div>
	                            <div class="seat"><img class="seat-img" src="../images/bus-one-seat.png" alt="" data-seat="36"></div>
	                            <div class="seat"><img class="seat-img" src="../images/bus-one-seat.png" alt="" data-seat="37"></div>
	                            <div class="seat"><img class="seat-img" src="../images/bus-one-seat.png" alt="" data-seat="38"></div>
	                            <div class="seat"><img class="seat-img" src="../images/bus-one-seat.png" alt="" data-seat="39"></div>
	                            <div class="seat"><img class="seat-img" src="../images/bus-one-seat.png" alt="" data-seat="40"></div>
	                            <div class="seat"><img class="seat-img" src="../images/bus-one-seat.png" alt="" data-seat="41"></div>
	                            <div class="seat"><img class="seat-img" src="../images/bus-one-seat.png" alt="" data-seat="42"></div>
	                            <div class="seat"><img class="seat-img" src="../images/bus-one-seat.png" alt="" data-seat="43"></div>
	                            <div class="seat"><img class="seat-img" src="../images/bus-one-seat.png" alt="" data-seat="44"></div>
	                            <div class="seat"><img class="seat-img" src="../images/bus-one-seat.png" alt="" data-seat="45"></div>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
	        <div class="span4 booking-wrapper">
	            <form class="booking well well-small well-custom">
	                <fieldset>
	                    <legend>Chọn Ghế</legend>
	                    <div>Bạn đã chọn <span class="seat-number">0</span> trên tổng số 5 ghế được chọn</div>
	                    <button class="btn btn-large" style="width: 100%;margin-top: 9px;">Thanh Toán</button>
	                </fieldset>
	            </form>
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
	