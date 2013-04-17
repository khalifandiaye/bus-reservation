<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>VinaBus - Manage bus</title>
<jsp:include page="../common/xheader.jsp" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/styles/custom-data-table.css" />
<script src="<%=request.getContextPath()%>/js/index.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery.dataTables.min.js"></script>
<script src="<%=request.getContextPath()%>/js/common/custom-data-table.js"></script>
<script type="text/javascript">
   function deleteBus(id) {
      $('#busId').val(id);
      $("#deleteBusDialog").modal();
   };
   
	$(document).ready(function() {		
		
		var busTable = $("#busTable").dataTable({
		}); 
		
		$('#addBus').bind().bind('click', function(event) {
			  $('#plateNumber').val('');
			  $('#busType').val(-1);
			  $('#addResult').text("");
			  $("#addBusDialog").modal();
		});
		
		$('#busDeleteDialogOk').click(function() {
			   var busId = $('#busId').val();
            $.ajax({
            	url: "deleteBus.html?busId=" + busId,
	            }).done(function(data) {
	            	$('#deleteBusDialog').modal('hide');
	            	$("#deleteSuccess").modal();
	            	$('#deleteSuccessDialogLabeMessage').text((data.message));
	            });
      	});
		
		$('#deleteSuccessDialogOk').click(function(){
			var url = $('#contextPath').val() + "/bus/list.html";
	        window.location = url;
        });
		
		$('#busAddDialogOk').click(function(){
		   var plateNumber = $('#plateNumber').val();
		   var busType = $('#busType').val();
		   if (plateNumber.trim() == '' || busType == -1) {
			   $('#addResult').text("Please enter bus plate number! ");
			   return;
		   }
            $.ajax({
               url: "saveBus.html?plateNumber=" + plateNumber + "&busTypeBeans=" + busType,
            }).done(function(data) {
               if (data.resultId == 1 || data.resultId == 2){
               $('#addResult').text((data.message));
               }
               else {
               $('#addBusDialog').modal('hide');
               var url = $('#contextPath').val() + "/bus/list.html";
               window.location = url;
               }
            });
		});
	});
</script>
<style type="text/css">
.dataTables_length {
	display: none;
}

.dataTables_info {
	display: none;
}

#addBusTable_filter {
   display: none;
}
</style>
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<jsp:include page="../common/menu.jsp" />
	<div id="page" class="well small-well">   
		<div class="post">
			<h3 style="border-bottom: 1px solid #ddd; margin-bottom: 20px;">    
				Manage bus  
				<input class="btn btn-primary pull-right" id="addBus" type="button"
					value="Add New Bus" />
			</h3>  
			
			<table id="busTable" align="center" class="table table-striped table-bordered dataTable" style="margin-top:20px;background-color: #fff">
				<thead>
					<tr>
					<th>Bus Type</th>
					<th>Plate Number</th>
					<th>Assigned route</th>
					<th>Status</th>
               		<th></th>
               		</tr>
				</thead>
				<tbody>
					<s:iterator value="busBeans">
						<tr id="route_<s:property value='id'/>">
							<td><s:property value="busType.name" /></td>
							<td><s:property value="plateNumber" /></td>
							<td><s:property value="forwardRoute.name" /></td>
							<td><s:property value="status" /></td>
							<td style="width: 6%"><a
								data-delete="<s:property value='id'/>" style="cursor: pointer;"   
								onclick='javascript: deleteBus(<s:property value='id'/>)' class="btn btn-small btn-danger" >Delete</a></td>
						</tr>
					</s:iterator>
				</tbody>
			</table>
		</div>
	</div>

	<!-- Modal Delete Dialog -->
	<div id="deleteBusDialog" class="modal hide fade" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal"
				aria-hidden="true">×</button>
			<h3 id="busDeleteDialogLabel">Delete</h3>
		</div>
		<div class="modal-body">
			<p>Do you want to delete this bus?</p>
		</div>
		<div class="modal-footer">
			<button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
			<button id="busDeleteDialogOk" class="btn btn-danger">Delete</button>
		</div>
	</div>
	
		<!-- Modal delete success Dialog -->
	<div id="deleteSuccess" class="modal hide fade" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal"
				aria-hidden="true">×</button>
			<h3 id="deleteSuccessDialogLabel">Delete Result</h3>
		</div>
		<div class="modal-body">
			<p id="deleteSuccessDialogLabeMessage"></p>
		</div>
		<div class="modal-footer">
			<button class="btn" id="deleteSuccessDialogOk" data-dismiss="modal"
				aria-hidden="true">Ok</button>
		</div>
	</div>

	<!-- Modal Add Dialog -->
	<div id="addBusDialog" class="modal hide fade" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal"
				aria-hidden="true">×</button>
			<h3 id="busAddDialogLabel">Add New Bus</h3>
		</div>
		<div class="modal-body">
			<form action="save-bus.html" method="post">
				<table id="addBusTable">
					<thead>
						<tr>
							<th></th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>
							  Plate Number : <input type="text" id="plateNumber" name="plateNumber" value="">
								<span style="color: red; font-size: 22px;">*</span>
								<p id="addResult" style="color: red; "></p>
							</td>
							<td style="vertical-align: top;">
							  Select Bus Type : <s:select id="busType" list="busTypeBeans"
									name="busTypeBeans" listKey="id" listValue="name" />
						   </td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>
		
		<div class="modal-footer">
			<button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
			<button id="busAddDialogOk" class="btn btn-primary" >Save</button>
		</div>
	</div>
	<input id="busId" value="" type="hidden" />
	<jsp:include page="../common/footer.jsp" />
</body>

</html>