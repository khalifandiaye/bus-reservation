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
<script
   src="<%=request.getContextPath()%>/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript">
   $(document).ready(
         function() {
            var oTable = $('#segmentTable').dataTable({
            	"bSort" : false
            });

            $('input[data-edit]').click(function() {
               var tripId = this.dataset['edit'];
            });

            $('input.btn-primary').bind('click', function(){
               var url = $('#contextPath').val() + "/route/list.html";
               window.location = url;
            });
         });
</script>
<style type="text/css">
.dataTables_filter {
   display: none;
}

.dataTables_length {
   display: none;
}

</style>
</head>
<body>
   <jsp:include page="../common/header.jsp" />
   <jsp:include page="../common/menu.jsp" />
   <div id="page">
      <div class="post" style="margin: 0px auto; width: 95%;">
         <form action="insertNewTrip" method="post">
            <div style="height: 45px; margin-left: 1%;">
            </div>
            <h3><s:property value="segmentBeans[0].routeDetails.route.name" /></h3>
            <table id="segmentTable">
               <thead>
                  <tr>
                     <th>Name</th>
                     <th>Travel Time</th>
                  </tr>
               </thead>
               <tbody>
                  <s:iterator value="segmentBeans">
                     <tr id="trip_<s:property value='id'/>">
                        <td><s:property value="startAt.city.name" /> - <s:property value="endAt.city.name" /></td>
                        <td><s:property value="travelTime" /></td>
                     </tr>
                  </s:iterator>
               </tbody>
            </table>
            </br>
            <input class="btn btn-primary" type="button" value="Return to Route List" />
         </form>
      </div>
   </div>

   <jsp:include page="../common/footer.jsp" />
</body>
</html>
