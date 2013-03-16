<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<link href="<%=request.getContextPath()%>/styles/header.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/common/header.js" ></script>
<div class="circle-back"> 
<div class="top-nav">
	<div class="top-menu clear-fix" style="color: #ffffff;height: 52px;">  
		<div class="login pull-right">
			<span style="float:left">   
				<span id="errorMessage" style="padding-right: 20px;color: red;"></span>
				Tài khoản <s:textfield name="username" cssStyle="margin-top: 5px;height: 17px;width: 100px;"/> 
				Mật khẩu <s:password name="password" cssStyle="height: 17px;width: 100px;margin-top: 5px;"/>
			</span> 
			<a id="btn_login" class="btn btn-mini btn-primary" style="margin-top: 5px;margin-left: 8px;padding: 3px 8px;">Đăng Nhập</a> 
			<a id="btn_register" href="<%=request.getContextPath()%>/user/reg01010.html" class="btn btn-mini btn-success" style="margin-top: 5px;margin-left: 8px;padding: 3px 8px;"><s:text name="btn.register" /></a>
		</div> 
		<div class="logout pull-right hidden"> 
		<span style="margin-top: 9px;float: left;">Hello <span id="name"></span></span> 
		<a id="btn_logout" class="btn btn-mini btn-danger" style="margin-top: 5px;margin-left: 8px;padding: 3px 8px;">Đăng Xuất</a>
		</div>
	</div>
</div>
<div class="container">
<!-- Start header -->
<input type="hidden" id="contextPath" value="<%=request.getContextPath()%>">
<header class="header">
		<div class="brand-wrapper">
             <a class="brand" href="index.html">TRAVEL<span style="color:#555555">BUS</span></a>
       	</div>
       	<div class="bus-logo-left pull-right"><img src="<%=request.getContextPath()%>/img/bus-logo-left.png"></div>  
        <div class="navbar">
            <div class="navbar-inner">
                <ul class="nav pull-left">  
                    <li class="active"><a href="<%=request.getContextPath()%>/">TRANG CHỦ</a></li>
                    <li><a href="#">CHÍNH SÁCH GIÁ</a></li>
                    <li><a href="#">VỀ CHÚNG TÔI</a></li>
                    <li id="tab_reservationList"><a href="<%=request.getContextPath()%>/rsv/rsv01010.html">VÉ CỦA TÔI</a></li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">QUẢN LÝ <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                          <li><a href="<%=request.getContextPath()%>/bus/list.html">XE BUS</a></li>
                          <li><a href="<%=request.getContextPath()%>/route/list.html">TUYẾN ĐƯỜNG</a></li>
                          <li><a href="<%=request.getContextPath()%>/schedule/list.html">LỊCH XE CHẠY</a></li>
                        </ul>
                      </li>
                </ul> 
            </div>
        </div> 
</header>
<!-- End header -->