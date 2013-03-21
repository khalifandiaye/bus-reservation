<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>

<tr class="tripDetails row">
<td class="cell"><s:date name="departureTime"
		format="HH:mm" /></td>
<%-- <s:set name="deptDate" value="<s:date name="departureTime" format="dd-MM-yyyy"/>"/>
<s:set name="arrDate" value="<s:date name="arrivalTime" format="dd-MM-yyyy"/>"/>
<s:if test="%{#deptDate == #arrDate}">
	<td align="center" rowspan=2>
				   <s:date name="arrivalTime" format="HH:mm" /></td>
</s:if>
<s:else> --%>
<td class="cell"><s:date name="arrivalTime" format="dd-MM" /><br/>
				   <s:date name="arrivalTime" format="HH:mm" /></td>
<%-- </s:else> --%>				   
<td class="cell"><a href="#trip-details" role="button"
	data-toggle="modal" class="trip-details return">Chi tiết</a></td>
<td class="cell">
		<s:property value="getText('{0,number,#,##0}',{fare})" />
	&nbsp;VND&nbsp;</td>
<td class="cell rtn-journey-rdo">
		<input title="Chọn chuyến này" type="radio" name="rtn_journey"
			id="rtn_journey" />
	<input type="hidden" class="rtn_status" value="${sr.busStatusId}" />
	<input type="hidden" class="rtn_deptTime" value="${sr.departureTime}" />
	<input type="hidden" class="rtn_arrTime" value="${sr.arrivalTime}" />
	<input type="hidden" class="rtn_fare" value="${sr.fare}" /></td>
</tr>