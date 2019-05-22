<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

 
<div class="container text-center">
		 
		 <nav>
		  <!-- 크기조절 :  pagination-lg pagination-sm-->
		  <ul class="pagination" >
		    
		    <!--  <<== 좌측 nav -->
		  	<c:if test="${resultPage.beginUnitPage eq 1}">
		 		<li class="disabled">
		 			<a aria-label="Previous">
			</c:if>
			<c:if test="${resultPage.beginUnitPage ne 1}">
				<li>
					<a href="#" id="prePage" aria-label="Previous">
			</c:if>
		        <span aria-hidden="true">&laquo;</span>
		      </a>
		    </li>
		    
		    <!--  중앙  -->
			<c:forEach var="i"  begin="${resultPage.beginUnitPage}" end="${resultPage.endUnitPage}" step="1">
				
				<c:if test="${ resultPage.currentPage eq i }">
					<!--  현재 page 가르킬경우 : active -->
				    <li class="active">
				    	<a>${ i }<span class="sr-only">(current)</span></a>
				    </li>
				</c:if>	
				
				<c:if test="${ resultPage.currentPage ne i}">	
					<li>
						<a href="#" class="page">${ i }</a>
					</li>
				</c:if>
			</c:forEach>
		    
		     <!--  우측 nav==>> -->
		     <c:if test="${resultPage.endUnitPage eq resultPage.maxPage}">
		  		<li class="disabled">
		  			<a aria-label="Next">
			</c:if>
			<c:if test="${resultPage.endUnitPage ne resultPage.maxPage}">
				<li>
					<a href="#" id="nextPage" aria-label="Next">
			</c:if>
		        <span aria-hidden="true">&raquo;</span>
		      </a>
		    </li>
		  </ul>
		</nav>
		
</div>
 


<div class="container">
		<nav>
		  <ul class="pager">
		  	<c:if test="${resultPage.currentPage eq 1}">
		  		<li class="disabled"><a>Previous</a></li>
			</c:if>
			<c:if test="${resultPage.currentPage ne 1}">
		  		<li><a href="#" id="Previous">Previous</a></li>
			</c:if>
			<c:if test="${resultPage.currentPage eq resultPage.maxPage}">
		  		<li class="disabled" id="Next"><a>Next</a></li>
			</c:if>
			<c:if test="${resultPage.currentPage ne resultPage.maxPage}">
		  		<li><a href="#">Next</a></li>
			</c:if>
		  </ul>
		</nav>
</div>
