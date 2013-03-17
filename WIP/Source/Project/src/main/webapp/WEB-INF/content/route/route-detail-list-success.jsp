<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC 
   "-//W3C//DTD XHTML 1.1 Transitional//EN"
   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

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
<script src="<%=request.getContextPath()%>/js/index.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery.dataTables.min.js"></script>
<script src="<%=request.getContextPath()%>/js/accounting.min.js"></script>
<script
	src="<%=request.getContextPath()%>/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript">
	function validate(evt) {
		var theEvent = evt || window.event;
		var key = theEvent.keyCode || theEvent.which;
		if (theEvent.keyCode != 0) {
			return;
		}
		key = String.fromCharCode(key);
		var regex = /[0-9]/;
		if (!regex.test(key)) {
			theEvent.returnValue = false;
			if (theEvent.preventDefault)
				theEvent.preventDefault();
		}
	}
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

						var segmentTable = $('#segmentTable').dataTable({
							"bSort" : false
						});

						var priceTable = $('#priceTable').dataTable({
							"bSort" : false
						});

						var busDetailTable = $('#busDetailTable').dataTable({
							"bSort" : false
						});

						var editSegmentTable = $('#editSegmentTable')
								.dataTable({
									"bSort" : false
								});

						$.each($("#editSegmentTable input"), function() {
							$("#" + this.id + "").keypress(function(event) {
								validate(event);
							});
						});

						$("#validDateDiv").datetimepicker({
							format : "yyyy/mm/dd - hh:ii",
							autoclose : true,
							todayBtn : true,
							startDate : new Date(),
							minuteStep : 10
						});

						$("#editPriceSave")
								.bind(
										'click',
										function() {
											var info = {};
											var tariffs = [];

											$
													.each(
															$("#editSegmentTable input"),
															function() {
																var tariff = {};
																tariff['segmentId'] = this.id;
																tariff['fare'] = this.value;
																tariffs
																		.push(tariff);
															});
											info['routeId'] = $('#routeId')
													.val();
											info['validDate'] = $('#validDate')
													.val();
											info['tariffs'] = tariffs;
											info['busTypeId'] = $('#busTypes')
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
															var url = $(
																	'#contextPath')
																	.val()
																	+ "/route/route-detail-list.html?routeId="
																	+ $(
																			'#routeId')
																			.val();
															window.location = url;
														},
														error : function() {
															alert("Save new route failed!");
														}
													});
										});

						$("#addBusPrice").click(function() {
							$("#editPriceDialog").modal();
						});

						$("#assignBus")
								.click(
										function() {
											var routeId = $("#routeId").val();
											var busType = $("#busType").val();
											$
													.ajax({
														type : "GET",
														url : 'getBusInRoute.html?routeId='
																+ routeId
																+ '&type='
																+ busType,
														contentType : "application/x-www-form-urlencoded; charset=utf-8",
														success : function(
																response) {
															var busInRoute = response.busInRouteBeans;
															var busNotInRoute = response.busNotInRouteBeans;

															$('#busDetailTable')
																	.dataTable()
																	.fnClearTable();
															$
																	.each(
																			busInRoute,
																			function() {
																				busDetailTable
																						.dataTable()
																						.fnAddData(
																								[
																										this.id,
																										this.plateNumber,
																										'<button type="button" data-id="'+ this.id +'" class="btn btn-danger">Delete</button>' ]);
																				$(
																						"#busDetailTable tr button[data-id="
																								+ this.id
																								+ "]")
																						.click(
																								function() {
																									var td = this.parentNode;
																									var tr = td.parentNode;
																									var aPos = busDetailTable
																											.dataTable()
																											.fnGetPosition(
																													td);
																									var data = busDetailTable
																											.fnGetData(tr);
																									$(
																											'#busDetailbusPlate')
																											.append(
																													'<option value="'+ data[0] +'">'
																															+ data[1]
																															+ '</option>');
																									busDetailTable
																											.dataTable()
																											.fnDeleteRow(
																													aPos[0]);
																								});
																			});

															$(
																	'#busDetailbusPlate')
																	.empty();
															$
																	.each(
																			busNotInRoute,
																			function() {
																				$(
																						'#busDetailbusPlate')
																						.append(
																								'<option value="'+ this.id +'">'
																										+ this.plateNumber
																										+ '</option>');
																			});
															$(
																	"#busDetailDialog")
																	.modal();
														}
													});
										});

						$("#busDetailAdd")
								.click(
										function() {
											var busId = $("#busDetailbusPlate")
													.val();
											var plateNumber = $(
													"#busDetailbusPlate option:selected")
													.text();
											busDetailTable
													.dataTable()
													.fnAddData(
															[
																	busId,
																	plateNumber,
																	'<button type="button" data-id="'+ busId +'" class="btn btn-danger">Delete</button>' ]);
											$(
													"#busDetailbusPlate option[value="
															+ busId + "]")
													.remove();
											$(
													"#busDetailTable tr button[data-id="
															+ busId + "]")
													.click(
															function() {
																var td = this.parentNode;
																var tr = td.parentNode;
																var aPos = busDetailTable
																		.dataTable()
																		.fnGetPosition(
																				td);
																var data = busDetailTable
																		.fnGetData(tr);
																$(
																		'#busDetailbusPlate')
																		.append(
																				'<option value="'+ data[0] +'">'
																						+ data[1]
																						+ '</option>');
																busDetailTable
																		.dataTable()
																		.fnDeleteRow(
																				aPos[0]);
															});
										});

						$("#busDetailSave")
								.click(
										function() {
											var routeId = $("#routeId").val();
											var busInfos = [];
											var unSelectBusInfos = [];
											$
													.each(
															$("#busDetailTable tr.odd,#busDetailTable .even"),
															function() {
																var bus = {};
																if ($(
																		this.cells[0])
																		.html() != 'No data available in table') {
																	bus['id'] = $(
																			this.cells[0])
																			.html();
																	bus['plateNumber'] = $(
																			this.cells[1])
																			.html();
																	busInfos
																			.push(bus);
																}
															});

											$
													.each(
															$("#busDetailbusPlate option"),
															function() {
																var unSelectBus = {};
																unSelectBus['id'] = this.value;
																unSelectBus['plateNumber'] = "0";
																unSelectBusInfos
																		.push(unSelectBus);
															});

											var busDetailInfo = {};
											busDetailInfo['routeId'] = routeId;
											busDetailInfo['bus'] = busInfos;
											busDetailInfo['unSelectBus'] = unSelectBusInfos;

											$
													.ajax({
														type : "POST",
														url : 'saveBusDetail.html',
														contentType : "application/x-www-form-urlencoded; charset=utf-8",
														data : {
															data : JSON
																	.stringify(busDetailInfo)
														},
														success : function(
																response) {
															alert(response);
														}
													});
										});

						$('#viewPrice').click(function() {
							$("#priceDialog").modal();
						});

						$('#return').bind(
								'click',
								function() {
									var url = $('#contextPath').val()
											+ "/route/list.html";
									window.location = url;
								});

						$('tr[data-segment-id]').each(function() {
							var id = this.dataset.segmentId;
							var segment = {};
							segment['id'] = id;
							segments.push(segment);
						});

						$('#busType').bind('change', function() {
							$('#priceTable').dataTable().fnClearTable();
							var busType = $('#busType').val();
							getPrice(busType, segments);
						});

						var busType = $('#busType').val();
						getPrice(busType, segments);
					});

	function getPrice(busType, segments) {
		var info = {};
		info['busType'] = busType;
		info['segments'] = segments;
		$.ajax({
			type : "POST",
			url : 'getPrice.html',
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			data : {
				data : JSON.stringify(info)
			},
			success : function(response) {
				var data = response.tariffInfos;
				for ( var i = 0; i < data.length; i++) {
					element = data[i];
					$('#priceTable').dataTable().fnAddData(
							[ element.startAt + ' - ' + element.endAt,
									accounting.formatMoney(element.fare) ]);
				}
				;
			}
		});
	};

	var segments = [];
