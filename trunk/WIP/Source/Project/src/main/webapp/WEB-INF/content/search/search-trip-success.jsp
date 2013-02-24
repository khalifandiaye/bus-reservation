<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC 
	"-//W3C//DTD XHTML 1.1 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bus Travel</title>
    <!-- Fonts -->
    <link href = 'http://fonts.googleapis.com/css?family=Open+Sans:400,400italic,600,800' rel = 'stylesheet' type = 'text/css'>
    
    <jsp:include page="../common/xheader.jsp" />
    <script src="<%=request.getContextPath()%>/js/index.js" ></script>
    <script src="<%=request.getContextPath()%>/js/bootstrap-datepicker.js" ></script>
    <script type="text/javascript">
        function showMore(){
            $("#radio-ticket,#select-pas,#input-depart,#input-return,#select-bus-type,#guide-booking").slideToggle(500);
        }

    </script>
</head>
<body>
<!-- Start header -->
<jsp:include page="../common/header.jsp" />
<!-- End header -->
<!-- Start slider -->
<section class="slider-search" >
    <div class="container">
        <div class="slider span8" style="margin-left: 0px;">
            <div class="well" id="guide-booking">
                <img src="images/guide.png" alt="booking guide" >
            </div>
            <div class="well">
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
        <div class="search span4 ">
        <form class="well well-custom" id="search-result" action="search-result.html">
                <fieldset>
                    <legend>ĐẶT VÉ </legend>
                    <div class="controls controls-row" id="radio-ticket">
                        <label>Loại vé</label>
                        <div class="radio-ticket-type">
                            <label class="radio">
                                <input type="radio" name="ticketType" id="optionsRadios2" value="oneway" checked>
                                Vé một chiều
                            </label>
                            <label class="radio">
                                <input type="radio" name="ticketType" id="optionsRadios1" value="roundtrip">
                                Vé khứ hồi
                            </label>
                        </div>
                    </div>
                    <div class="controls controls-row">
                        <label>Trạm khởi hành</label>
                        <s:select list="city" listKey="id" listValue="name" name="departureCity"/>
                    </div>
                    <div class="controls controls-row">
                        <label>Trạm kết thúc</label>
                        <s:select list="city" listKey="id" listValue="name" name="arrivalCity"/>
                    </div>
                    <div class="controls controls-row" id="select-pas">
                        <label>Số lượng hành khách</label>
                        <div class="custom-select">
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
                        <input type="text" value="10-02-2013" id="dp1" name="departureDate" data-date-format="dd-mm-yyyy">
                    </div>
                    <div class="controls controls-row" id="input-return">
                        <label>Ngày về</label>
                        <input type="text" value="01-01-2013" id="dp2" name="returnDate" data-date-format="dd-mm-yyyy">
                    </div>
                    <div class="controls controls-row" id="select-bus-type">
                        <label>Loại xe bus</label>
                        <s:select list="busType" listKey="id" listValue="name" name="busType"/>
                    </div>
                    <input type="submit" class="pull-right btn btn-large" style="width: 100%;margin-top: 9px;" value="Đặt Vé"/>
                    <a id="btn-change" href="#" class="pull-right" style="color: #fff;padding-top: 15px;" onclick="showMore()">Đặt vé chi tiết</a>
                </fieldset>
            </form>
            <script type="text/javascript">
                $(function(){
                    $('#dp1').datepicker();
                    $('#dp2').datepicker();
                })
            </script>
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
<!-- Start footer -->
<jsp:include page="../common/footer.jsp" />
</body>
</html>