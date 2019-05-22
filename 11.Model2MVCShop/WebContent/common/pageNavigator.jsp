<%@ page contentType="text/html; charset=euc-kr" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	
	
			<c:if test="${resultPage.beginUnitPage ne 1}">
				<a href="#" id="prePage">¢¸ </a>
			</c:if>
		
			<c:forEach var="i" begin="${resultPage.beginUnitPage}" end="${resultPage.endUnitPage}" step="1">
				<c:choose>
					<c:when test="${i ne resultPage.currentPage}">
						<a href="#" class="page">${i}</a>	
					</c:when>
					<c:otherwise>
						<font style="font-weight: bold">${i}</font>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		
			<c:if test="${resultPage.endUnitPage ne resultPage.maxPage}">
				<a href="#" id="nextPage">¢º </a>		
			</c:if>