<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


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

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/css/admin.css" type="text/css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script type="text/javascript">
$(function(){
	$("#cancel").on("click",function(){
		cancel();
	});
	
	$("#update").on("click",function(){
		fncUpdateProduct();
	});
	
	$("#datepicker").datepicker();
	$( "#datepicker" ).datepicker( "option", "dateFormat", "yy-mm-dd" );
});

function fncUpdateProduct(){
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
		
	$("form").attr("action","/product/updateProduct");
	$("form").attr("method","POST");
	$("form").submit();
}

function cancel(){
	history.go(-1);
}
</script>

<c:if test="${!empty user}"><c:import url="/layout/toolbar.jsp"></c:import></c:if>
<c:if test="${empty user}"><c:import url="/layout/toolbar2.jsp"></c:import></c:if>

<title>상품정보수정</title>
</head>

<body>
	<div class="container">
		<h1 class="bg-primary text-center">상 품 수 정</h1>
		
		<form class="form-horizontal" enctype="multipart/form-data">

		<input type="hidden" name="prodNo" value="${product.prodNo}"/>
		
			<div class="form-group">
			    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">상 품 명</label>
			    <div class="col-sm-4">
				    <input type="text" class="form-control" id="prodName" name="prodName" value="${product.prodName}"/>
			    </div>
		  	</div>
		  	
		  	<div class="form-group">
			    <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">상 세 정 보</label>
			    <div class="col-sm-4">
				    <input type="text" class="form-control" id="prodDetail" name="prodDetail" value="${product.prodDetail}"/>
			    </div>
		  	</div>
		  	
		  	<div class="form-group">
			    <label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">제 조 일 자</label>
			    <div class="col-sm-4">
				    <input type="text" class="form-control" id="datepicker" name="manuDate" value="${product.manuDate}"/>
			    </div>
		  	</div>
		  	
		  	<div class="form-group">
			    <label for="price" class="col-sm-offset-1 col-sm-3 control-label">가격</label>
			    <div class="col-sm-4">
				    <input type="text" class="form-control" id="price" name="price" value="${product.price}"/>
			    </div>
		  	</div>
		  	
		  	<div class="form-group">
			    <label for="file" class="col-sm-offset-1 col-sm-3 control-label">상품 이미지</label>
			    <div class="col-sm-4">
				    <input type="file" class="form-control" id="file" name="file" value="${product.price}"/>
			    </div>
		  	</div>
		  	
		  	<div class="form-group">
			    <label for="file" class="col-sm-offset-1 col-sm-3 control-label">재 고 량</label>
			    <div class="col-sm-4">
				    <input type="text" class="form-control" id="stock" name="stock" value="${product.stock}"/>
			    </div>
		  	</div>
		  	
		  	<div class="form-group">
			    <div class="col-sm-offset-4  col-sm-4 text-center">
				    <button type="button" class="btn btn-primary" id="update">수&nbsp;정</button>
					<button type="button" class="btn btn-primary" id="cancel">취&nbsp;소</button>
			    </div>
		  </div>
		  
		</form>

	</div>
</body>
</html>