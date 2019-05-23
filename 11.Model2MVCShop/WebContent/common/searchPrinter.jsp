<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="row">
	<form class="form-inline" name="detailForm">
	
	<div class="col-md-2">
		<c:if test="${!empty hideList }">
			<div class="form-group">
				<select class="form-control hideOption">
						<c:forEach var="i" begin="0" end="${fn:length(hideList)-1}">
							<option value="${i}" ${param.hiddingEmptyStock eq i?"selected='selected'":""}>${hideList[i]}</option>
						</c:forEach>
				</select>
			</div>
		</c:if>
	</div>
	
	<div class="col-md-3">
		<c:if test="${!empty sortList }">
			<div class="form-group">
				<select class="form-control sort">
					<c:forEach var="i" begin="0" end="${fn:length(sortList)-1}">
						<option value="${i}" ${search.sortCode eq i?"selected='selected'":""}>${sortList[i]}</option>
					</c:forEach>
				</select>
			</div>
		</c:if>
	</div>
		  
	<div class="col-md-2"> 
		<c:if test="${!empty searchOptionList }">
			 <div class="form-group">
			    <select class="form-control" name="searchCondition" id="searchCondition">
					<c:forEach var="i" begin="0" end="${fn:length(searchOptionList)-1}">
						<option value="${i}" ${(!empty search.searchKeyword && search.searchCondition eq i)?"selected='selected'":""}>${searchOptionList[i]}</option>
					</c:forEach>	
				</select>
			 </div>
		 </c:if>
	</div>
	
	<div class="col-md-4 text-right">
		<c:if test="${!empty searchOptionList }">
			<div class="form-group">
			  <label class="sr-only" for="searchKeyword">검색어</label>
			  <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어"
			  			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
			</div>
		</c:if>
	</div>
	
	<div class="col-md-1">
		<c:if test="${!empty searchOptionList }">
			<button type="button" class="btn btn-default">검색</button>
		</c:if>
	</div>
	
	</form>
</div>

<br/>
