<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC 
   "-//W3C//DTD XHTML 1.1 Transitional//EN"
   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>VinaBus - Route details</title> 
<jsp:include page="../common/xheader.jsp" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/styles/select2.css" />
<link href="<%=request.getContextPath()%>/styles/trip/datetimepicker.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/index.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery.dataTables.min.js"></script>
<script src="<%=request.getContextPath()%>/js/accounting.min.js"></script>
<script src="<%=request.getContextPath()%>/js/bootstrap-datetimepicker.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/styles/custom-data-table.css" />
<script src="<%=request.getContextPath()%>/js/common/custom-data-table.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/styles/jquery-ui.css" />
<script src="<%=request.getContextPath()%>/js/jquery-ui.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery.ui.datepicker-vi.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery.maskedinput.min.js"></script>
<script src="<%=request.getContextPath()%>/js/select2.min.js"></script>
<script src="<%=request.getContextPath()%>/js/route/route-detail-list.js"></script>

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

#scheduleTable_filter {
   display: table-header-group !important;  
}

#scheduleTable_info {
   display: table !important;
}

#editPriceDialog {
	width: 900px;
	margin-left: -440px;
}

#busDetailDialog {
   width: 700px;
   margin-left: -360px;
}

#editBusDialog {
   width: 900px;
   margin-left: -450px;
   margin-top: -24px;
}

#editBusDialog .modal-body {
	max-height: none;
}

