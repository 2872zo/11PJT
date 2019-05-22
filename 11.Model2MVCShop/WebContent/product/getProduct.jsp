<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java"%>
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
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
					url : "/purchase/addCart",
					data : {
						prodNo : obj
					},
					dataType : "json",
					success : function() {
						alert("��ٱ��Ͽ� �߰��Ǿ����ϴ�.");
					}
				}
		);
	}
	
	$(function(){
		$("a:contains('����')").on("click",function(){
			history.go(-1);
		});
		
		$("a:contains('����')").on("click",function(){
			fncGetAddPurchaseView(${product.prodNo});
		});
		
		$("a:contains('����')").on("click",function(){
			location.href ="/product/updateProductView?prodNo=${product.prodNo}";
		});
		
		$("a:contains('����')").on("click",function(){
			location.href ="/product/deleteProduct?prodNo=${product.prodNo}";
		});
		
		$("a:contains('���')").on("click",function(){
			var prodNo = ${product.prodNo};
			var userId = "${user.userId}";
			GetData("cart","user_id","prod_no",userId,function(output){
// 				alert("output : " + output + " " + typeof(output));
// 				alert(output.indexOf(prodNo));
				if(output.indexOf(prodNo) == -1){
					addCart(prodNo);		
				}else{
					alert("��ٱ��Ͽ� ���� ��ǰ�� �����մϴ�.");
				}
			});
			
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
	<title>��ǰ����ȸ</title>
</head>
<body bgcolor="#ffffff" text="#000000">

<form name="detailForm" method="post" action="/purchase/addPurchaseView">
<input type="hidden" name="prodNo" id="prodNo">

<!-- �� ���� ��� -->
<c:import url="../common/getDetail.jsp"/>

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
						<a>����</a>
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
					<td width="30"></td>
					
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
						<a>����</a>
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
						<a>����</a>
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
					<td width="30"></td>
					
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
						<a>���</a>
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
					<td width="30"></td>
				</c:if>
		
				<td width="17" height="23">
					<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
				</td>
				<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
					<a>����</a>
				</td>
				<td width="14" height="23">
					<img src="/images/ct_btnbg03.gif" width="14" height="23">
				</td>
			</tr>
		</table>

		</td>
	</tr>
</table>

<!-- ���� ��� -->
<br/><br/>
<c:import url="../common/listPrinter.jsp">
	<c:param name="unitList" value="${reviewList}"/>
</c:import>

</form>

</body>
</html>