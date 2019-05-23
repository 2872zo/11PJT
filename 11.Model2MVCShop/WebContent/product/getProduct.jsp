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
</style>
<!--  ///////////////////////// 툴바 이용을 위한 lib END ////////////////////////// -->
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script src="../javascript/CommonScript.js"></script>
<script type="text/javascript">
	function fncGetAddPurchaseView(prodNo){
		$("input[name=prodNo]").val(prodNo);
		
		$("form").submit();
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
			fncGetAddPurchaseView(${product.prodNo});
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
		
		
		$("a:contains('수정')").on("click",function(){
			location.href ="/product/updateProductView?prodNo=${product.prodNo}";
		});
		
		$("a:contains('삭제')").on("click",function(){
			location.href ="/product/deleteProduct?prodNo=${product.prodNo}";
		});
		
		
		$(".ct_list_pop").on("click",function(){
			var reviewNo = $($(this).find("td")[0]).text();
			var target = $(this).next().find("td");
			
			if($(document).find(".text") != null){
				if(!target.find("div").hasClass("text")){
					$(document).find(".text").remove();
					
//		 			alert($($(this).find("td")[0]).text());
					GetData("review","review_no","text",reviewNo,function(output){
//		 				alert(output);
						var text = $.parseJSON(output);
//		 				alert(text);
						target.append("<div class='text'>"+text+"</div>");
					});
				}else{
					$(document).find(".text").remove();
				}
			}
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

<form name="detailForm" method="post" action="/purchase/addPurchaseView">
<input type="hidden" name="prodNo" id="prodNo">

<!-- 상세 정보 출력 -->
<c:import url="../common/productDetail.jsp"/>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td width="53%"></td>
		<td align="right">

		<table border="0" cellspacing="0" cellpadding="0">
			<tr>
				<c:if test="${user.role eq 'admin' && product.stock > 0}">
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
						<a>삭제</a>
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
					<td width="30"></td>
					
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
						<a>수정</a>
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
					<td width="30"></td>
				</c:if>
			
				<c:if test="${user.role eq 'user' && product.stock > 0}">
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
						<a>구매</a>
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
					<td width="30"></td>
					
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
						<a>담기</a>
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
					<td width="30"></td>
				</c:if>
				
			</tr>
		</table>

		</td>
	</tr>
</table>

<!-- 리뷰 출력 -->
<br/><br/>
<c:import url="../common/listPrinter.jsp">
	<c:param name="unitList" value="${reviewList}"/>
</c:import>

</form>

</body>
</html>