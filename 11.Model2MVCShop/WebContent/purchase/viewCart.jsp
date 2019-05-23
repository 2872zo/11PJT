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
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js?autoload=false"></script>
	<script type="text/javascript">
	function addPurchaseByCart(){
		countCheck = $(".listcheckbox:checkbox:checked").length
		
		var prodNo = "";
		if(countCheck < 1){
			alert("구매할 상품을 선택하십시오.");
			return;
		}else{
			var productArray = new Array();
			
			for(var i = 0; i < $(".listcheckbox:checkbox:checked").length; i++){
				var product = new Object();
				
				product.prodNo = $($($(".listcheckbox:checkbox:checked")[i]).parent().parent().children()[4]).text().trim();
				product.stock = $($($(".listcheckbox:checkbox:checked")[i]).parent().parent().find("select")).val();
				
				productArray.push(product);
			}
		}
		
		var queryString = $("form").serialize();
		queryString += "&jsonData="+JSON.stringify(productArray);
		
		$.ajax(
				{
					url : "/purchase/addPurchaseByCart",
					method : "POST",
					data : queryString,
					dataType : "json",
					error:function(status){
						alert("error : " + status);
					},
					success : function() {
						for(var i = 0; i < $(".listcheckbox:checkbox:checked").length; i++){
							deleteCart($($(".listcheckbox:checkbox:checked")[i]).parent().parent());							
						}
						location.href = "/purchase/listPurchase";
					}
				}
		);
	}	
	
	function deleteCart(obj){
 		$.ajax(
				{
					url : "/purchase/deleteCart",
					data : {
						prodNo : $(obj.children()[4]).text().trim()
					},
					dataType : "json",
					success : function() {
						obj.remove();
					}
				}
		);
	}
	
	
	function countCheckBox(){
		var countCheck = $(".listcheckbox:checkbox:checked").length;

		if(countCheck == $(":checkbox").not(":checkbox:first").length){
			$(":checkbox:first").prop("checked",true);
		}else{
			$(":checkbox:first").prop("checked",false);
		}
	}
	
	function checkAll(obj){
		$(":checkbox").prop("checked",true);
	}
	
	function unCheckAll(obj){
		$(":checkbox").prop("checked",false);
	}
	
	function makeSelect(obj){
		for(var i=0;i<obj.length;i++){
			if($(obj[i]).text().trim() > 0){
				var selectStart = "<select name=\"quantity\" class=\"ct_input_g\" style=\"width:80px\" id=\"quantity\">";
				var selectOption = "";
				for(var j = 1; j <= $(obj[i]).text().trim(); j++){
					selectOption += "<option value='" + j + "'>" + j + "</option>";
				}
				var selectEnd = "</select>";
				
				$(obj[i]).empty().append(selectStart+selectOption+selectEnd);
			}else{
				$(obj[i]).parent().children("td:first").empty();
				$(obj[i]).empty().text("품절된 상품입니다.");
			}
		}
	}
	
	$(function(){
		//날짜 입력
		$("#datepicker").datepicker();
		$( "#datepicker" ).datepicker( "option", "dateFormat", "yy-mm-dd" );
		
		//주소 입력
		$("[name=zonecode],[name=firstAddress]").on("click",function(){
			daum.postcode.load(function(){
				new daum.Postcode({
			        oncomplete: function(data) {
//	 		        	console.log("data : " + data.address);
						$("[name=zonecode]").val(data.zonecode);
						if(data.userSelectedType == "J"){
			        		$("[name=firstAddress]").val(data.jibunAddress);
						}else{
							$("[name=firstAddress]").val(data.roadAddress);
						}				
			        }
			    }).open();
			});
		});	
		
		makeSelect($("tr.ct_list_pop td:nth-child(11)"));
		
		$("a:contains('이전')").on("click",function(){
			history.go(-1);
		});
		
		$("a:contains('구매')").on("click",function(){
			addPurchaseByCart();
		});	
		
		$(":checkbox:first").on("click",function(){
			if($(":checkbox:first").is(":checked")){
				checkAll($(this));
			}else{
				unCheckAll($(this));
			}
		})
		
		$(":checkbox").on("click",function(){
			countCheckBox();
		});
		
		$("tr.ct_list_pop td:nth-child(13)").on("click",function(){
			deleteCart($(this).parent());
		});
		
		
	});
	
	
</script>
<head>
	<link rel="stylesheet" href="/css/admin.css" type="text/css">
	
	<c:if test="${!empty user}"> <c:import url="/layout/toolbar.jsp">  </c:import></c:if>
	<c:if test="${empty user}">	 <c:import url="/layout/toolbar2.jsp"> </c:import></c:if>
	
	<title>장바구니</title>
</head>
<body bgcolor="#ffffff" text="#000000">

<form name="detailForm">
<c:import url="../common/listPrinter.jsp"/>

<table width="600" border="0" cellspacing="0" cellpadding="0"	align="center" style="margin-top: 13px;">
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			구매자아이디 <img 	src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${user.userId}</td>
		
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">구매방법</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<select name="paymentOption" class="ct_input_g" style="width: 100px; height: 19px" maxLength="20">
				<option value="0" selected="selected">현금구매</option>
				<option value="1">신용구매</option>
			</select>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">구매자이름</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input type="text" name="receiverName" 	class="ct_input_g" 
						style="width: 100px; height: 19px" maxLength="20" value="${user.userName}"/>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">구매자연락처</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input 	type="text" name="receiverPhone" class="ct_input_g" 
							style="width: 100px; height: 19px" maxLength="20" value="${user.phone}"/>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">구매자주소</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input 	type="text" class="dlvyAddr" name="zonecode" 	  style="width: 50px; height: 19px" maxLength="20" value="${user.addr}"/>
			<input 	type="text" class="dlvyAddr" name="firstAddress"  style="width: 300px; height: 19px" maxLength="20" value="${user.addr}"/>
			<input 	type="text" class="dlvyAddr" name="secondAddress" style="width: 300px; height: 19px" maxLength="20" value="${user.addr}"/>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">배송희망일자</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td width="200" class="ct_write01">
			<input 	type="text" readonly="readonly" id="datepicker" name="dlvyDate" class="ct_input_g" style="width: 100px; height: 19px" maxLength="20"/>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td width="53%"></td>
		<td align="right">

		<table border="0" cellspacing="0" cellpadding="0">
			<tr>			
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
					<a>이전</a>
				</td>
				<td width="14" height="23">
					<img src="/images/ct_btnbg03.gif" width="14" height="23">
				</td>
			</tr>
		</table>
		
		</td>
	</tr>
</table>
</form>

</body>
</html>