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
	    <div class="container">
	        <div class="nav-step-wrapper">
	            <div class="nav-step nav-done">
	                <span class="nav-step-num">1</span>
	                <div class="nav-step-header">Bước 1:</div>
	                <div class="nav-step-des">Chọn xe</div>
	            </div>
	            <div class="nav-step nav-done" style="margin-left: 100px;">
	                <span class="nav-step-num">2</span>
	                <div class="nav-step-header">Bước 2:</div>
	                <div class="nav-step-des">Chọn ghế</div>
	            </div>
	            <div class="nav-step nav-in-progress" style="margin-left: 100px;">
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
	<!-- Start information content -->
	<section>
		<div class="container">
			<form class="well" action="booking-pay.html" method="post">
				<fieldset>
					<legend>Hoàn thành thông tin đăng kí vé xe</legend>
						<div class="control-group">
						    <label class="control-label" for="inputFirstName">Tên</label>
						    <div class="controls">
						      <input type="text" id="inputFirstName" name="inputFirstName" placeholder="Tên">
					    	</div>
					  	</div>
					  	<div class="control-group">
						    <label class="control-label" for="inputLastName">Họ</label>
						    <div class="controls">
						      <input type="text" id="inputLastName" name="inputLastName" placeholder="Họ">
					    	</div>
					  	</div>
					  	<div class="control-group">
						    <label class="control-label" for="inputMobile">Điện Thoại Di Động</label>
						    <div class="controls">
						      <input type="text" id="inputMobile" name="inputMobile" placeholder="Điện Thoại Di Động">
					    	</div>
					  	</div>
					  	<div class="control-group">
						    <label class="control-label" for="inputEmail">Email</label>
						    <div class="controls">
						      <input type="text" id="inputEmail" name="inputEmail" placeholder="Email">
					    	</div>
					  	</div>
					  	<div class="control-group">
						    <label class="control-label">Số ghế chọn</label>
						    <div class="controls">
						     	<s:iterator value="listSeats">
						     		<s:div><s:property value="name" /></s:div>
						     	</s:iterator>						     	
					    	</div>
					  	</div>
					  	<button class="btn btn-large" >Hoàn Tất</button>
				</fieldset>
			</form>
		</div>
	</section>
	<!-- End information content -->
	<jsp:include page="../common/footer.jsp" /> 
	</body>
</html>
	