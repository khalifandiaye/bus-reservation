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
<link href="<%=request.getContextPath()%>/styles/pay.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/index.js"></script>
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<form method="post"
		action="<%=request.getContextPath()%>/pay/pay-paypal">
		<div class="container">
			<table>
				<thead>
					<tr>
						<th><s:text name="No" /></th>
						<th><s:text name="subroute" /></th>
						<th><s:text name="departure_date" /></th>
						<th><s:text name="details" /></th>
						<th><s:text name="cancel" /></th>
					</tr>
				</thead>
				<tbody>
					<s:if test="%{reservationList == null || reservationList.size == 0}">
						<tr>
							<td colspan="5"><s:text name="msg_noReservations" /></td>
						</tr>
					</s:if>
					<s:else>
						<s:iterator	value="reservationList" status="status">
						<tr>
							<td><s:property value="%{#status.count}"/></td>
							<td><s:property value="%{subRouteName}"/></td>
							<td><s:property value="%{departureDate}"/></td>
							<td><a id="<s:property value="%{'details_' + id}"/>" href="#"><s:text name="details" /></a></td>
							<td>
								<s:if test="%{status == 'paid'}" ><a id="<s:property value="%{'cancel_' + id}"/>" href="#"><s:text name="cancel" /></a></s:if>
								<s:elseif test="%{status == 'unpaid'}" ><s:text name="unpaid" /></s:elseif>
								<s:elseif test="%{status == 'departed'}" ><s:text name="departed" /></s:elseif>
								<s:elseif test="%{status == 'cancelled'}" ><a id="<s:property value="%{'cancel_' + id}"/>" href="#"><s:text name="cancelled" /></a></s:elseif>
								<s:elseif test="%{status == 'moved'}" ><s:text name="moved" /></s:elseif>
								<s:elseif test="%{status == 'deleted'}" ><s:text name="cancelled" /></s:elseif>
								<s:elseif test="%{status == 'refunded'}" ><s:text name="cancelled" /></s:elseif>
							</td>
						</tr>
						</s:iterator>
					</s:else>
				</tbody>
			</table>
		</div>
	</form>
	<jsp:include page="../common/footer.jsp" />
</body>
</html>
