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
   	
	   	accounting.settings = {
   			currency : {
   				symbol : ".000", // default currency symbol is '$'
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
       
       $('#validDateSelect').val(now);
       $("#validDateSelect").change(function() {
    	   getSegmentDuration($("#validDateSelect").val());
    	   getPrice($('#busType').val(), $("#validDateSelect").val());
        });
       
		$('#busType').bind('change', function() {
			var busType = $('#busType').val();
			var date = $('#validDateSelect').val();
			getPrice(busType, date);
			validateBusType();
		});
       
       $('#validFromTime').datepicker({
             dateFormat : 'dd/mm/yy',
             minDate : '0',
             maxDate : '+3M',
             regional : 'vi'
          });
          $('#validFromTime').val(now);
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
                  var url = $('#contextPath').val()
                  + "/segment/list.html";
                  window.location = url;
                  $("#addResult").html(response.message);
               }
	        });
		});
		
		var busType = $('#busType').val();
		getPrice(busType, $('#validDateSelect').val());
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
               $('#segmentTable').dataTable().fnUpdate(element,i,2);
            };
         }
      });
   };
   
	function getPrice(busType, date) {
		var info = {};
		info['busType'] = busType;
		info['validDate'] = date;
		$.ajax({
			type : "POST",
			url : 'getPrice.html',
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			data : {data : JSON.stringify(info)},
			success : function(response) {
				var data = response.tariffInfos;
				for ( var i = 0; i < data.length; i++) {
					element = data[i];
					$('#segmentTable').dataTable().fnUpdate(accounting.formatMoney(element.fare),i,3);
				};
			}
		});
	};

	var segments = [];
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
      <p id="addResult" style="color: red"></p>
      	<table class="pull-right row"> 
            <tr>
               <td><s:select id="busType" list="busTypeBeans" name="busTypeBeans" listKey="id"
                           listValue="name" /></td>
               <td style="font-size: 14px;font-weight: normal;vertical-align: middle">Valid Date :</td>
               <td><input id="validDateSelect" type="text" value="" readonly/>
               </td>
            </tr>
         </table>
      </div>
         <table id="segmentTable"  align="center" class="table table-striped table-bordered dataTable" style="margin-top:20px;background-color: #fff">
            <thead>
               <tr>
                  <th style="text-align: center">Start At</th>
                  <th style="text-align: center">End At</th>
                  <th style="text-align: center">Duration</th>
                  <th style="text-align: center">Price (VNĐ)</th>
                  <th></th>
               </tr>
            </thead>
            <tbody>
               <s:iterator value="segmentInfos">
                  <tr id="segment_<s:property value='id'/>">
                     <td><s:property value="startAtName" /></td>
                     <td><s:property value="endAtName" /></td>
                     <td style="text-align: center;"><s:property value="duration"/></td>
                     <td style="padding-right:100px; text-align: right"><s:property value="price"/></td>
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
                  <td>
                     <input id="validFromTime" type="text" value="" readonly name="validFromTime">   
                  </td>
               </tr>
               <tr>
                  <td>Duration (hh:mm)</td>
                  <td><input type="text" id="duration" name="duration" value="01:00"></td>
               </tr>
            </table>
            <div><input type="checkbox" id="addPriceRevRoute" name="addPriceRevRoute" style="margin-top: -4px;"/> Add price for reverse route too?</div>
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