<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC 
	"-//W3C//DTD XHTML 1.1 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>HRM - Employee List</title>
<script src="<%=request.getContextPath()%>/js/employee.js" ></script>
<script src="<%=request.getContextPath()%>/js/dateUtil.js" ></script>
<link href="http://fonts.googleapis.com/css?family=Oswald" rel="stylesheet" type="text/css" />
<link href="styles/network.css" rel="stylesheet" type="text/css" media="screen" />
</head>
<body>
	<jsp:include page="common/header.jsp" />
	<jsp:include page="common/menu.jsp" />
	<div id="page">
		<div class="post">
			<h3 onclick="return startup();">Search employee</h3>
			<table>
				<tr>
					<th>Name</th>
					<td><input type="text" name="name" /></td>
				</tr>
				<tr>
					<th>Birthdate</th>
					<td>
					<select name="year" id="searchYearSelect"></select>-
					<select name="month" id="searchMonthSelect"></select>-
					<select name="day" id="searchDaySelect"></select>
					</td>
				</tr>
			</table>
			<p><input type="submit" action="searchEmployee" value="Search" /></p>
		</div>
		<div class="post">
			<h3>Add employee</h3>
			<table>
				<tr>
					<th>Name</th>
					<td><input type="text" name="name" /></td>
				</tr>
				<tr>
					<th>Birthdate</th>
					<td>
					<select name="year" id="addYearSelect"></select>-
					<select name="month" id="addMonthSelect"></select>-
					<select name="day" id="addDaySelect"></select>
					</td>
				</tr>
			</table>
			<p><input type="submit" action="searchEmployee" value="Add" /></p>
		</div>
		<div class="post">
			<h2>Employee list</h2>
			<table border="1" cellpadding="4">
				<tr>
					<th>Name</th>
					<th>Birthday</th>
				</tr>
			</table>
		</div>
	</div>
	<jsp:include page="common/footer.jsp" />
</body>
</html>
	