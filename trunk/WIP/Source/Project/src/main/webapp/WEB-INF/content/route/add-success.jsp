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
<script src="<%=request.getContextPath()%>/js/jquery.maskedinput.min.js"></script>
<script
	src="<%=request.getContextPath()%>/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript">
	function getStation(el, des) {
		cityId = $('#' + el).val();
       	if (cityId != -1) {
       	$.ajax({url: "getStation.html?cityId=" + cityId }).done(
    		function(data) {
            	$('#' + des).empty();
                $.each(data.stationInfos, function() {
                	$('#' + des).append('<option value="'+this.id+'">'+this.name+'</option>');
                });
                if (el == 'startAt') {
                	$("#stationStartAt").val($("#stationEndAt").val());
                }
            });
       }
   };
   
	$(document).ready(function() {
		
	    $('#return').bind('click', function() {
	         var url = $('#contextPath').val() + "/route/list.html";
	         window.location = url;
	      });
	    
		$("#duration").mask("99:99");
		
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
						
		oTable = $('#segmentTable').dataTable({
			"bSort" : false
		});
						
		$('#startAt').change(function() {
			getStation('startAt', 'stationStartAt');
		});
						
		$('#endAt').change(function() {
			getStation('endAt', 'stationEndAt');
		});
						
		$("#validDateDiv").datetimepicker({
            format : "yyyy/mm/dd - hh:ii",
            autoclose : true,
            todayBtn : true,
            startDate : new Date(),
            minuteStep : 10
         });
		
		$("#add").bind(
			'click',
			function() {
				if (giCount == 10) {
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
									
				if (endAt.trim() == '' || endAtKey == -1) {
	                 return;
	         }
				
				if (stationStartAt.trim() == '' || stationStartAtKey == -1) {
					return;
				}
									
				if (stationEndAt.trim() == '' || stationEndAtKey == -1) {
			        return;
			    }
									
				if (duration.trim() == '') {
			        return;
			    }
									
				if (price.trim() == '') {
			        return;
			    }
									
				$('#segmentTable').dataTable().fnAddData(
						[ startAt + ' - ' + stationStartAt,
						  endAt + ' - ' + stationEndAt, 
						  duration, 
						  accounting.formatMoney(price) ]);
				giCount++;

				$("#startAt").val(endAtKey);
				$("#startAt").prop("disabled", true);
				$("#stationStartAt").prop("disabled", true);
				getStation('startAt', 'stationStartAt');
									
				$("#endAt option[value=" + endAtKey + "]").hide();
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

				$("#save").bind('click',
					function() {
						var busType = $("#busType").val();
						info['busType'] = busType;
						info['segments'] = segments;
						info['validDate'] = $('#validDate').val();
											
						if (busType == -1) {
							alert('Bus Type must be selected!');
							return;
						}
											
						if (giCount == 0) {
							alert('Please add segment!');
							return;
						}
						
						if($('#validDate').val() == '' || $('#validDate').val() == null){
							alert('Please add valid Date!');
							return;
						}
											
						$.ajax({
							type : "POST",
							url : 'saveSegment.html',
							contentType : "application/x-www-form-urlencoded; charset=utf-8",
							data : {
								data : JSON.stringify(info)
							},
							success : function(response) {
								alert("Save Success!");
								var url = $('#contextPath').val() + "/route/list.html";
								window.location = url;
							},
							error: function(){
								alert("Save new route failed!");
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
		<div class="post" style="margin: 0px auto; width: 95%;">
			<div style="margin-left: 10px; margin-top: 10px;">
			   <table>
		          <tr>
		             <td>Select Bus Type :</td>
		             <td>Valid From : </td>
		          </tr>
			      <tr>
			         <td style="width: 46%;"><s:select id="busType" headerKey="-1"
               headerValue="--- Select Bus Type ---" list="busTypeBeans"
               name="busTypeBeans" listKey="id" listValue="name" />
               </td>
			         <td>
			            <div id="validDateDiv" class="input-append date form_datetime" style="margin-top: -5px;" data-date="">
                     <input id="validDate" size="16" type="text" value="" readonly
                        name="validDate"> <span class="add-on" required><i
                        class="icon-remove"></i></span> <span class="add-on"><i
                        class="icon-calendar"></i></span>
                  </div>
			         </td>
			      </tr>
			   </table>
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
					<td><input type="text" id="price" maxlength="9"/></td>
					<td><input class="btn btn-primary" type="button" id="add"
						value="Add" /></td>
				</tr>
			</table>
			<div style="margin-left: 10px; margin-top: 10px;margin-bottom: 10px;">
				<input class="btn btn-primary" type="button" id="save" value="Save" />
				<input class="btn btn-primary" type="button" id="return" value="Return to Route List" />
			</div>
		</div>
	</div>
	<jsp:include page="../common/footer.jsp" />
</body>

</html>