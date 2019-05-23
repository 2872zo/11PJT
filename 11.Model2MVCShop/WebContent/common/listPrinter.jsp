<%@ page contentType="text/html; charset=euc-kr" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
	var jb = jQuery.noConflict();

	jb(function(){
		jb(".ct_list_pop:nth-child(4n+6)").css("background","whitesmoke");
	});
</script>

<style>
<!--
	.table td, .table th {
  		text-align: center;
	}
-->
</style>

<div class="container">
	<div class="page-header">
        <h1>${title}</h1>
	</div>


	<c:if test="${!empty search }">
		<c:import url="../common/searchPrinter.jsp"/>
	</c:if>

	 <div class="row">
	 	<c:if test="${!empty resultPage or !empty search}">
			<tr>
				<div class="col-md-6 text-left">
					<c:if test="${!empty resultPage}">
						<th>전체 ${resultPage.totalCount} 건수, 현재 ${resultPage.currentPage} 페이지</th>
					</c:if>
				</div><!-- content count -->
				
				<div class="col-md-6 text-right">
					<c:if test="${!empty search}">
						<th align="right"> 표시 개수
							
							<select name="pageSize" id="pageSize">
								<option ${(empty search || search.pageSize eq 3)?"selected='selected'":""}>3</option>
								<option value="5"  ${(!empty search && search.pageSize eq 5)?"selected='selected'":""}>5</option>
								<option value="8"  ${(!empty search && search.pageSize eq 8)?"selected='selected'":""}>8</option>
								<option value="9"  ${(!empty search && search.pageSize eq 9)?"selected='selected'":""}>8</option>
								<option value="10" ${(!empty search && search.pageSize eq 10)?"selected='selected'":""}>10</option>
								<option value="15" ${(!empty search && search.pageSize eq 15)?"selected='selected'":""}>15</option>
							</select>
						</th>
					</c:if>
				</div><!-- page size -->
				
			</tr><!-- content count, page size -->
		</c:if>
	 	
	 	
	 	
		<table class="table table-striped table-hover" style="align-content: center; align : center">
			
		
			
			<!-- colum 출력 -->
			<c:if test="${!empty columList}">
				<thead>
					<tr>
						<!-- checkbox 출력 -->
						<c:if test="${!empty checkboxOn}">
							<th style="align : center"> 
								<input type="checkbox">
							</th>
						</c:if>
						
						<c:set var="i" value="0"/>
						<c:forEach var="columName" items="${columList}">
							<c:set var="i" value="${i+1}"/>
								<th>${columName}</th>
						</c:forEach>	
						
					</tr>
				</thead>
			</c:if>
			<!-- colum 출력 끝 -->
			
			<c:if test="${!empty param.unitList}">
				<c:set var="unitList" value="${param.unitList}"></c:set>
			</c:if>
			
			<!-- 실제 List 출력 -->
			<c:if test="${!empty unitList}">
				<tbody>
					<c:set var="i" value="0"/>
					<c:forEach var="list" items="${unitList}">
						<c:set var="i" value="${i+1}"/>
						<tr>
						
							<c:if test="${!empty checkboxOn}">
								<td align="center"> 
									<input class="listcheckbox" type="checkbox">
								</td>
							</c:if>
							
							<c:set var="j" value="0"/>
							<c:forEach begin="0" end="${fn:length(columList)-1 }">
								<td>
									<c:if test="${!empty list[j]}">
										${fn:replace(list[j],"\\n","<br/>")}
									</c:if>
								</td>
								<c:set var="j" value="${j+1}"/>
							</c:forEach>
						</tr>	
					</c:forEach>
				</tbody>
			</c:if>
			<!-- 실제 List 출력 끝 -->
		</table>
	</div><!-- row end -->
</div><!-- container end -->


