<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC 
	"-//W3C//DTD XHTML 1.1 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="s" uri="/struts-tags"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Test page</title>
<jsp:include page="../common/xheader.jsp" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/styles/trip/jquery.dataTables.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/styles/bootstrap.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/styles/pay.css">
<script src="<%=request.getContextPath()%>/js/jquery.dataTables.min.js"></script>
<script src="<%=request.getContextPath()%>/js/bootstrap.min.js"></script>
<script src="<%=request.getContextPath()%>/js/rsv/rsv01010.js"></script>
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<jsp:include page="../common/dataTableText.jsp" />
	<form method="post">
		<input type="hidden" name="reservationId" value="" />
		<div class="container">
			<table id="reservationList">
				<thead>
					<tr>
						<th class="index"><s:text name="index" /></th>
						<th class="subroute"><s:text name="subroute" /></th>
						<th class="book_time"><s:text name="book_time" /></th>
						<th class="book_time_mili"><s:text name="book_time_mili" /></th>
						<th class="departure_date"><s:text name="departure_date" /></th>
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
							<td><s:property value="%{departureDate}"/></td>
							<td>
								<a id="<s:property value="%{'details_' + id}"/>" href="#">
									<s:text name="details" />
								</a>
							</td>
							<td>
								<s:if test="%{status == 'paid'}" >
									<a id="<s:property value="%{'cancel_' + id}"/>" href="#">
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
			<p id="cancelConfirmMessage"></p>
		</div>
		<div class="modal-footer">
			<button class="btn close-model-btn"><s:text name="button.no" /></button>
			<button id="btnCancel" class="btn btn-primary"><s:text name="button.yes" /></button>
		</div>
	</div>
</body>
</html>
