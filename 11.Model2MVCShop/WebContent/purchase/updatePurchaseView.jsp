<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<html>
<head>
<link rel="stylesheet" href="/css/admin.css" type="text/css">

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

<script type="text/javascript">
$(function(){
	$("#cancel").on("click",function(){
		cancel();
	});
	
	$("#update").on("click",function(){
		cancel();
	});
	
	$("#datepicker").datepicker();
	$( "#datepicker" ).datepicker( "option", "dateFormat", "yy-mm-dd" );
});

function fncAddProduct(){
	//Form 유효성 검증
 	var name = $("input[name=prodName]").val();
	var detail = $("input[name=prodDetail]").val();
	var manuDate = $("input[name=manuDate]").val();
	var price = $("input[name=price]").val();

	if(name == null || name.length<1){
		alert("상품명은 반드시 입력하여야 합니다.");
		return;
	}
	if(detail == null || detail.length<1){
		alert("상품상세정보는 반드시 입력하여야 합니다.");
		return;
	}
	if(manuDate == null || manuDate.length<1){
		alert("제조일자는 반드시 입력하셔야 합니다.");
		return;
	}
	if(price == null || price.length<1){
		alert("가격은 반드시 입력하셔야 합니다.");
		return;
	}
		
	$("form").attr("action","/purchase/updatePurchase");
	$("form").attr("method","POST");
	$("form").submit();
}

function cancel(){
	history.go(-1);
}
<!--
function fncUpdatePurchase() {
	document.updatePurchase.submit();
}
-->
</script>
<script type="text/javascript" src="../javascript/calendar.js">
</script>

<c:if test="${!empty user}"><c:import url="/layout/toolbar.jsp"></c:import></c:if>
<c:if test="${empty user}"><c:import url="/layout/toolbar2.jsp"></c:import></c:if>

<title>구매정보 수정</title>

</head>

<body>

	<div class="container">
		
		<div class="page-header">
	       <h3 class=" text-info">구매정보수정</h3>
	    </div>
		
		<form class="form-horizontal">
		
			<input type="hidden" name="prodNo" value="${purchase.purchaseProd.prodNo}">
			<input type="hidden" name="tranNo" value="${purchase.tranNo}">
			
			<div class="form-group">
			    <label class="col-sm-offset-1 col-sm-3 control-label">구매자 아이디</label>
			    <div class="col-sm-4">
			    	<input type="text" id="userId" name="userId" class="form-control" value="${purchase.buyer.userId}"/>
				</div>
			</div>
			
			<hr/>
		
			<div class="form-group">
			    <label class="col-sm-offset-1 col-sm-3 control-label">구매 수량</label>
			    <div class="col-sm-4">
			    	<select name="Quantity" class="form-control">
						<c:forEach var="i" begin="1" end="${product.stock}">
							<option value="${i}">${i}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			
			<hr/>
			
			<div class="form-group">
			    <label class="col-sm-offset-1 col-sm-3 control-label">구매 방법</label>
			    <div class="col-sm-4">
			    	<select name="paymentOption" class="form-control">
						<option value="1" ${purchase.paymentOption eq '0'?"selected='selected'":""}>현금구매</option>
						<option value="2" ${purchase.paymentOption eq '1'?"selected='selected'":""}>신용구매</option>
					</select>
				</div>
			</div>
			
			<hr/>
			
			<div class="form-group">
			    <label for="receiverName" class="col-sm-offset-1 col-sm-3 control-label">구매자 이름</label>
			    <div class="col-sm-4">
			    	<input type="text" id="receiverName" name="receiverName" class="form-control" value="${purchase.receiverName}"/>
				</div>
			</div>
			
			<hr/>
			
			<div class="form-group">
			    <label for="receiverPhone" class="col-sm-offset-1 col-sm-3 control-label">구매자 연락처</label>
			    <div class="col-sm-4">
			    	<input 	type="text" id="receiverPhone" name="receiverPhone" class="form-control" value="${purchase.receiverPhone}"/>
				</div>
			</div>
			
			<hr/>
			
			<div class="form-group">
			    <label class="col-sm-offset-1 col-sm-3 control-label">구매자 주소</label>
			    <div class="col-sm-4">
			    	<input 	type="text" class="dlvyAddr form-control" name="zonecode" 	   value="${purchase.zoneCode}" 		placeholder="우편번호" readonly="readonly"/>
					<input 	type="text" class="dlvyAddr form-control" name="firstAddress"  value="${purchase.firstAddress}" 	placeholder="기본주소" readonly="readonly"/>
					<input 	type="text" class="dlvyAddr form-control" name="secondAddress" value="${purchase.secondAddress}" 	placeholder="상세주소"/>
				</div>
			</div>
			
			<hr/>
			
			<div class="form-group">
			    <label for="dlvyRequest" class="col-sm-offset-1 col-sm-3 control-label">요청사항</label>
			    <div class="col-sm-4">
			    	<input type="text" name="dlvyRequest" class="form-control" value="${purchase.dlvyRequest}"/>
				</div>
			</div>
			
			<hr/>
			
			<div class="form-group">
			    <label for="dlvyRequest" class="col-sm-offset-1 col-sm-3 control-label">배송희망일자</label>
			    <div class="col-sm-4">
			    	<input type="text" readonly="readonly" id="datepicker" name="dlvyDate" class="form-control" value="${purchase.dlvyDate}"/>
				</div>
			</div>
			
			<hr/>
			
			<div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button class="btn btn-primary" id="update">수정</button>
			  <button class="btn btn-primary" id="cancel">취 소</button>
		    </div>
		  </div>
			
		</form>
		
	</div>

</body>
</html>