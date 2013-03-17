<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<s:if test="#srStatus.even == true">
	<tr style="background: #CCCCCC" class="tripDetails">
</s:if>
<s:else>
	<tr class="tripDetails">
</s:else>
<td align="center" ><s:date name="departureTime"
		format="HH:mm" /></td>
<%-- <s:set name="deptDate" value="<s:date name="departureTime" format="dd-MM-yyyy"/>"/>
<s:set name="arrDate" value="<s:date name="arrivalTime" format="dd-MM-yyyy"/>"/>
<s:if test="%{#deptDate == #arrDate}">
	<td align="center" rowspan=2>
				   <s:date name="arrivalTime" format="HH:mm" /></td>
</s:if>
<s:else> --%>
<td align="center"><s:date name="arrivalTime" format="dd-MM-yyyy" /><br/>
				   <s:date name="arrivalTime" format="HH:mm" /></td>
<%-- </s:else> --%>				   
<td align="center" ><a href="#trip-details" role="button"
	data-toggle="modal" class="trip-details">Chi tiết</a></td>
<td><s:text name="format.number">
		<s:property value="fare" />
	</s:text>&nbsp;VND&nbsp;</td>
<td align="center" class="out-journey-rdo" ><s:if test="#srStatus.first == true">
		<input title="Chọn chuyến này" type="radio" name="out_journey"
			id="out_journey" class="out_journey" checked />
	</s:if>
	<s:else>
		<input title="Chọn chuyến này" type="radio" name="out_journey"
			id="out_journey" />
	</s:else> <input type="hidden" class="out_status" value="${sr.busStatusId}" />
	<input type="hidden" class="out_deptTime" value="${sr.departureTime}" />
	<input type="hidden" class="out_arrTime" value="${sr.arrivalTime}" />
	<input type="hidden" class="out_fare" value="${sr.fare}" /></td>
</tr>