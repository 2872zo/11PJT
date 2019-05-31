<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java"%>
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

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
       
    .star-rating { width:79px; }
	.star-rating,.star-rating span { display:inline-block; height:13px; overflow:hidden; background:url(/images/star.png)no-repeat; }
	.star-rating span{ background-position:left bottom; line-height:0; vertical-align:top; }
</style>
<!--  ///////////////////////// 툴바 이용을 위한 lib END ////////////////////////// -->
<link href="/css/detail.css" rel="stylesheet">
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Open+Sans:400,700" rel="stylesheet">

<script src="../javascript/CommonScript.js"></script>
<script type="text/javascript">
	function fncGetAddPurchaseView(){
		$("input[name=prodNo]").val(${product.prodNo});
		$("input[name=prodName]").val("${product.prodName}");
		$("input[name=prodDetail]").val("${product.prodDetail}");
		$("input[name=manuDate]").val(${product.manuDate});
		$("input[name=price]").val(${product.price});
		
		$("form").attr("method","POST").attr("action","/purchase/addPurchaseView").submit();
	}
	
	function addCart(obj){
		$.ajax(
				{
					url : "/purchase/json/addCart/"+obj,
					data : JSON.stringify(obj),
					dataType : "json",
					success : function(a) {
						if(a==true){
							alert("장바구니에 추가되었습니다.");
						}
					},
					error : function(a,b,c){
						alert(a);
						alert(b);
						alert(c);
					}
				}
		);
	}
	
	$(function(){
		$("button:contains('buy')").on("click",function(){
			fncGetAddPurchaseView();
		});
		
		$("button:contains('add to cart')").on("click",function(){
			var prodNo = ${product.prodNo};
			var userId = "${user.userId}";
			GetData("cart","user_id","prod_no",userId,function(output){
// 				alert("output : " + output + " " + typeof(output));
// 				alert(output.indexOf(prodNo));
				if(output.indexOf(prodNo) == -1){
					addCart(prodNo);		
				}else{
					alert("장바구니에 같은 상품이 존재합니다.");
				}
			});
			
		});
		
		
		$("#updateProduct").on("click",function(){
			location.href ="/product/updateProductView?prodNo=${product.prodNo}";
		});
		
		$("#deleteProduct").on("click",function(){
			if(confirm("삭제하시겠습니까?")==true){
				location.href ="/product/deleteProduct?prodNo=${product.prodNo}";
			}
		});
		
		<%---------- 리뷰출력 ----------%>
		$(".review table").removeClass("table-striped");
		$("div tr:nth-child(2n+1)").addClass("accordion");
		$("div tr:nth-child(2n) td").not($("div tr:nth-child(2n) td:nth-child(4n+1)")).remove();
		$("div tr:nth-child(2n) td").attr("colspan","4");
		
		$(".review tr:not(.accordion)").hide();
		
		$(".review tr:nth-child(2n+1)").click(function(){
		      $(this).next("tr").fadeToggle(500);
		  }).eq(0).trigger('click');
		<%---------- 리뷰출력 끝 ----------%>
		
		$("#login").on("click",function(){
			location.href="/user/loginView.jsp";
		});
	});
	
	
</script>
<head>
	<link rel="stylesheet" href="/css/admin.css" type="text/css">
	
	<c:if test="${!empty user}"> <c:import url="/layout/toolbar.jsp">  </c:import></c:if>
	<c:if test="${empty user}">	 <c:import url="/layout/toolbar2.jsp"> </c:import></c:if>
	
	<title>상품상세조회</title>
</head>
<body bgcolor="#ffffff" text="#000000">

<form name="detailForm">
	<input type="hidden" name="prodNo" id="prodNo">
	<input type="hidden" name="prodName" id="prodName">
	<input type="hidden" name="prodDetail" id="prodDetail">
	<input type="hidden" name="manuDate" id="manuDate">
	<input type="hidden" name="price" id="price">
	
	<%----------------------------- 상세 정보 출력 --------------------------------------%>
	<div class="container">
		<div class="card">
			<div class="container-fliud">
				<div class="wrapper row">
					<div class="preview col-md-6">
						
						<div class="preview-pic tab-content">
						  <c:set var="i" value="0"/>
						  <c:forEach items="${map.fileNames}" var="fileName" begin="0">
						  	<c:if test="${i eq 0}">	
						  	  <div class="tab-pane active" id="pic-${i}"><img src="${fileName}" onerror="this.src='/images/uploadFiles/error_temp_Image.png'"/></div>
						  	</c:if>
						  	<c:if test="${i ne 0}">
						  	  <div class="tab-pane" id="pic-${i}"><img src="${fileName}" onerror="this.src='/images/uploadFiles/error_temp_Image.png'"/></div>
						  	</c:if>
						  	<c:set var="i" value="${i+1}"/>
						  </c:forEach>
						</div>
						
						<ul class="preview-thumbnail nav nav-tabs">
						  <c:set var="i" value="0"/>
						  <c:forEach items="${map.fileNames}" var="fileName">
						  	<c:if test="${i eq 0 }">
						  	  <li class="active"><a data-target="#pic-${i}" data-toggle="tab"><img src="${fileName}" onerror="this.src='/images/uploadFiles/error_temp_Image.png'"/></a></li>
						  	</c:if>
						  	<c:if test="${i ne 0}">
						  	  <li><a data-target="#pic-${i}" data-toggle="tab"><img src="${fileName}" onerror="this.src='/images/uploadFiles/error_temp_Image.png'"/></a></li>
						  	</c:if>
						  	<c:set var="i" value="${i+1}"/>
						  </c:forEach>
						</ul>
						
					</div>
					<div class="details col-md-6">
						<h3 class="product-title">${product.prodName }</h3>
						<div class="rating">
						
							<div class="star-rating">
								<span style="width:${avgRating}%;"></span>
							</div>
							
							<span class="review-no">${reviewCount } reviews</span>
							
						</div>
						<p class="product-description">${product.prodDetail }</p>
						<h4 class="price"> price: <span>${product.price }&nbsp;<span class="fa fa-krw"></span></span></h4> 
						<h5 class="stock"> stock : ${product.stock}  </h5>
						<div class="action">
							<c:if test="${empty sessionScope.user}">
								<button class="btn btn-info btn-lg" type="button" id="login">로그인이 필요합니다.</button>
							</c:if>
							<c:if test="${user.role eq 'admin' && product.stock > 0}">
								<button id="updateProduct" class="add-to-cart btn btn-default" type="button">수정</button>
								<button id="deleteProduct" class="buy btn btn-default" type="button">삭제</button>
							</c:if>
							<c:if test="${user.role eq 'user' && product.stock > 0}">
								<button id="add-to-cart" class="add-to-cart btn btn-default" type="button">add to cart</button>
								<button id="buy" class="buy btn btn-default" type="button">buy</button>
							</c:if>
							<c:if test="${!empty sessionScope.user && !(user.role eq 'user' && product.stock > 0)}">
								<button class="btn btn-danger btn-lg" type="button" disabled="disabled">현재 품절된 상품 입니다.</button>
							</c:if>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%----------------------------- 상세 정보 출력 끝 --------------------------------------%>
	
	
	
	<!-- 리뷰 출력 -->
	<br/><br/>
	<div class="review">
		<c:import url="/common/listPrinter.jsp"/>
	</div>
	
</form>

</body>
</html>