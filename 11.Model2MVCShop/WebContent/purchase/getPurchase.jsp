<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<html>
<head>
<!--  ///////////////////////// ���� �̿��� ���� lib START ////////////////////////// -->
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

<!--  CSS �߰� : ���ٿ� ȭ�� ������ ���� �ذ� :  �ּ�ó�� ��, �� Ȯ��-->
<style>
       body {
           padding-top : 70px;
       }
</style>
<!--  ///////////////////////// ���� �̿��� ���� lib END ////////////////////////// -->

<link rel="stylesheet" href="/css/admin.css" type="text/css">


<title>���Ż���ȸ</title>

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
			<button type="button" class="btn btn-primary" id="cancel" >���� ���</button>
			<button type="button" class="btn btn-primary" id="update" >�� ��</button>
		</c:if>
		<button type="button" class="btn btn-primary" id="goBack" >Ȯ &nbsp;��</button>
	</div>
					
</body>
</html>