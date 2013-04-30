<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<link href="<%=request.getContextPath()%>/styles/header.css"
	rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/common/header.js"></script>
<div class="circle-back">
	<div class="top-nav">
		<div class="top-menu clear-fix">
			<div class="login pull-right">
				<div class="item">
					<span id="loginErrorMessage" class="error"></span>
				</div>
				<div class="item">
					<s:text name="label.username" />
					<s:textfield name="username" />
				</div>
				<div class="item">
					<s:text name="label.password" />
					<s:password name="password" />
				</div>
				<div class="item">
					<a id="btn_login" class="btn btn-mini btn-primary">Đăng Nhập</a> <a
						id="btn_register"
						href="<%=request.getContextPath()%>/user/reg01010.html"
						class="btn btn-mini btn-success">Đăng Kí</a>
				</div>
			</div>
			<div class="logout pull-right hidden">
				<div class="item">
					<span id="logoutErrorMessage" class="error"></span>
				</div>
				<div class="item">
					<span><s:text name="message.hello" /></span>
				</div>
				<div class="item">
					<a id="btn_logout" class="btn btn-mini btn-danger">Đăng Xuất</a>
				</div>
			</div>
		</div>
	</div>
	<div class="container" style="min-height: 500px">
		<!-- Start header -->
		<input type="hidden" id="contextPath"
			value="<%=request.getContextPath()%>">
		<header class="header">
			<div class="brand-wrapper">
				<a class="brand" href="<%=request.getContextPath()%>/">VINA<span
					style="color: #555555">BUS</span></a>
			</div>
			<div class="bus-logo-left pull-right">
				<img src="<%=request.getContextPath()%>/img/bus-logo-left.png"
					style="width: 200px; margin-bottom: -90px; margin-top: -15px;">
			</div>
			<div class="navbar">
				<div class="navbar-inner">
					<ul class="nav pull-left">
						<li class="customer operator home"><a href="<%=request.getContextPath()%>/">TRANG
								CHỦ</a></li>
						<li class="customer operator history" id="tab_reservationList"><a
							href="<%=request.getContextPath()%>/rsv/rsv01010.html">VÉ CỦA
								TÔI</a></li>   
						<li class="dropdown operator admin hidden"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown">MANAGE <b class="caret"></b></a>
							<ul class="dropdown-menu">
								<li class="operator hidden"><a href="<%=request.getContextPath()%>/bus/list.html">MANAGE
										BUS</a></li>
								<li class="operator hidden"><a href="<%=request.getContextPath()%>/route/list.html">MANAGE
										ROUTE</a></li>
								<li class="operator hidden"><a
									href="<%=request.getContextPath()%>/schedule/list.html">MANAGE
										SCHEDULE</a></li>
								<li class="operator hidden"><a
									href="<%=request.getContextPath()%>/segment/list.html">MANAGE SEGMENT</a></li>
								<li class="admin hidden"><a
									href="<%=request.getContextPath()%>/admin/user-management.html">MANAGE
										USER</a></li>
								<li class="admin hidden"><a
									href="<%=request.getContextPath()%>/admin/settings.html">CONFIGURATION</a></li>
							</ul></li>
					</ul>
				</div>
			</div>
		</header>
		<!-- End header -->