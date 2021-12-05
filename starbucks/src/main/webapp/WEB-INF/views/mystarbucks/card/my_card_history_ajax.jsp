<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<tbody>
	<c:if test="${fn:length(ucdlist) eq 0}">
		<tr>
			<td colspan="3">해당 카드 내역이 없습니다.</td>
		</tr>
	</c:if>
	<c:forEach var="ucdlist" items="${ucdlist}" varStatus="ucdCount">
		<fmt:parseDate value="${ucdlist.getUcdDate()}" var="date" pattern="yyyy-MM-dd" />
		
		<tr>
			<td><fmt:formatDate value="${date}" pattern="yyyy-MM-dd" /></td>
			<td>${ucdlist.getUcdType() }</td>
			<td><fmt:formatNumber value="${ucdlist.getUcdDeposit() }" pattern="#,###" />원</td> 
		</tr>
	</c:forEach>

</tbody>
<tfoot>
	<tr>
		<td colspan="3">
			<div class="card_history_pager">${pager }</div>
		</td>
	</tr>
	
</tfoot>
