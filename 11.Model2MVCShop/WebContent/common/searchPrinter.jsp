<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="row">
	<div class="col-md-6 text-left"> 
	</div>
	
	<div class="col-md-6 text-right">
	    <form class="form-inline" name="detailForm">
	    
		  <div class="form-group">
		    <select class="form-control" name="searchCondition" id="searchCondition">
				<c:forEach var="i" begin="0" end="${fn:length(searchOptionList)-1}">
					<option value="${i}" ${(!empty search.searchKeyword && search.searchCondition eq i)?"selected='selected'":""}>${searchOptionList[i]}</option>
				</c:forEach>	
			</select>
		  </div>
		  
		  <div class="form-group">
		    <label class="sr-only" for="searchKeyword">검색어</label>
		    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어"
		    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
		  </div>
		  
		  <button type="button" class="btn btn-default">검색</button>
		  
		</form>
	</div>
</div>

<br/>
