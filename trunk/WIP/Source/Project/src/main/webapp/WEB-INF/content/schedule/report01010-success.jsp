<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC 
	"-//W3C//DTD XHTML 1.1 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="s" uri="/struts-tags"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><s:text name="title.rsv01010" /></title>
<jsp:include page="../common/xheader.jsp" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/styles/custom-data-table.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/styles/pay.css">
<script src="<%=request.getContextPath()%>/js/jquery.dataTables.min.js"></script>
<script src="<%=request.getContextPath()%>/js/common/custom-data-table.js"></script>
<script src="<%=request.getContextPath()%>/js/rsv/rsv01010.js"></script>
</head>
<body>
	<div class="not-printable">
	<jsp:include page="../common/header.jsp" />
	<jsp:include page="../common/dataTableText.jsp" />
		<div class="container">
			<div class="well">
				<jsp:include page="report01010-content.jsp" />
			</div>
		</div>
	</form>
	<jsp:include page="../common/footer.jsp" />
	</div>
	<div class="printable">
		<jsp:include page="report01010-content.jsp" />
	</div>
</body>
</html>