</script>
<style type="text/css">
.dataTables_filter {
	display: none;
}

.dataTables_length {
	display: none;
}

.dataTables_info {
	display: none;
}

.dataTables_paginate {
	display: none;
}

#editPriceDialog {
	width: 900px;
	margin-left: -440px;
}
</style>
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<jsp:include page="../common/menu.jsp" />
	<div id="page">
		<div class="post" style="margin: 0px auto; width: 95%;">
			<div style="margin-left: 10px; margin-top: 10px;">
				<input type="hidden" id="routeId"
					value="<s:property value='routeId'/>" />
				<s:if test="%{busTypeBeans.size()!=0}">
					<table>
						<tr>
							<td><s:select id="busType" list="busTypeBeans"
									name="busTypeBeans" listKey="id" listValue="name" /></td>
							<td><input class="btn btn-primary" type="button"
								id="addBusPrice" value="Add Bus Price"
								style="height: 30px; margin-top: -13px;" /></td>
						</tr>
						<tr>
							<td><input class="btn btn-primary" type="button"
								id="viewPrice" value="View Price" /> <input
								class="btn btn-primary" id="assignBus" type="button"
								value="Assign Bus to Route" /></td>
						</tr>
					</table>
				</s:if>
			</div>
			<h3>
				<s:property value="routeName" />
			</h3>
			<table id="segmentTable">
				<thead>
					<tr>
						<th>Name</th>
						<th>Travel Time</th>
					</tr>
				</thead>
				<tbody>
					<s:iterator value="segmentInfos">
						<tr id="segment_<s:property value='id'/>"
							data-segment-id="<s:property value='id'/>">
							<td><s:property value="name" /></td>
							<td><s:property value="duration" /></td>
						</tr>
					</s:iterator>
				</tbody>
			</table>
			</br>
			<div style="margin-bottom: 10px;">
				<input class="btn btn-primary" type="button" id="return"
					value="Return to Route List" />
			</div>
		</div>
	</div>

	<!-- Modal Show Route Details Price By BusType Dialog -->
	<div id="priceDialog" class="modal hide fade" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal"
				aria-hidden="true">×</button>
			<h3 id="priceDialogLabel">Price</h3>
		</div>
		<div class="modal-body">
			<table id="priceTable">
				<thead>
					<tr>
						<th>Name</th>
						<th>Fare</th>
					</tr>
				</thead>
				<tbody>
				</tbody>
			</table>
		</div>
		<div class="modal-footer">
			<button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
			<button class="btn btn-primary" data-dismiss="modal"
				aria-hidden="true">Update</button>
		</div>
	</div>

	<!-- Modal Show Route Details Price By BusType Dialog -->
	<div id="busDetailDialog" class="modal hide fade" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal"
				aria-hidden="true">×</button>
			<h3 id="busDetailDialogLabel">List Bus In Route</h3>
		</div>
		<div class="modal-body">
			Select bus : <select id='busDetailbusPlate' name='busDetailBusPlate'></select>
			<button style="margin-top: -10px;" type="button" id="busDetailAdd"
				class="btn btn-primary">Add</button>
			<table id="busDetailTable">
				<thead>
					<tr>
						<th>id</th>
						<th>Plate Number</th>
						<th></th>
					</tr>
				</thead>
				<tbody>
				</tbody>
			</table>
		</div>
		<div class="modal-footer">
			<button type="button" class="btn" data-dismiss="modal"
				aria-hidden="true">Close</button>
			<button id="busDetailSave" class="btn btn-primary"
				data-dismiss="modal" aria-hidden="true">Save</button>
		</div>
	</div>

	<!-- Modal Show Edit Price -->
	<div id="editPriceDialog" class="modal hide fade" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal"
				aria-hidden="true">×</button>
			<h3 id="editPriceDialogLabel">List Bus In Route</h3>
		</div>
		<div class="modal-body">
			<div class="post" style="margin: 0px auto; width: 95%;">
				<table>
					<tr>
						<td style="width: 65%">Valid date :
							<div id="validDateDiv" class="input-append date form_datetime"
								data-date="">
								<input id="validDate" size="16" type="text" value="" readonly name="validDate">
							</div>
						</td>
						<td>Select bus type :
							<div class="input-append date form_datetime">
								<s:select id="busTypes" headerKey="-1"
									headerValue="--- Select Bus Type ---" list="busTypes"
									name="busTypes" listKey="id" listValue="name" />
							</div>
						</td>
					</tr>
				</table>
				<table id="editSegmentTable">
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
									value="" maxlength="7" /> .000 VNĐ</td>
							</tr>
						</s:iterator>
					</tbody>
				</table>
			</div>
		</div>
		<div class="modal-footer">
			<button type="button" class="btn" data-dismiss="modal"
				aria-hidden="true">Close</button>
			<button id="editPriceSave" class="btn btn-primary"
				data-dismiss="modal" aria-hidden="true">Save</button>
		</div>
	</div>
	<jsp:include page="../common/footer.jsp" />
</body>
</html>
