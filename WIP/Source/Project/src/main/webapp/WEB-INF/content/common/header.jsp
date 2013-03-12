<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<link href="<%=request.getContextPath()%>/styles/header.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/common/header.js" ></script>
<div class="circle-back"> 
<div class="top-nav">
	<div class="top-menu" style="color: #ffffff">
		<div class="login pull-right">
		<span id="errorMessage"></span>Username <s:textfield name="username" /> Password <s:password name="password" /> <a id="btn_login" class="btn btn-mini" style="margin-top:5px;">Đăng Nhập</a>
		</div>
		<div class="logout pull-right hidden">
		Hello <span id="name"></span><a id="btn_logout" class="btn btn-mini" style="margin-top:5px;">Đăng Xuất</a>
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