<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="circle-back"> 
<div class="top-nav">
	<div class="top-menu">
		<a class="btn btn-mini pull-right" style="margin-top:5px;">Đăng Nhập</a>  
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
                    <li><a href="#">VÉ CỦA TÔI</a></li>
                </ul> 
            </div>
        </div> 
</header>
<!-- End header -->