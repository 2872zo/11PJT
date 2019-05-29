<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<div class="container">    
	<div class="page-header">
        <h1>${list[0]}</h1>
	</div>
	
	<c:forEach var="list" items="${list}" begin="1">
		<c:set var="splitList" value="${fn:split(list,',')}" />
		<div class="row">
			<div class="col-xs-4 col-md-2"><strong>${splitList[0]}</strong></div>
			<div class="col-xs-8 col-md-4">${splitList[1]}</div>
		</div>
		<hr/>
	</c:forEach>
	
</div>