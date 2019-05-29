<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<html>
<head>
<!--  ///////////////////////// 툴바 이용을 위한 lib START ////////////////////////// -->
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
<!--   jQuery , Bootstrap CDN  -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

<!-- Bootstrap Dropdown Hover CSS -->
  <link href="/css/animate.min.css" rel="stylesheet">
  <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
  
   <!-- Bootstrap Dropdown Hover JS -->
  <script src="/javascript/bootstrap-dropdownhover.min.js"></script>

<!--  CSS 추가 : 툴바에 화면 가리는 현상 해결 :  주석처리 전, 후 확인-->
<style>
       body {
           padding-top : 70px;
       }
</style>
<!--  ///////////////////////// 툴바 이용을 위한 lib END ////////////////////////// -->

<link rel="stylesheet" href="/css/admin.css" type="text/css">


<title>구매상세조회</title>

<c:if test="${!empty user}"><c:import url="/layout/toolbar.jsp"></c:import></c:if>
<c:if test="${empty user}"><c:import url="/layout/toolbar2.jsp"></c:import></c:if>

</head>

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
	$(function(){
		$("#goBack").on("click",function(){
			history.go(-1);
		});
		
		$("#update").on("click",function(){
			location.href ="/purchase/updatePurchaseView?tranNo=${purchase.tranNo}";
		});
		
		$("#cancel").on("click",function(){
			location.href ="/purchase/cancelPurchase?tranNo=${purchase.tranNo}";
		});
		
		
		
	});
</script>
<body bgcolor="#ffffff" text="#000000">

<c:import url="/common/getDetail.jsp"/>

	<div class="container">
		<c:if test="${purchase.tranCode eq '1'}">
			<button type="button" class="btn btn-primary" id="cancel" >구매 취소</button>
			<button type="button" class="btn btn-primary" id="update" >수 정</button>
		</c:if>
		<button type="button" class="btn btn-primary" id="goBack" >확 &nbsp;인</button>
	</div>
					
</body>
</html>