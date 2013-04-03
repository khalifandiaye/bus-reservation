<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>VinaBus - Route list</title>
<jsp:include page="../common/xheader.jsp" />
<link href="<%=request.getContextPath()%>/styles/trip/datetimepicker.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/styles/route/jquery-ui-1.10.1.custom.min.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/jquery.dataTables.min.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery.maskedinput.min.js"></script>
<script src="<%=request.getContextPath()%>/js/accounting.min.js"></script>
<script src="<%=request.getContextPath()%>/js/bootstrap-datetimepicker.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/styles/custom-data-table.css" />
<script src="<%=request.getContextPath()%>/js/common/custom-data-table.js"></script>
<script type="text/javascript">
	function loadDetails(routeid) {
    	var url = $('#contextPath').val() + "/route/route-detail-list.html?routeId=" + routeid;
    	window.location = url;
 	};
 
 	function deleteRoute(id) {
 	   $('#routeId').val(id);
 	   $("#deleteRouteDialog").modal();
 	};
 	
 	function activeRoute(id) {
 		$.ajax({
         url: "activeRoute.html?routeId=" + id,
      }).done(function(data) {
         $("#saveSuccessDialogLabeMessage").text(data.message);
         $("#saveSuccess").modal();
      });
 	}
</script>

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
                getDuration();
            });
       }
   };
   
   function getDuration() {
	   var startStationAt = $("#stationStartAt").val();
	   var endStationAt = $("#stationEndAt").val();
	   if (startStationAt && endStationAt && startStationAt != -1 && endStationAt != -1) {
		   $.ajax({
			      type : "GET",
			      url: "getSegmentDuration.html?startStation=" + startStationAt + "&endStation=" + endStationAt,
	            contentType : "application/x-www-form-urlencoded; charset=utf-8",
			   }).done(
				   function(data) {
					   if (data.travelTime != '') {
						   $("#duration").val(data.travelTime);
						   $("#duration").prop("disabled", true);
					   } else {
						   $("#duration").prop("disabled", false);
					   }
					   checkAdd();
			      });
		} 
   }
   
   function checkAdd() {
	   var startAt = $('#startAt').val();
	   var endAt = $("#endAt").val();
	   var duration = $('#duration').val();
	   
	   duration = parseInt(duration.replace(":",""), 10);

	   if(startAt != -1 && endAt != -1 && duration != '' && duration >= parseInt('100', 10)){
		   $("#add").removeAttr("disabled"); 
	   } else { 
		   $("#add").attr("disabled","disabled");
	   }
   }
   
   $(document).ready(function() {
      
	   var routeTable = $('#routeTable').dataTable({ bSort : false });
	   var segmentTable = $('#segmentTable').dataTable({ bSort : false , bPaginate : false });
      	   
      $('#addRoute').bind('click', function(event) {
    	   giCount = 0;
    	   $("#routeAddDialogOk").attr("disabled","disabled"); 
    	   segmentTable.dataTable().fnClearTable();
    	   $("#startAt").prop("disabled", false);
    	   $("#stationStartAt").prop("disabled", false);
    	   $("#startAt").val(-1);
    	   $("#endAt").val(-1);
    	   $("#duration").val('01:00');
    	   $('#stationStartAt').empty();
    	   $('#stationEndAt').empty();
    	   $("#endAt option").show();
    	   $("#addRouteDialog").modal();
      });
       
      $('#routeDeleteDialogOk').click(function() {
    	   var routeId = $('#routeId').val();
         $.ajax({
        	   url: "deleteRoute.html?routeId=" + routeId,
         }).done(function(data) {
        	   $('#deleteRouteDialog').modal('hide');
        	   $("#saveSuccessDialogLabeMessage").text(data.message);
            $("#saveSuccess").modal();
        	});
      });
	   
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
                  
      $('#startAt').change(function() {
    	   $("#endAt option").show();
    	   $("#endAt").val(-1);
    	   $('#stationEndAt').empty();
    	   getStation('startAt', 'stationStartAt');
    	   $("#endAt option[value=" + $("#startAt").val() + "]").hide();
    	   checkAdd();
      });
                  
      $('#endAt').change(function() {
         getStation('endAt', 'stationEndAt');
         checkAdd();
      });
      
      $('#duration').change(function(){
    	   checkAdd();
      });
                  
      $("#validDateDiv").datetimepicker({
         format : "yyyy/mm/dd - hh:ii",
         autoclose : true,
         todayBtn : true,
         startDate : new Date(),
         minuteStep : 10
      });
      
      $("#add").bind('click', function() {
    	      if (giCount == 6) {
               $("#errorMessage").text("Maximum segment added!");
               return;
    	      }
    	      
    	    	$("#routeAddDialogOk").removeAttr("disabled");  

            var startAtKey = $("#startAt").val();
            var stationStartAtKey = $("#stationStartAt").val();
            var endAtKey = $("#endAt").val();
            var stationEndAtKey = $("#stationEndAt").val();
            var startAt = $("#startAt option:selected").text();
            var stationStartAt = $("#stationStartAt option:selected").text();
            var endAt = $("#endAt option:selected").text();
            var stationEndAt = $("#stationEndAt option:selected").text();
            var duration = $("#duration").val();
                           
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
                           
            $('#segmentTable').dataTable().fnAddData(
                  [ startAt + ' - ' + stationStartAt,
                    endAt + ' - ' + stationEndAt, 
                    duration ]);
            giCount++;

            $("#startAt").val(endAtKey);
            $("#startAt").prop("disabled", true);
            $("#stationStartAt").prop("disabled", true);
            $("#stationEndAt").empty();
            getStation('startAt', 'stationStartAt');
                           
            $("#endAt option[value=" + endAtKey + "]").hide();
            $("#endAt").val(-1);
            $("#duration").val('01:00');
            $('#stationEndAt').empty();
            $("#duration").prop("disabled", false);

            var segment = {};
            segment['startAt'] = startAtKey;
            segment['stationStartAt'] = stationStartAtKey;
            segment['endAt'] = endAtKey;
            segment['stationEndAt'] = stationEndAtKey;
            segment['duration'] = duration;
            segments.push(segment);
     });

     $("#routeAddDialogOk").bind('click', 
    		 function() {
            info['segments'] = segments;
            info['validDate'] = $('#validDate').val();
                           
            $.ajax({
               type : "POST",
               url : 'saveSegment.html',
               contentType : "application/x-www-form-urlencoded; charset=utf-8",
               data : {
                  data : JSON.stringify(info)
               },
               success : function(response) {
              	   $('#addRouteDialog').modal('hide');
                  $("#saveSuccessDialogLabeMessage").html(response);
                  $("#saveSuccess").modal();
               },
               error: function(){
              	 $('#saveSuccess').modal('hide');
                $("#saveSuccessDialogLabeMessage").html(response);
                $("#saveSuccess").text("Save new route failed!");
               }
            });
         });
     
     $('#saveSuccessDialogOk').click(function() {
            var url = $('#contextPath').val() + "/route/list.html";
            window.location = url;
      });
     
     $('#routeAddDialogCancel').click(function() {
    	 info = {};
    	 segments = [];
    	 giCount = 0;
     });
   });

   var info = {};
   var segments = [];
   var giCount = 0;
