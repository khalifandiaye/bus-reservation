<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC 
	"-//W3C//DTD XHTML 1.1 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="s" uri="/struts-tags"%>
<s:if test="%{model != null}">
<h3>
	<s:text name="label.routeFromTo" >
		<s:param value="%{model.from}" />
		<s:param value="%{model.to}" />
	</s:text>
</h3>
<s:iterator value="model.segmentTicketList">
<div style="width: 50%; float: left;">
	<h4>
		<s:text name="label.segmentFromTo" >
			<s:param value="%{from}" />
			<s:param value="%{to}" />
		</s:text>
	</h4>
	<table>
		<thead>
			<tr>
				<th><s:text name="label.reservationCode" /></th>
				<th><s:text name="label.seatNumbers" /></th>
			</tr>
		</thead>
		<tbody>
			<s:iterator value="%{ticketList}">
				<tr>
					<td><s:property value="%{code}"/></td>
					<td><s:property value="%{seats}"/></td>
				</tr>
			</s:iterator>
		</tbody>
	</table>
</div>
</s:iterator>
</s:if>
<s:else>
<h3>
	<s:text name="label.noTicket" />
</h3>
</s:else>