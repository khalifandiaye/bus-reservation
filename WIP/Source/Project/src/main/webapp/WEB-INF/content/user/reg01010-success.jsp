<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC 
	"-//W3C//DTD XHTML 1.1 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><s:text name="title.reg01010" /></title>
<jsp:include page="../common/xheader.jsp" />
<link href="<%=request.getContextPath()%>/styles/booking.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/styles/pay.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<div class="user-details">
		<form method="post" action="<%=request.getContextPath()%>/user/reg01020.html">
			<div class="container">
				<div class="well">
					<div class="section">
						<h3><s:text name="label.loginDetails" /></h3>
						<div class="item">
							<label><s:text name="label.username" />(*)</label><s:textfield name="model.username" />
							<s:fielderror>
								<s:param>model.username</s:param>
							</s:fielderror>
						</div>
						<div class="item">
							<label><s:text name="label.password" />(*)</label><s:password name="model.password" />
							<s:fielderror>
								<s:param>model.password</s:param>
							</s:fielderror>
						</div>
						<div class="item">
							<label><s:text name="label.confirmedPassword" />(*)</label><s:password name="model.confirmedPassword" />
							<s:fielderror>
								<s:param>model.confirmedPassword</s:param>
							</s:fielderror>
						</div>
						<div class="item">
							<label><s:text name="label.email" />(*)</label><s:textfield name="model.email" />
							<s:fielderror>
								<s:param>model.email</s:param>
							</s:fielderror>
						</div>
					</div>
					<div class="section">
						<h3><s:text name="label.userDetails" /></h3>
						<div class="item">
							<label><s:text name="label.firstName" /></label><s:textfield name="model.firstName" />
							<s:fielderror>
								<s:param>model.firstName</s:param>
							</s:fielderror>
						</div>
						<div class="item">
							<label><s:text name="label.lastName" /></label><s:textfield name="model.lastName" />
							<s:fielderror>
								<s:param>model.lastName</s:param>
							</s:fielderror>
						</div>
						<div class="item">
							<label><s:text name="label.phoneNumber" /></label><s:textfield name="model.phoneNumber" />
							<s:fielderror>
								<s:param>model.phoneNumber</s:param>
							</s:fielderror>
						</div>
						<div class="item">
							<label><s:text name="label.mobileNumber" /></label><s:textfield name="model.mobileNumber" />
							<s:fielderror>
								<s:param>model.mobileNumber</s:param>
							</s:fielderror>
						</div>
						<div class="item">
						<script type="text/javascript" src="https://www.google.com/recaptcha/api/challenge?k=6LdUXN4SAAAAAJ_2mUQs7XRzrIwyBvfg3SM0ng7c"></script>
						<noscript>
						   <iframe src="https://www.google.com/recaptcha/api/noscript?k=6LdUXN4SAAAAAJ_2mUQs7XRzrIwyBvfg3SM0ng7c"
						       height="300" width="500" frameborder="0"></iframe><br>
						   <textarea name="recaptcha_challenge_field" rows="3" cols="40">
						   </textarea>
						   <input type="hidden" name="recaptcha_response_field"
						       value="manual_challenge">
						</noscript>
						<s:fielderror>
							<s:param>captcha</s:param>
						</s:fielderror>
						</div>
						<s:submit cssClass="btn btn-small btn-primary" key="btn.register"/>
					</div>
				</div>
			</div>
		</form>
	</div>
	<jsp:include page="../common/footer.jsp" />
</body>
</html>
	