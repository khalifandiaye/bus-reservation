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
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/styles/select2.css" />
<script src="<%=request.getContextPath()%>/js/jquery.dataTables.min.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery.maskedinput.min.js"></script>
<script src="<%=request.getContextPath()%>/js/accounting.min.js"></script>
<script src="<%=request.getContextPath()%>/js/bootstrap-datetimepicker.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/styles/custom-data-table.css" />
<script src="<%=request.getContextPath()%>/js/common/custom-data-table.js"></script>
<script src="<%=request.getContextPath()%>/js/select2.min.js"></script>
<script src="<%=request.getContextPath()%>/js/route/list.js"></script>

<style type="text/css">
.dataTables_length {
	display: none;
}

#segmentTable_filter {
	display: none;
}

#addRouteDialog {
	width: 900px;
	margin-left: -450px;
	margin-top: -24px;
}

#addRouteDialog .modal-body {
	max-height: none;
}

table {
	width: 100%;
}

.header-table td {
	padding: 5px;
}

.select2-container {
	width: 100%;
}
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
      	<div class="alert alert-info fade in" style="display:none;"><button type="button" class="close" data-dismiss="alert">×</button>
				<span id="errorMessage"></span>
			</div>
         <div class="post" style="margin: 0px auto; width: 95%;">
			<table class="header-table">
            <thead>
               <tr>
                  <th style="width: 250px;">Start At</th>
                  <th style="width: 250px;">End At</th>
                  <th>Duration (hh:mm)</th>
                  <th></th>
               </tr>
            <thead>
            <tbody>
	            <tr style="margin-bottom: 10px;">
	               <td><s:select id="startAt" list="cityBeans"
	                     name="routeBeans" listKey="id" listValue="name"></s:select></td>
	               <td><s:select id="endAt" list="cityBeans"
	                     name="routeBeans" listKey="id" listValue="name">
	                     </s:select></td>
	               <td rowspan="2"><input type="text" style="width: 98px; text-align: center;" id="duration" value="01:00"/></td>
	               <td rowspan="2"><input class="btn btn-primary" type="button" id="add" value="Add" disabled="disabled" 
	                  style="margin-top: 10px;;margin-bottom: 10px; margin-left: 10px; margin-right: 0; width: 75px;"/>
	               </td>
	            </tr>
	            <tr>
	            	<td><select id="stationStartAt"></select></td>
	            	<td><select id="stationEndAt"></select></td>
	            </tr>
            </tbody>
         </table>
		<table id="segmentTable">
			<thead>
				<tr>
					<th>Start At</th>
					<th>End At</th>
					<th>Duration</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
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
         <h3 id="saveSuccessDialogLabel">Add Route Result</h3>
      </div>
      <div class="modal-body">
         <p id="saveSuccessDialogLabeMessage"></p>
      </div>
      <div class="modal-footer">
         <button class="btn" id="saveSuccessDialogOk" data-dismiss="modal"
            aria-hidden="true">Ok</button>
      </div>
   </div>
	
<input id="routeId" value="" type="hidden" />
<jsp:include page="../common/footer.jsp" />
</body>


</html>