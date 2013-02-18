<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC 
	"-//W3C//DTD XHTML 1.1 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Đăng Ký</title>
<jsp:include page="../common/xheader.jsp" />
<script>
	var ctx = "<%=request.getContextPath()%>";
</script>
<script src="<%=request.getContextPath()%>/js/jquery.validate.min.js" ></script>
<script src="<%=request.getContextPath()%>/js/user-validation.js" ></script>
</head>
	<body>
	<jsp:include page="../common/header.jsp" />
	<!-- Start register -->
	<section>
		<div class="my-container">
			<div style="margin-left: 0px;width: 50%;float:left">
<!-- 					<input type="text" name="inputUserName" id="myUsername"> -->
<!-- 					<button onclick="submitUsername()">submitUsername</button> -->
				Description section 
			</div>
			<div style="margin-left: 0px;width: 50%;float:left;">  
				<form action="add-user.html" method="post" class="well well-small" id="register-form">
					<fieldset> 
					<legend style="margin-bottom: 10px;">Đăng ký tài khoản mới</legend> 
						<div class="control-group" > 
						    <label class="control-label" for="inputUserName">Tên tài khoản</label>
						    <div class="controls" style="width: 410px;"> 
						      <input type="text" id="inputUserName" name="inputUserName" placeholder="Tên tài khoản" style="width: 395px" onchange="onChangeUsername()" onkeypress="onKeyPressClear()">
					    	</div>
					  	</div>
					  	<div class="control-group" >
						    <label class="control-label" for="inputPassword">Mật khẩu</label>
						    <div class="controls" style="width: 410px;">
						      <input type="password" id="inputPassword" name="inputPassword" placeholder="Mật khẩu" style="width: 395px"> 
					    	</div> 
					  	</div>
					  	<div class="control-group" >
						    <label class="control-label" for="inputRePassword">Nhập lại mật khẩu</label>
						    <div class="controls" style="width: 410px;">
						      <input type="password" id="inputRePassword" name="inputRePassword" placeholder="Nhập lại mật khẩu" style="width: 395px"> 
					    	</div> 
					  	</div>
						<div class="control-group">
						    <label class="control-label" for="inputLastName">Họ</label>
						    <div class="controls" style="width: 410px;overflow: hidden;"> 
						      <input type="text" id="inputLastName" name="inputLastName" placeholder="Họ" style="width:395px">
					      	</div>
					  	</div>
					  	<div class="control-group">
						    <label class="control-label" for="inputFirstName">Tên</label>
						    <div class="controls" style="width: 410px;overflow: hidden;">
						      <input type="text" id="inputFirstName" name="inputFirstName" placeholder="Tên" style="width:395px">
					      	</div>
					  	</div>
					  	<div class="control-group" >
						    <label class="control-label" for="inputMobile">Điện Thoại Di Động</label>
						    <div class="controls" style="width: 410px;">
						      <input type="text" id="inputMobile" name="inputMobile" placeholder="Điện Thoại Di Động" style="width: 395px"> 
					    	</div> 
					  	</div>
					  	<div class="control-group">
						    <label class="control-label" for="inputEmail">Email</label>
						    <div class="controls" style="width: 410px;">
						      <input type="text" id="inputEmail" name="inputEmail" placeholder="Email" style="width: 395px" onchange="onChangeEmail()">
					    	</div>
					  	</div> 
					  	<button type="submit" class="btn btn-large btn-primary" style="width: 100%;margin-top:10px;">Đăng Ký</button> 
				  	</fieldset> 
				</form>
			</div>
		</div>
	</section>
	<!-- End information content -->
	<jsp:include page="../common/footer.jsp" /> 
	</body>
</html>
	