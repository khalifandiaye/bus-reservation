<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC 
	"-//W3C//DTD XHTML 1.1 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Test Paypal</title>
<jsp:include page="common/xheader.jsp" />
</head>
<body>
	<jsp:include page="common/header.jsp" />
	<jsp:include page="common/menu.jsp" />
	<div id="page">
		<div class="post">
			<h2 class="title">Test paypal</h2>
			<p>
				<input type="text" name="amount" /><br />
				<input style="background: url(https://www.paypalobjects.com/en_US/i/btn/btn_xpressCheckout.gif) no-repeat; width: 145px; height: 42px; border: none; cursor:pointer;" type="submit" id="testPaypalPay" value="" />
			</p>
		</div>
	</div>
	<jsp:include page="common/footer.jsp" />
</body>
</html>
	