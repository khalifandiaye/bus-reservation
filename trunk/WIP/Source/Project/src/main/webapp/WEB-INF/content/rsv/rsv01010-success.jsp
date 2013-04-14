<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC 
	"-//W3C//DTD XHTML 1.1 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="s" uri="/struts-tags"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><s:text name="title.rsv01010" /></title>
<jsp:include page="../common/xheader.jsp" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/styles/custom-data-table.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/styles/pay.css">
<script src="<%=request.getContextPath()%>/js/jquery.dataTables.min.js"></script>
<script src="<%=request.getContextPath()%>/js/common/custom-data-table.js"></script>
<script src="<%=request.getContextPath()%>/js/rsv/rsv01010.js"></script>
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<jsp:include page="../common/dataTableText.jsp" />
	<form method="post">
		<input type="hidden" name="reservationId" value="" />
		<div class="container">
		<div class="well">
			<h3 style="border-bottom: 1px solid #ddd; margin-bottom: 20px;">    
				Vé của tôi  
			</h3>  
			<table id="reservationList" class="table table-striped table-bordered dataTable" style="margin-top:20px;background-color: #fff">
				<thead>
					<tr> 
						<th class="index"><s:text name="index" /></th>
						<th class="subroute"><s:text name="subroute" /></th>
						<th class="book_time"><s:text name="book_time" /></th>
						<th class="book_time_mili"><s:text name="book_time_mili" /></th>
						<th class="departure_date"><s:text name="reservation.departureDate" /></th>
						<th class="details"><s:text name="details" /></th>
						<th class="status"><s:text name="cancel" /></th>
					</tr>
				</thead>
				<tbody>
					<s:if test="%{reservationList == null || reservationList.size == 0}">
					</s:if>
					<s:else>
						<s:iterator	value="reservationList" status="status">
						<tr>
							<td><s:property value="%{#status.count}"/></td>
							<td><s:property value="%{subRouteName}"/></td>
							<td><s:property value="%{bookTime}"/></td>
							<td><s:property value="%{bookTimeInMilisec}"/></td>
							<td><s:property value="%{departureDateStr}"/></td>
							<td>
								<a id="<s:property value="%{'details_' + id}"/>" href="#">
									<s:text name="details" />
								</a>
							</td>
							<td>
								<s:if test="%{status == 'active'}" >
									<a id="<s:property value="%{'cancel_' + ticketId}"/>" href="#">
										<s:text name="cancel" />
									</a>
								</s:if>
								<s:else ><s:text name="%{status}" /></s:else>
							</td>
						</tr>
						</s:iterator>
					</s:else>
				</tbody>
			</table>
		</div>
		</div>
	</form>
	<jsp:include page="../common/footer.jsp" />
	<!-- Cancel modal -->
	<div id="cancelModal" class="modal hide fade">
		<input type="hidden" name="cancelReservationId" />
		<div class="modal-header">
			<button type="button" class="close close-model-btn">×</button>
			<h3 id="myModalLabel"><s:text name="header.cancelReservation" /></h3>
		</div>
		<div class="modal-body">
			<p id="cancelErrorMessage" class="error"></p>
			<p id="cancelConfirmMessage"></p>
		</div>
		<div class="modal-footer">
			<button id="btnClose" class="btn close-model-btn btn-primary hidden"><s:text name="button.close" /></button>
			<button id="btnNo" class="btn close-model-btn"><s:text name="button.close" /></button>
			<button id="btnCancel" class="btn btn-danger"><s:text name="cancel" /></button>
		</div>
	</div>
</body>
</html>
