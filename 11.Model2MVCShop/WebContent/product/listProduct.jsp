<%@ page language="java"%>
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>구매 목록 조회</title>

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
<!--  ///////////////////////// JavaScript ////////////////////////// -->

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link href="//netdna.bootstrapcdn.com/bootstrap/3.1.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link href="/css/thumbnail.css" rel="stylesheet">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="/javascript/CommonScript.js"></script>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.0/js/bootstrap.min.js"></script>
<script type="text/javascript">
$(function(){
	var prodNoList = [${prodNoList}];
	var prodFileList = [${prodFileList}];

	//tu
	$('[data-toggle="tooltip"]').tooltip();
	
	//제품 상세정보
	$(".btn-primary").on("click",function(){
// 		alert($(".btn-primary").index($(this)));
		location.href = "/product/getProduct?prodNo="+prodNoList[$(".btn-primary").index($(this))];
	});
	
	//search 기능
	$("#searchKeyword").keydown(function(key){
		if( key.keyCode==13 ){
			fncGetList(${resultPage.currentPage});
		}
	});
	$("#search").on("click",function(){
		fncGetList(${resultPage.currentPage});
	});
	
	
	//제품 sorting
	$(".ct_list_b:contains('No')").addClass("sort");
	$(".ct_list_b:contains('상품명')").addClass("sort");
	$(".ct_list_b:contains('가격')").addClass("sort");
	$(".sort").wrapInner("<ins></ins>");
	$(".sort").on("click",function(){
// 		alert($("td.sort").index($(this)));
		var sortCode = $(".sort").index($(this));
		if(sortCode == $("#sortCode").val()){
			sortCode += 2; 
		}
// 		alert(sortCode);
		fncSortList(${resultPage.currentPage},sortCode);
	});
	
	$("#unHidding").on("click",function(){
		fncHiddingEmptyStock(${resultPage.currentPage},false);
	});
	$("#hidding").on("click",function(){
		fncHiddingEmptyStock(${resultPage.currentPage},true);
	});
	
	$("#reset").on("click",function(){
		fncResetSearchCondition();
	});
	
	$("select[name=pageSize]").on("change",function(){
		fncGetList(${resultPage.currentPage});
	});
	
	$("#prePage").on("click",function(){
		fncGetList(${resultPage.beginUnitPage-1});
	});
	$(".page").on("click",function(){
		fncGetList($(this).text());
	});
	$("#nextPage").on("click",function(){
		fncGetList(${resultPage.endUnitPage+1});
	});
	
	$("#empty").on("click",function(){
		$("#listPrinter").empty()
		
		$.ajax({url:"../common/listPrinter.jsp",

				success:function(result) {

				$("#listPrinter").html(result);

		}});
		
		$("#div1").load("../common/listPrinter.jsp", function(responseTxt, statusTxt, xhr){

	        if(statusTxt == "success")

	            alert("External content loaded successfully!");
	        	$("#listPrinter").html(responseTxt);

	        if(statusTxt == "error")

	            alert("Error: " + xhr.status + ": " + xhr.statusText);

	    });
	});
	
	$("#searchKeyword").keyup(function(){
		if($("#searchCondition").val() == 1 && $("#searchKeyword").val().length >= 1){			
			GetData("product","prod_name","prod_name",$("#searchKeyword").val(),function(output){
// 				alert("output : " + output + " " + typeof(output));
				var jsonArray = $.parseJSON(output);
// 				alert(jsonArray);
				autoComplete(jsonArray);
			});
		}
	});
	
});


/////////////////////////////////////////////////////


function autoComplete(obj){
// 	alert(obj);
	$("#searchKeyword").autocomplete({
		source : obj
	});	
}

function fncValidationCheck(){
	var result = true;
	
	if(document.detailForm.searchCondition.value != 1 && document.detailForm.searchKeyword.value != null){
		var splitSearchKeyword = document.detailForm.searchKeyword.value.split(',');
		
		if(splitSearchKeyword.length > 2){
			alert(" ','를 이용하여 2개의 범위값을 지정해 주십시오");
		}
		for(var i = 0; i < splitSearchKeyword.length; i++){
			if(isNaN(splitSearchKeyword[i])){
				alert("숫자만 가능합니다.")
				result = false;
				break;
			}
			
		}
	}
	
	return result;
}

function fncGetList(currentPage){
	$("input[name=currentPage]").val(currentPage);
	$("input[name=menu]").val("${param.menu}");
	
	if(!fncValidationCheck()){
		return;
	}

	$("form[name=detailForm]").submit();
}

function fncSortList(currentPage, sortCode){
	$("input[name=currentPage]").val(currentPage);
	$("input[name=menu]").val("${param.menu}");
	$("input[name=sortCode]").val(sortCode);
	
	//검색 조건 Validation Check
	if(!fncValidationCheck()){
		return;
	}

	$("form").submit();
}

function fncHiddingEmptyStock(currentPage, hiddingEmptyStock){
	$("input[name=currentPage]").val(currentPage);
	$("input[name=menu]").val("${param.menu}");
	$("input[name=hiddingEmptyStock]").val(hiddingEmptyStock);
	
	//검색 조건 Validation Check
	if(!fncValidationCheck()){
		return;
	}

	$("form").submit();
}


function fncResetSearchCondition(){
	location.href = "/product/listProduct?menu=${param.menu}";
}



function fncUpdateTranCodeByProd(currentPage, prodNo){
	$("input[name=currentPage]").val(currentPage);
	$("input[name=menu]").val("${param.menu}");
	
	//검색 조건 Validation Check
	if(!fncValidationCheck()){
		return;
	}
	
	var URI = "/purchase/updateTranCodeByProd?page=" + currentPage + "&menu=" + "${param.menu}" + "&prodNo=" + prodNo + "&tranCode=2";
	
	if("${empty search.searchKeyword}" != "true"){
		URI += "&searchCondition=" + "${search.searchCondition}" + "&searchKeyword=" + "${search.searchKeyword}";
	}
	
	location.href = URI;
}


</script>

<c:if test="${!empty user}"><c:import url="/layout/toolbar.jsp"></c:import></c:if>
<c:if test="${empty user}"><c:import url="/layout/toolbar2.jsp"></c:import></c:if>

</head>
<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<form name="detailForm" action="/product/listProduct" method="post">

<%-- <c:import url="../common/listPrinter.jsp"/> --%>
<c:import url="../common/thumbnailListPrinter.jsp"/>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
			<input type="hidden" id="currentPage" name="currentPage"/>
			<input type="hidden" id="menu" name="menu" value=""/>
			<input type="hidden" id="sortCode" name="sortCode" value="${search.sortCode}"/>
			<input type="hidden" id="hiddingEmptyStock" name="hiddingEmptyStock" value="${search.hiddingEmptyStock}"/>
			
			<c:import url="../common/pageNavigator.jsp"/>
		</td>
	</tr>
	<tr>
		<td align="center">
			<a href="#" id="hidding">재고없는 상품 숨기기</a>
			&nbsp;
			<a href="#" id="unHidding">모든 상품 보기</a>
		</td>
	</tr>
	<tr>
		<td align="center">
			<a href="#" id="reset">검색 조건 초기화</a>
		</td>
	</tr>
	<tr>
		<td align="center">
			<a href="#" id="empty">listprinter.empty()</a>
		</td>
	</tr>
</table>
</form>

</div>

<div id="dialog"></div>

</body>
</html>