.header-table
{
	width: 100%;
}
.header-table td
{
	padding: 5px;
}</style>
</head>
<body>
   <jsp:include page="../common/header.jsp" />
   <jsp:include page="../common/menu.jsp" />
   <div id="page" class="well">
  		<h3 style="border-bottom: 1px solid #ddd; margin-bottom: 20px;">    
				Route details
         <table class="pull-right">
            <tr>
               <td><input class="btn btn-primary" type="button" id="addBusPrice" value="Edit Route Price"
                  style="height: 30px" /> <input class="btn btn-primary" id="assignBus" type="button"
                  value="Assign Bus to Route" style="height: 30px" /> 
                  <s:if test="%{haveBus == true}">
                     <input id="busStatusInsertBtn" type="button" class="btn btn-success" value="Add New Schedule"
                        style="height: 30px" />
                  </s:if>
                  <s:else>
                     <button class="btn" disabled="disabled" value="Add New Schedule" style="height: 30px">Add New Schedule</button>
                 </s:else>
                  <s:if test="%{haveBus == false}">
            <input class="btn btn-warning" type="button" id="editRoute" value="Edit Route" style="height: 30px" />
         </s:if></td>
            </tr>
         </table>
      </h3>  
      <div class="post">
         <div style="margin-top: 10px;">
            <input type="hidden" id="routeId" value="<s:property value='routeId'/>" />
            <input type="hidden" id="active" value="<s:property value='active'/>" />
            <table class="pull-right">
               <tr>
                  <td><s:select id="busType" list="busTypeBeans" name="busTypeBeans" listKey="id"
                           listValue="name" /></td>
                  <td>
                      <input type="text" id="validDateSelect" name="departureDate" readonly>
                  </td>
               </tr>
            </table>
         </div>
         <h3>
            <s:property value="routeName" />
         </h3>
         <table id="segmentTable" align="center" class="table table-striped table-bordered dataTable" style="margin-top:20px;background-color: #fff">
            <thead>
               <tr>
                  <th style="text-align: center; width: 391px !important;">Name</th>  
                  <th style="text-align: center; width: 176px !important;">Travel Time</th>
                  <th style="text-align: center; width: 209px !important;">Price (VNĐ)</th>
               </tr>
            </thead>
            <tbody>
               <s:iterator value="segmentInfos">
                  <tr id="segment_<s:property value='id'/>" data-segment-id="<s:property value='id'/>">
                     <td><s:property value="name" /></td>
                     <td style="text-align: center;"><s:property value="duration"/></td>
                     <td style="padding-right:100px; text-align: right"><s:property value="price"/></td>
                  </tr>
               </s:iterator>
            </tbody>
            <tfoot>
               <tr>
                  <td style="text-align: right; font-weight:bold;">Total : </td>
                  <td style="text-align: center; font-weight:bold;"><s:property value='sumaryTime'/></td>
                  <td style="text-align: right;padding-right:100px; font-weight:bold;">
                     <label id="totalMoney" style="font-weight:bold;"></label>
                  </td>
               </tr>
            </tfoot>
         </table>
         </br>
         <h3>
            Schedule
         </h3>
         <table id="scheduleTable" align="center" class="table table-striped table-bordered dataTable" style="margin-top:20px;background-color: #fff">
            <thead>
               <tr>
                  <th>Bus Plate Number</th>
                  <th>Bus Type</th>
                  <th>From Date</th>
                  <th>To Date</th>
                  <th>Cancel</th>
               </tr>
            </thead>
            <tbody>
               <s:iterator value="busStatusBeans">
                  <tr>
                     <td><s:property value="bus.plateNumber" /></td>
                     <td><s:property value="bus.busType.name" /></td>
                     <td><s:date name="fromDate" format="HH:mm - dd/MM/yyyy" /></td>
                     <td><s:date name="toDate" format="HH:mm - dd/MM/yyyy" /></td>
                     <td><s:if test="%{status == 'active'}"><s:hidden name="id" value="%{id}" /><a class="btn btn-danger btn-small btn-cancel" >Cancel</a></s:if><s:elseif test="status == 'cancelled'">Cancelled</s:elseif></td>
                  </tr>
               </s:iterator>
            </tbody>
         </table>
         <br/>
         <div style="margin-bottom: 10px;">
            <input class="btn btn-primary" type="button" id="return" value="Return to Route List" />
            <input type="hidden" id="reverseRouteId" value="<s:property value='reverseRouteId'/>" />
            <input class="btn btn-primary" type="button" id="reverseRoute" value="Show the reverse route" />
         </div>
      </div>
   </div>
   
   <!-- Modal Assign bus Dialog -->
   <div id="busDetailDialog" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
      aria-hidden="true">
      <div class="modal-header">
         <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
         <h3 id="busDetailDialogLabel">List Bus In Route</h3>
      </div>
      <div class="modal-body">
         <table>
            <tr>
               <td>Bus Type : </td>
               <td><s:select id="addBus_BusType" list="busTypeBeans" name="busTypes" listKey="id" listValue="name"/><br/></td>
               <td>Select bus : </td>
               <td><select id='busDetailbusPlate' name='busDetailbusPlate'></select></td>
               <td><button style="margin-top: -8px;" type="button" id="busDetailAdd" class="btn btn-primary">Add</button></td>
            </tr>
         </table>
         <label id="addBusError" style="margin-left: 297px; color: red;"></label>
         <table id="busDetailTable" align="center" class="table table-striped table-bordered dataTable" style="margin-top:20px;background-color: #fff">
            <thead>
               <tr>
                  <th>Bus Id</th>
                  <th>Plate Number</th>
                  <th></th>
               </tr>
            </thead>
            <tbody>
            </tbody>
         </table>
      </div>
      <div class="modal-footer">
         <button type="button" class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
         <button id="busDetailSave" class="btn btn-primary" data-dismiss="modal" aria-hidden="true">Save</button>
      </div>
   </div>
   
   <!-- Modal Show Edit Price -->
   <div id="editPriceDialog" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
      aria-hidden="true">
      <div class="modal-header">
         <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
         <h3 id="editPriceDialogLabel">Edit Route Price</h3>
      </div>
      <div class="modal-body">
         <div class="post" style="margin: 0px auto; width: 95%;">
         <label id="preUpdateTariffMessage" style="width: 65%"></label>
            <table>
               <tr>
                  <td style="width: 50%">Valid date :
                     <input id="validDate" type="text" name="tripDialogDepartureTime" readonly/>
                  </td>
                  <td>Select bus type :
                     <!--<div class="input-append date form_datetime">-->
                        <s:select id="busTypes" list="busTypes"
                           name="busTypes" listKey="id" listValue="name" />
                    <!--  </div> -->
                  </td>
               </tr>
            </table>
            <p>Input Price must be from 50.000 VNĐ to 1.000.000 VNĐ</p>
            <table id="editSegmentTable" class="table table-striped table-bordered dataTable" style="margin-top:20px;background-color: #fff">
               <thead>
                  <tr>
                     <th>Start At</th>
                     <th>End At</th>
                     <th>Price (VND)</th>
                  </tr>
               <thead>
               <tbody>
                  <s:iterator value="segmentBeans">
                     <tr>
                        <td><s:property value="startAt.name" /></td>
                        <td><s:property value="endAt.name" /></td>
                        <td><input id="<s:property value='id'/>" type="text" value="" maxlength="7" style="text-align: right;margin: 0" 
                           onblur="validateSegmentPrice(this)"/> .000</td>
                     </tr>
                  </s:iterator>
               </tbody>
            </table>
            <div><input type="checkbox" id="addTariffRevRoute" style="margin-top: -4px;"/> Add price for reverse route too?</div>
            <p id="preUpdateTariffMessage" style="color: red"></p>
         </div>
      </div>
      <div class="modal-footer">
         <button type="button" class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
         <button id="editPriceSave" class="btn btn-primary" data-dismiss="modal" aria-hidden="true">Save</button>
      </div>
   </div>
   
   <!-- Modal Show Edit Route -->
   <div id="editBusDialog" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
      aria-hidden="true">
      
      <div class="modal-header">
         <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
         <h3 id="editBusDialogLabel">Edit Route</h3>
      </div>
      <div class="modal-body">
      	<div class="alert alert-info fade in" style="display:none;"><button type="button" class="close" data-dismiss="alert">×</button>
				<span id="errorMessage"></span>
		</div>
         <div class="post" style="margin: 0px auto; width: 95%;">
            <table class="header-table">
            	<thead>
            		<tr>
            			<th></th>
            			<th>Start At</th>
            			<th>End At</th>
            			<th>Duration</th>
            			<th></th>
            		</tr>
            	</thead>
               <tr style="margin-bottom: 10px;">
               <th style="text-align: left;">Location</th>
               <td><s:select id="startAt" name="startLocation" list="cityBeans"
                     name="routeBeans" listKey="id" listValue="name" style="width: 250px;"></s:select></td>
               <td><s:select id="endAt" name="endLocation" list="cityBeans"
                     name="routeBeans" listKey="id" listValue="name" style="width: 250px;">
                     </s:select></td>
               <td rowspan="2"><input type="text" id="duration" style="width: 50px; text-align: center;" value="01:00"/></td>
               <td rowspan="2"><input class="btn btn-primary" type="button" id="add" value="Add" disabled="disabled" 
                  style="margin: 10px 0 20px 10px; width: 75px; height: 30px"/>
               </td>
            </tr>
            <tr>
            	<th style="text-align: left;">Station</th>
            	<td>
            		<select id="stationStartAt"  style="width: 250px;" class="dropdown-toggle"></select>
           		</td>
           		<td>
           			<select id="stationEndAt" style="width: 250px;" class="dropdown-toggle"></select>
           		</td>
        	</tr>
            </table>
            <table id="manageSegmentTable" class="table table-striped table-bordered dataTable" style="margin-top:20px;background-color: #fff">
               <thead>
                  <tr>
                     <td>Start At</td>
                     <td>End At</td>
                     <td>Duration (hh:mm)</td>
                  </tr>
               <thead>
               <tbody>
               </tbody>
            </table>
         </div>
      </div>
      <div class="modal-footer">
         <button type="button" id="editRouteCancel" class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
         <button id="editRouteSave" class="btn btn-primary" data-dismiss="modal" aria-hidden="true">Save</button>
      </div>
   </div>
   
   <!-- Modal add new schedule-->
   <div id="CreateScheduleDialog" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
      aria-hidden="true">
      <form id="addNewTripForm" action="save.html" method="POST">
         <input id="routeBeans" size="16" type="hidden" value="" readonly name="routeBeans">
         <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h3 id="tripEditDialogLabel"></h3>
         </div>
         <div class="modal-body">
         <div class="alert fade in" id="schedule-error" style="display:none;"><button type="button" class="close" data-dismiss="alert">×</button>
         <label id="addScheduleError"></label>
         </div>
         	<div style="overflow: hidden;">
	         	<div style="float: left; width: 50%">
		            <label for="tripDialogDepartureTimeDiv">From Date: </label>
		            <div id="tripDialogDepartureTimeDiv" class="input-append date form_datetime" data-date="">
		               <input id="tripDialogDepartureTime" size="16" type="text" value="" readonly
		                  name="tripDialogDepartureTime"><span
		                  class="add-on"><i class="icon-calendar"></i></span>
		            </div>
	            </div>
	            
	            <div style="float: left; width: 50%">
		            <label for="tripDialogArrivalTimeDiv">To Date: </label>
		            <div id="tripDialogArrivalTimeDiv" class="input-append date form_datetime" data-date="">
		               <input id="tripDialogArrivalTime" size="16" type="text" value="" readonly>
		            </div>
	            </div>
            </div>
            
            <label for="tripDialogBusType">Bus Type: </label> <select id="tripDialogBusType" name="busTypeBeans">
               <option value="-1">Select Bus Type</option>
            </select>
            <div id="trip-plate-number">
					<label style="width: 50%; float: left;"><input type="radio" name="avaiBusList" value="busInRoute" checked="checked" onclick="showTripDialogBusPlate()" style="margin-top: 0">
						<span style="margin-left:10px; ">Available Bus in Route</span>
					</label>
					<label style="width: 50%; float: left;"><input type="radio" name="avaiBusList" value="busInStation" onclick="showTripDialogBusPlate()">
						<span style="margin-left:10px; ">Available Bus in this Station</span>
					</label>
					<label for="routeSelect">Bus Plate Number</label>
					<select id='tripDialogBusPlate' name='tripDialogBusPlate'></select>					
					<select id='tripDialogBusPlateExtends'
						name='tripDialogBusPlateExtends' class="hidden"></select>
				</div>
            <div id="tripDialogStatus"></div>
            <div>
            <input style="margin-top: -3px;" type="checkbox" id="autoReturnBus" name="autoReturnBus"/> Auto-return to start station. 
            <div id="autoReturnDiv" style="display: none;">
               <input style="margin-top: -3px;" type="checkbox" id="allowBooking" name="allowBooking" checked="checked"/> Allow booking. 
               
               <div style="overflow: hidden;">
               	   <div style="float: left; width: 50%">
		               <label for="autoReturnDialogDepartureTimeDiv">From Date: </label>
		               <div id="autoReturnDialogDepartureTimeDiv" class="input-append date form_datetime" data-date="">
		                  <input id="autoReturnDialogDepartureTime" size="16" type="text" value="" readonly
		                     name="autoReturnDepartureTime"><span class="add-on"><i class="icon-calendar"></i></span>
		               </div>
	               </div>
	               
	               <div style="float: left; width: 50%">
		               <label for="autoReturnpDialogArrivalTimeDiv">To Date: </label>
		               <div id="autoReturnDialogArrivalTimeDiv" class="input-append date form_datetime" data-date="">
		                  <input id="autoReturnDialogArrivalTime" size="16" type="text" value="" readonly>
		               </div>
		           </div>
               </div>
               
            </div>
         </div>
         </div>
         <div class="modal-footer">
            <button type="button" class="btn" id="cancelAdd" data-dismiss="modal" aria-hidden="true">Cancel</button> 
            <input disabled="disabled" type="button" id="addNewSchedule" class="btn btn-primary" value='Save changes' />
         </div>
      </form>
   </div>
   
   <jsp:include page="../common/footer.jsp" />
   
	<!-- Cancel modal -->
	<div id="cancelModal" class="modal hide fade">
		<input type="hidden" name="cancelBusStatusId" />
		<div class="modal-header">
			<button type="button" class="close close-model-btn">×</button>
			<h3 id="myModalLabel"><s:text name="header.cancelReservation" /></h3>
		</div>
		<div class="modal-body">
			Reason <s:textfield label="Reason" name="reason" value="" /><span style="padding-left: 3px; color: red; font-size: 22px;">*</span>
			<div id="message"></div>
		</div>
		<div class="modal-footer">
			<button id="btnClose" class="btn close-model-btn">Close</button>
			<button id="btnRetry" class="btn close-model-btn btn-danger">Retry</button>
			<button id="btnNo" class="btn close-model-btn">No</button>
			<button id="btnCancel" class="btn btn-danger">Yes</button>
		</div>
	</div>
</body>
</html>