</script>

<style type="text/css">
   .dataTables_length { display: none; }
   #segmentTable_filter { display: none; }
   #addRouteDialog { width: 900px; margin-left: -440px; }
</style>
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<jsp:include page="../common/menu.jsp" />
	<div id="page" class="well">
		<h3 style="border-bottom: 1px solid #ddd; margin-bottom: 20px;">    
				Manage route  
				<input class="pull-right btn btn-primary" id="addRoute" type="button" value="Add New Route" />
		</h3>  
		<div class="post">
			<table id="routeTable" align="center" class="table table-striped table-bordered dataTable" style="margin-top:20px;background-color: #fff">
				<thead>
					<tr>
						<th>Route Name</th>
						<th>Total duration</th>
						<th></th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<s:iterator value="routeInfos">
						<tr id="route_<s:property value='id'/>">
							<td><s:property value="routeName" /></td>
							<td><s:property value="travelTime" /></td>
							<td style="width: 6%"><input class="btn btn-info btn-small"
								type="button" value="View Details"
								onclick='javascript: loadDetails(<s:property value='id'/>)' /></td>
                     <s:set name="status" value="active"/>
                     <s:if test="%{#status == 'active'}">
                        <td style="width: 6%"><input
                        data-delete="<s:property value='id'/>" class="btn btn-danger btn-small" style="width: 95px;"
                        type="button" value="Deactivate"
                        onclick='javascript: deleteRoute(<s:property value='id'/>)' /></td>
                     </s:if>
                     <s:else>
                        <td style="width: 6%"><input
                        data-active="<s:property value='id'/>" class="btn btn-success btn-small" style="width: 95px;"
                        type="button" value="Activate"
                        onclick='javascript: activeRoute(<s:property value='id'/>)' /></td>
                     </s:else>
						</tr>
					</s:iterator>
				</tbody>
			</table>
		</div>
	</div>
	
	<!-- Modal Add Dialog -->
   <div id="addRouteDialog" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
      <div class="modal-header">
         <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
         <h3 id="routeAddDialogLabel">Add new route</h3>
      </div>
      <div class="modal-body">
         <div class="post" style="margin: 0px auto; width: 95%;">
				<table id="segmentTable">
            <thead>
               <tr>
                  <td>Start At</td>
                  <td>End At</td>
                  <td>Duration (hh:mm)</td>
               </tr>
            <thead>
            <tbody>
            </tbody>
            <tr style="margin-bottom: 10px;">
               <td><s:select id="startAt" headerKey="-1"
                     headerValue="--- Select Route ---" list="cityBeans"
                     name="routeBeans" listKey="id" listValue="name"></s:select><select
                  id="stationStartAt" headerKey="-1"
                  headerValue="--- Select Start Station ---" style="margin-top:10px;"></select></td>
               <td><s:select id="endAt" headerKey="-1"
                     headerValue="--- Select Route ---" list="cityBeans"
                     name="routeBeans" listKey="id" listValue="name">
                     </s:select><select
                  id="stationEndAt" headerKey="-1"
                  headerValue="--- Select End Station ---" style="margin-top:10px;"></select></td>
               <td><input type="text" id="duration" /></td>
               <td><input class="btn btn-primary" type="button" id="add" value="Add" disabled="disabled" 
                  style="margin-top: 10px;;margin-bottom: 10px; margin-left: 10px; margin-right: 0; width: 75px;"/></td>
            </tr>
         </table>
      </div>
      </div>
      <div class="modal-footer">
         <button class="btn" data-dismiss="modal" id="routeAddDialogCancel" aria-hidden="true">Cancel</button>
         <button class="btn btn-primary" type="button" id="routeAddDialogOk" disabled="disabled">Save</button>
      </div>
   </div>

	<!-- Modal Delete Dialog -->
	<div id="deleteRouteDialog" class="modal hide fade" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
			<h3 id="routeDeleteDialogLabel">Deactivate</h3>
		</div>
		<div class="modal-body">
			<p>Do you want to deactivate this route?</p>
		</div>
		<div class="modal-footer">
			<button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
			<button id="routeDeleteDialogOk" class="btn btn-danger">Deactivate</button>
		</div>
	</div>
	
	<!-- Modal Save success Dialog -->
   <div id="saveSuccess" class="modal hide fade" tabindex="-1"
      role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
      <div class="modal-header">
         <button type="button" class="close" data-dismiss="modal"
            aria-hidden="true">×</button>
         <h3 id="saveSuccessDialogLabel">Message</h3>
      </div>
      <div class="modal-body">
         <p id="saveSuccessDialogLabeMessage"></p>
      </div>
      <div class="modal-footer">
         <button class="btn" id="saveSuccessDialogOk" data-dismiss="modal"
            aria-hidden="true">Ok</button>
      </div>
   </div>
	
<!-- Modal PreUpdateTariffCheck -->
<div id="preUpdateTariff" class="modal hide fade" tabindex="-1"
   role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-header">
      <button type="button" class="close" data-dismiss="modal"
         aria-hidden="true">×</button>
      <h3 id="preUpdateTariffDialogLabel">Message</h3>
   </div>
   <div class="modal-body">
      <p> The folowing route(s) may have been changed when you update the this Tariff: </p>
      <p id="preUpdateTariffDialogLabeMessage"></p>
      <p> Do you want to continue? </p>
   </div>
   <div class="modal-footer">
      <button class="btn" id="preUpdateTariffDialogCancel" data-dismiss="modal"
         aria-hidden="true">Cancel</button>
      <button class="btn" id="preUpdateTariffDialogOk" data-dismiss="modal"
         aria-hidden="true">Ok</button>
   </div>
</div>

<input id="routeId" value="" type="hidden" />
<jsp:include page="../common/footer.jsp" />
</body>


</html>