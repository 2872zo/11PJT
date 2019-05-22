<%@ page contentType="text/html; charset=euc-kr" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css" integrity="sha384-oS3vJWv+0UjzBfQzYUhtDYW+Pj2yciDJxpsK1OYPAYjqT085Qq/1cq5FLXAZQ7Ay" crossorigin="anonymous">

<div class="container">
	<div class="row">
		<h2 class="text-center">${title}</h2>
        <hr/>
	</div>
	
	<c:import url="/common/searchPrinter.jsp"></c:import>
	
    <div class="row">
    
    	<c:if test="${!empty unitList}">
		<c:forEach var="unit" items="${unitList}">
	        <div class="col-sm-6 col-md-4">
	            <div class="thumbnail">
	                <h4>
	                    ${unit.prodName}
	                    <span class="label label-info info">
	                    	<c:if test="${!empty unit.salesVolume }">
	                        <span data-toggle="tooltip" title="viewed"><b class="glyphicon glyphicon-eye-open"></b>&nbsp;${unit.salesVolume}</span>
	                        </c:if>
	                        <span data-toggle="tooltip" title="rating"><b class="glyphicon glyphicon-star"></b>&nbsp;${unit.avgRating} </span>
	                    </span>
	                </h4>
	                <div style="width: auto; height: 335px; overflow: hidden; display:flex; justify-content:center; align-items:center;">
  						<img src="/images/uploadFiles/${unit.fileName}" style="max-width: 100%; max-height: 100%; vertical-align:middle;">
					</div>
	                &nbsp;<span class="fas fa-won-sign"></span>&nbsp;${unit.price}
	                <a href="#" class="btn btn-primary col-xs-12" role="button" style="color: white">상세 보기</a>
	                <div class="clearfix"></div>
	            </div>
	        </div>
	    </c:forEach>
        </c:if>
        
    </div>
</div>