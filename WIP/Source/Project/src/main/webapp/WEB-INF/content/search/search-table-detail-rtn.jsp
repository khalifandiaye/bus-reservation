<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>

<tr class="tripDetails row">
<td class="cell"><s:date name="departureTime"
		format="HH:mm" /></td>
<s:set name="deptDate" value="%{getText('{0,date,yyyy/MM/dd}',{departureTime})}"/>
<s:set name="arrDate" value="%{getText('{0,date,yyyy/MM/dd}',{arrivalTime})}"/>
<s:if test="%{#deptDate == #arrDate}">
	<td align="center">
				   <s:date name="arrivalTime" format="HH:mm" /></td>
</s:if>
<s:else>
<td class="cell"><s:date name="arrivalTime" format="dd-MM" /><br/>
				   <s:date name="arrivalTime" format="HH:mm" /></td>
</s:else>				   
<td class="cell"><a href="#trip-details" role="button"
	data-toggle="modal" class="trip-details return">Xem</a></td>
<td class="cell">
		<strong><s:property value="getText('{0,number,#,##0}',{fare})" />,000</strong>
		<s:if test="%{#pssgrNo > 1}"><br/><span style="font-size:10pt"><s:property value="getText('{0,number,#,##0}',{fare/passengerNo})" />,000/1 người</span></s:if>
	</td>
<td class="cell">
	<s:property value="remainedSeats"/>
</td>
<td class="cell rtn-journey-rdo">
		<input class="" title="Chọn chuyến này" type="checkbox" name="rtn_journey"
			id="rtn_journey" class="chb-ret"/>
	<input type="hidden" class="rtn_status" value="${sr.busStatusId}" />
	<input type="hidden" class="rtn_deptTime" value="${sr.departureTime}" />
	<input type="hidden" class="rtn_arrTime" value="${sr.arrivalTime}" />
	<input type="hidden" class="rtn_fare" value="${sr.fare}" />
	<s:hidden id="routeId" value="%{route}" /></td>
</tr>