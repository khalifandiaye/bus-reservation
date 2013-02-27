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
   function getStation(el, des){
	   cityId = $('#' + el).val();
       if (cityId != -1) {
       $.ajax({
                 url: "getStation.html?cityId=" + cityId,
                }).done(function(data) {
                   $('#' + des).empty();
                   $.each(data.stationInfos, function() {
                      $('#' + des).append('<option value="'+this.id+'">'+this.name+'</option>');
                   });
                });
       }
   };
   
	$(document)
			.ready(
					function() {
						accounting.settings = {
								   currency: {
								      symbol : " VNĐ",   // default currency symbol is '$'
								      format: "%v%s", // controls output: %s = symbol, %v = value/number (can be object: see below)
								      decimal : ",",  // decimal point separator
								      thousand: ".",  // thousands separator
								      precision : 0   // decimal places
								   },
								   number: {
								      precision : 0,  // default precision on numbers is 0
								      thousand: ",",
								      decimal : "."
								   }
								}
						
						oTable = $('#segmentTable').dataTable({
							"bSort" : false
						});
						
						$('#startAt').change(function() {
							getStation('startAt', 'stationStartAt');
				      });
						
						$('#endAt').change(function() {
							getStation('endAt', 'stationEndAt');
		            });
						
						$("#add").bind(
								'click',
								function() {
									if (giCount == 6) {
										alert("maximun record added!");
										return;
									}

									var startAtKey = $("#startAt").val();
									var stationStartAtKey = $("#stationStartAt").val();
									var endAtKey = $("#endAt").val();
									var stationEndAtKey = $("#stationEndAt").val();
									var startAt = $("#startAt option:selected").text();
									var stationStartAt = $("#stationStartAt option:selected").text();
									var endAt = $("#endAt option:selected").text();
									var stationEndAt = $("#stationEndAt option:selected").text();
									var duration = $("#duration").val();
									var price = $("#price").val();
									
									if (stationStartAt.trim() == '') {
										return;
									}
									
									if (stationEndAt.trim() == '') {
			                              return;
			                           }
									
									if (duration.trim() == '') {
			                              return;
			                           }
									
									if (price.trim() == '') {
			                              return;
			                           }
									
									$('#segmentTable').dataTable()
											.fnAddData(
													[ startAt + ' - ' + stationStartAt, endAt + ' - ' + stationEndAt, duration,
													  accounting.formatMoney(price) ]);
									giCount++;

									$("#startAt").val(endAtKey);
									$("#startAt").disableSelection();
									getStation('startAt', 'stationStartAt');
									
									$("#endAt option[value=" + endAtKey + "]")
											.hide();
									$("#endAt").val(-1);

									var segment = {};
									segment['startAt'] = startAtKey;
									segment['stationStartAt'] = stationStartAtKey;
									segment['endAt'] = endAtKey;
									segment['stationEndAt'] = stationEndAtKey;
									segment['duration'] = duration;
									segment['price'] = price;
									segments.push(segment);
								});

						$("#save").bind(
										'click',
										function() {
											var busType = $("#busType").val();
											info['busType'] = busType;
											info['segments'] = segments;
											$.ajax({
														type : "POST",
														url : 'saveSegment.html',
														contentType : "application/x-www-form-urlencoded; charset=utf-8",
														data : {
															data : JSON.stringify(info)
														},
														success : function(
																response) {
														}
													});
										});
					});

	var info = {};
	var segments = [];
	var giCount = 0;
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
		<div class="post">
			<div style="margin-left: 10px; margin-top: 10px;">
				<s:select id="busType" headerKey="-1"
					headerValue="--- Select Bus Type ---" list="busTypeBeans"
					name="busTypeBeans" listKey="id" listValue="name" />
			</div>
			<table id="segmentTable">
				<thead>
					<tr>
						<td>Start At</td>
						<td>End At</td>
						<td>Duration</td>
						<td>Price</td>
					</tr>
				<thead>
				<tbody>
				</tbody>
				<tr>
					<td><s:select id="startAt" headerKey="-1"
							headerValue="--- Select Route ---" list="cityBeans"
							name="routeBeans" listKey="id" listValue="name"></s:select><select
						id="stationStartAt" headerKey="-1"
						headerValue="--- Select Start Station ---"></select></td>
					<td><s:select id="endAt" headerKey="-1"
							headerValue="--- Select Route ---" list="cityBeans"
							name="routeBeans" listKey="id" listValue="name">
							</s:select><select
                  id="stationEndAt" headerKey="-1"
                  headerValue="--- Select End Station ---"></select></td>
					<td><input type="text" id="duration" /></td>
					<td><input type="text" id="price" /></td>
					<td><input class="btn btn-primary" type="button" id="add"
						value="Add" /></td>
				</tr>
			</table>
			<div style="margin-left: 10px; margin-top: 10px;">
				<input class="btn btn-primary" type="button" id="save" value="Save" />
			</div>
		</div>
	</div>
	<jsp:include page="../common/footer.jsp" />
</body>

</html>