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
<script src="<%=request.getContextPath()%>/js/index.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery.dataTables.min.js"></script>
<script src="<%=request.getContextPath()%>/js/accounting.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
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
			};
		
		var segmentTable = $('#segmentTable').dataTable({
			"bSort" : false
		});
		
		var priceTable = $('#priceTable').dataTable({
	      "bSort" : false
		});
		
		$('#viewPrice').click(function() {
			$("#priceDialog").modal();
		});

		$('#return').bind('click', function() {
			var url = $('#contextPath').val() + "/route/list.html";
			window.location = url;
		});
		
		$('tr[data-segment-id]').each(function(){ 
			var id = this.dataset.segmentId;
			var segment = {};
			segment['id'] = id;
			segments.push(segment);
		});
		
		$('#busType').bind('change', function(){
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
				for (var i = 0; i < data.length; i++) {
					element = data[i];
					$('#priceTable').dataTable().fnAddData([ element.startAt + ' - ' + element.endAt , accounting.formatMoney(element.fare) ]);
				};
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
</style>
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<jsp:include page="../common/menu.jsp" />
	<div id="page">
		<div class="post" style="margin: 0px auto; width: 95%;">
			<div style="margin-left: 10px; margin-top: 10px;">
				<s:select id="busType" list="busTypeBeans" name="busTypeBeans"
					listKey="id" listValue="name" />
				<input class="btn btn-primary" type="button" id="viewPrice"
               value="View Price" />
			</div>
			<form action="insertNewTrip" method="post">
				<div style="height: 45px; margin-left: 1%;"></div>
				<h3>
					<s:property value="segmentBeans[0].routeDetails.route.name" />
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
							<tr id="segment_<s:property value='id'/>" data-segment-id="<s:property value='id'/>">
								<td><s:property value="name" /></td>
								<td><s:property value="duration" /></td>
							</tr>
						</s:iterator>
					</tbody>
				</table>
				</br> <input class="btn btn-primary" type="button" id="return"
					value="Return to Route List" />
			</form>
		</div>
	</div>
	
   <!-- Modal Show Route Details Price By BusType Dialog -->
   <div id="priceDialog" class="modal hide fade" tabindex="-1"
      role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
      <div class="modal-header">
         <button type="button" class="close" data-dismiss="modal"
            aria-hidden="true">×</button>
         <h3 id="priceDialogLabel"></h3>
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
         <button class="btn btn-primary" data-dismiss="modal" aria-hidden="true">Update</button>
      </div>
   </div>
	<jsp:include page="../common/footer.jsp" />
</body>
</html>
