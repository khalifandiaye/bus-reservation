<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>VinaBus - Segment list</title>
<jsp:include page="../common/xheader.jsp" />
<link href="<%=request.getContextPath()%>/styles/trip/datetimepicker.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/index.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery.dataTables.min.js"></script>
<script src="<%=request.getContextPath()%>/js/accounting.min.js"></script>
<script src="<%=request.getContextPath()%>/js/bootstrap-datetimepicker.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery.maskedinput.min.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/styles/custom-data-table.css" />
<script src="<%=request.getContextPath()%>/js/common/custom-data-table.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/styles/jquery-ui.css" />
<script src="<%=request.getContextPath()%>/js/jquery-ui.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery.ui.datepicker-vi.js"></script>
<script type="text/javascript">
Date.prototype.toMyString = function () {

    function padZero(obj) {
          obj = obj + '';
          if (obj.length == 1)
              obj = "0" + obj
          return obj;
    }

    var output = "";
    output += padZero(this.getDate()) + "/";
    output += padZero(this.getMonth()+1) + "/";
    output += this.getFullYear();

    return output; 
};

   function changeDuration(id) {
	   $("#segmentId").val(id);
/*       $.ajax({
    	    type : "POST",
          url : $('#contextPath').val()
                + "/route/getPreUpdateTariffAction.html";
          data : form.serialize(),
          success : function(response) {
             $('#editDurationDialog').modal('hide');
             alert(response.message);
             var url = $('#contextPath').val()
             + "/segment/list.html";
              window.location = url;
          }
       }); */
      $("#editDurationDialog").modal();
   };

   var d = new Date();
   var now = d.toMyString();
   d.setDate(d.getDate() + 1);
   $(function() {
       $('#validDateSelect').datepicker({
          dateFormat : 'dd/mm/yy',
          minDate : '0',
          maxDate : '+3M',
          regional : 'vi'
       });
       $('#validDateSelect').val(now);
       $("#validDateSelect").change(function() {
    	   getSegmentDuration($("#validDateSelect").val());
        });
       
       $('#validFromTime').datepicker({
             dateFormat : 'dd/mm/yy',
             minDate : '+1D',
             maxDate : '+3M',
             regional : 'vi'
          });
          $('#validFromTime').val(d.toMyString());
 });
    
	$(document).ready(function() {
		var busTable = $('#segmentTable').dataTable({bSort : false});
		$("#duration").mask("99:99");

		$('#editSegmentDialogOk').click(function(){
			var form = $('#editSegmentForm');
			$.ajax({
	               type : "POST",
	               url : "saveSegment.html",
	               data : form.serialize(),
	               success : function(response) {
	                  $('#editDurationDialog').modal('hide');
	                  alert(response.message);
	                  var url = $('#contextPath').val()
	                  + "/segment/list.html";
	                   window.location = url;
	               }
	            });
		});
		
		/* $("#validFromDiv").datetimepicker({
	         format : "dd/mm/yyyy - hh:ii",
	         autoclose : true,
	         todayBtn : true,
	         startDate : date,
	         minuteStep : 10
	   });
		
		$("#validDateSelectDiv").datetimepicker({
	         format : "dd/mm/yyyy - hh:ii",
	         autoclose : true,
	         todayBtn : true,
	         minuteStep : 10
	   }).change(function(){
	    	  getSegmentDuration($("#validDateSelect").val());
	   }); */
	});
	
	function getSegmentDuration(date) {
	      var info = {};
	      info['validDate'] = date;
	      $.ajax({
	         type : "POST",
	         url : 'getSegmentDur.html',
	         contentType : "application/x-www-form-urlencoded; charset=utf-8",
	         data : {data : JSON.stringify(info)},
	         success : function(response) {
	            var data = response.segmentInfos;
	            for ( var i = 0; i < data.length; i++) {
	               element = data[i].duration;
	               $('#segmentTable').dataTable().fnUpdate(element,i,3);
	            };
	         }
	      });
	   };
</script>
</head>
<body>
   <jsp:include page="../common/header.jsp" />
   <jsp:include page="../common/menu.jsp" />
   <div id="page" class="well small-well">
   		<h3 style="border-bottom: 1px solid #ddd; margin-bottom: 20px;">    
				Manage segment
		</h3>  
      <div class="post">
      <div class=row>
      	<table class="pull-right row"> 
            <tr>
               <td style="font-size: 14px;font-weight: normal;vertical-align: middle">Valid Date :</td>
               <td><input id="validDateSelect" type="text" value="" readonly/>
               </td>
            </tr>
         </table>
      </div>
         <table id="segmentTable"  align="center" class="table table-striped table-bordered dataTable" style="margin-top:20px;background-color: #fff">
            <thead>
               <tr>
                  <th>ID</th>
                  <th>Start At</th>
                  <th>End At</th>
                  <th>Duration</th>
                  <th></th>
               </tr>
            </thead>
            <tbody>
               <s:iterator value="segmentInfos">
                  <tr id="segment_<s:property value='id'/>">
                     <td><s:property value="id" /></td>
                     <td><s:property value="startAtName" /></td>
                     <td><s:property value="endAtName" /></td>
                     <td><s:property value="duration" /></td>
                     <td style="width: 6%"><input class="btn btn-danger btn-small" type="button" value="Edit"
                        onclick='javascript: changeDuration(<s:property value='id'/>)' /></td>
                  </tr>
               </s:iterator>
            </tbody>
         </table>
      </div>
   </div>
   <!-- Modal edit Duration Dialog -->
   <div id="editDurationDialog" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
      aria-hidden="true">
      <div class="modal-header">
         <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
         <h3 id="editSegmentDialogLabel">Edit Segment</h3>
      </div>
      <div class="modal-body">
         <form id="editSegmentForm">
            <input type="hidden" name="segmentId" value="" id="segmentId" />
            <table>
               <tr>
                  <td>Valid from </td>
                  <td><%-- <div id="validFromDiv" class="input-append date form_datetime" data-date="">
                        <input id="validFromTime" size="16" type="text" value="" readonly name="validFromTime">
                        <span class="add-on"><i class="icon-calendar"></i></span>
                     </div> --%>
                  <input id="validFromTime" type="text" value="" readonly name="validFromTime">   
                  </td>
               </tr>
               <tr>
                  <td>Duration (hh:mm)</td>
                  <td><input type="text" id="duration" name="duration" value="01:00"></td>
               </tr>
            </table>
            <label id="preUpdateDuration"></label>
         </form>
      </div>
      <div class="modal-footer">
         <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
         <button id="editSegmentDialogOk" class="btn btn-danger">Save</button>
      </div>
   </div>
   <jsp:include page="../common/footer.jsp" />
</body>
</html>