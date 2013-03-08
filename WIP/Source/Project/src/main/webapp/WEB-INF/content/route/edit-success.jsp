<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Test page</title>
<jsp:include page="../common/xheader.jsp" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/styles/trip/jquery.dataTables.css">
<link
	href="<%=request.getContextPath()%>/styles/trip/datetimepicker.css"
	rel="stylesheet">
<link
	href="<%=request.getContextPath()%>/styles/route/jquery-ui-1.10.1.custom.min.css"
	rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/index.js"></script>
<script
	src="<%=request.getContextPath()%>/js/route/jquery-ui-1.10.1.custom.min.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery.dataTables.min.js"></script>
<script src="<%=request.getContextPath()%>/js/accounting.min.js"></script>
<script
	src="<%=request.getContextPath()%>/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript">
	$(document)
			.ready(
					function() {
						accounting.settings = {
							currency : {
								symbol : " VNĐ", // default currency symbol is '$'
								format : "%v%s", // controls output: %s = symbol, %v = value/number (can be object: see below)
								decimal : ",", // decimal point separator
								thousand : ".", // thousands separator
								precision : 0
							// decimal places
							},
							number : {
								precision : 0, // default precision on numbers is 0
								thousand : ",",
								decimal : "."
							}
						};

						oTable = $('#segmentTable').dataTable({
							"bSort" : false
						});

						$("#validDateDiv").datetimepicker({
							format : "yyyy/mm/dd - hh:ii",
							autoclose : true,
							todayBtn : true,
							startDate : new Date(),
							minuteStep : 10
						});
						
						$("#returnRoute").click(function(){
							var url = $('#contextPath').val() + "/route/route-detail-list.html?routeId=" + $("#routeId").val();
					      window.location = url;
						});

						$("#save").bind('click', function() {
											var info = {};
											var tariffs = [];

											$.each($("#segmentTable input"),
															function() {
																var tariff = {};
																tariff['segmentId'] = this.id;
																tariff['fare'] = this.value;
																tariffs
																		.push(tariff);
															});
											info['routeId'] = $('#routeId').val();
											info['validDate'] = $('#validDate')
													.val();
											info['tariffs'] = tariffs;
											info['busTypeId'] = $('#busType')
													.val();

											$
													.ajax({
														type : "POST",
														url : 'updateTariff.html',
														contentType : "application/x-www-form-urlencoded; charset=utf-8",
														data : {
															data : JSON
																	.stringify(info)
														},
														success : function(
																response) {
															alert(response);
															var url = $('#contextPath').val() + "/route/route-detail-list.html?routeId=" + $('#routeId').val();
													      window.location = url;
														},
														error : function() {
															alert("Save new route failed!");
														}
													});
										});
					});
</script>
<style type="text/css">
.dataTables_filter {
	display: none;
}

.dataTables_length {
	display: none;
}

.dataTables_paginate {
	display: none;
}

.dataTables_info {
	display: none;
}
</style>
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<jsp:include page="../common/menu.jsp" />
	<div id="page">
	<input type="hidden" value='<s:property value="routeId"/>' id='routeId'/>
		<div class="post" style="margin: 0px auto; width: 95%;">
			<table>
				<tr>
					<td style="width: 65%">Valid date :
						<div id="validDateDiv" class="input-append date form_datetime" data-date="">
							<input id="validDate" size="16" type="text" value="" readonly
								name="validDate"> <span class="add-on" required><i
								class="icon-remove"></i></span> <span class="add-on"><i
								class="icon-calendar"></i></span>
						</div>
					</td>
					<td>Select bus type :
					<div class="input-append date form_datetime">
                     <s:select id="busType" headerKey="-1"
                     headerValue="--- Select Bus Type ---" list="busTypeBeans"
                     name="busTypeBeans" listKey="id" listValue="name" />
                  </div></td>
				</tr>
			</table>
			<table id="segmentTable">
				<thead>
					<tr>
						<td>Start At</td>
						<td>End At</td>
						<td>Price</td>
					</tr>
				<thead>
				<tbody>
					<s:iterator value="segmentBeans">
						<tr>
							<td><s:property value="startAt.name" /></td>
							<td><s:property value="endAt.name" /></td>
							<td><input id="<s:property value='id'/>" type="text"
								value="" /></td>
						</tr>
					</s:iterator>
				</tbody>
			</table>
			<div style="margin-left: 10px; margin-top: 10px; margin-bottom: 10px;">
				<input class="btn btn-primary" type="submit" id="save" value="Save" />
				<input class="btn btn-danger" type="button" id="returnRoute" value="Cancel" />
			</div>
		</div>
	</div>
	<jsp:include page="../common/footer.jsp" />
</body>

</html>