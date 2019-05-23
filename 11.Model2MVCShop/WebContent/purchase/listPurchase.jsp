<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="../javascript/CommonScript.js"></script>
<script type="text/javascript">
	$(function(){
		var tranNoList = [${tranNoList}];
		var prodNoList = [${prodNoList}];
		
		$( "#dialog" ).dialog({
		      autoOpen: false
		});
		
		$("tr.ct_list_pop td:nth-child(5)").on("click",function(){
			location.href = "/product/getProduct?prodNo="+prodNoList[$($("td",$(this).parent())[0]).text()-1];
		});	
		
		$("tr.ct_list_pop td:nth-child(1)").wrapInner("<ins></ins>");
		$("tr.ct_list_pop td:nth-child(1)").on("click",function(){
			location.href = "/purchase/getPurchase?tranNo="+tranNoList[$(this).text()-1];
		});	
		
		$("a:contains('������')").on("click",function(){
			fncUpdatePurchaseCode($(this).parent(),tranNoList[$($("td",$(this).parent().parent())[0]).text()-1], 2);
		});
		
		$("a:contains('����Ȯ��')").on("click",function(){
			fncUpdatePurchaseCode($(this).parent(),tranNoList[$($("td",$(this).parent().parent())[0]).text()-1], 3)
		});
		
		$("a:contains('�����ۼ�')").on("click",function(){
			var clickObj = $(this).parent().parent();
			var dataString = "/review/addReviewView.jsp?tranNo="+tranNoList[$($("td",$(this).parent().parent())[0]).text()-1]
				+ "&prodNo=" + prodNoList[$($("td",$(this).parent().parent())[0]).text()-1] + "&userId='" + $($(clickObj.find('td')[2])).text() + "'";

			alert(dataString);
			
			location.href = dataString;
		});
		
		$("a:contains('����Ȯ��')").on("click",function(){
			var tranNo = tranNoList[$($("td",$(this).parent().parent())[0]).text()-1];
// 			alert(tranNo);
			var jsonObj = {tranNo:tranNo};
			var jsonString = JSON.stringify(jsonObj);
// 			alert(jsonString);

			var target = $(this);
			
			$.ajax({
				url:"/review/json/getReviewBytranNo",
				method:"POST",
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				data: jsonString,
				dataType: "json",
				error:function(){
					alert("error");
				},
				success:function(data){
		        	for(i in data) {
			   			console.log("no is " + [i] + ", value is " + data[i]);
					}
	
		        	var appendString = data.text;
// 		        	for(i in data) {
// 			   			appendString += [i] + " : " + data[i] + "<br/>";
// 					}
		        	
					$("#dialog").empty().append(appendString);
					$(".ui-dialog-title").empty().append(data.title);
					$( "#dialog" ).dialog( "option", "position", { my: "left top", at: "left bottom", of: target } );
					$( "#dialog" ).dialog( "open" );
				}
			});
		});
		
		$(".sort").on("click",function(){
			fncSortList(${resultPage.currentPage},$(".sort").index($(this)));
		});
		
		$("select[name=pageSize]").on("change",function(){
			fncGetList(${resultPage.currentPage});
		});
		
		$("#reset").on("click",function(){
			fncResetSearchCondition();
		});
		
		$("#unHidding").on("click",function(){
			fncHiddingEmptyStock(${resultPage.currentPage},false);
		});
		$("#hidding").on("click",function(){
			fncHiddingEmptyStock(${resultPage.currentPage},true);
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
	});
	
	function fncGetList(currentPage){
		$("input[name=currentPage]").val(currentPage);
		$("input[name=menu]").val("${param.menu}");

		$("form[name=detailForm]").submit();
	}
	
	function fncUpdatePurchaseCode(target,tranNo,tranCode){		
		UpdateData("transaction","tran_status_code",tranCode,tranNo,"tran_no",function(output){
		
			if(output){
				target.empty();
				if($(target.parent().find("td")[8]).text() == "����غ���"){
					$(target.parent().find("td")[8]).text("�����");
				}else if($(target.parent().find("td")[8]).text() == "�����"){
					$(target.parent().find("td")[8]).text("�ŷ��Ϸ�");
				}
			}
		});
	}

	function fncSortList(currentPage, sortCode){
		$("input[name=currentPage]").val(currentPage);
		$("input[name=menu]").val("${param.menu}");
		$("input[name=sortCode]").val(sortCode);

		$("form").submit();
	}

	function fncHiddingEmptyStock(currentPage, hiddingEmptyStock){
		$("input[name=currentPage]").val(currentPage);
		$("input[name=hiddingEmptyStock]").val(hiddingEmptyStock);

		$("form").submit();
	}

	function fncResetSearchCondition(){
		location.href = "/purchase/listPurchase";
	}
</script>

	<c:if test="${!empty user}"> <c:import url="/layout/toolbar.jsp">  </c:import></c:if>
	<c:if test="${empty user}">	 <c:import url="/layout/toolbar2.jsp"> </c:import></c:if>
	
	<title>���� �����ȸ</title>
</head>

<body bgcolor="#ffffff" text="#000000">

<div class="container" style="width: 98%; margin-left: 10px;">

	<form name="detailForm" action="/purchase/listPurchase" method="post">
	
		<%-- list��� �κ� --%>
		<c:import url="../common/listPrinter.jsp">
			<c:param name="domainName" value="Purchase"/>
		</c:import>
		
		<table class="table">
			<tr>
				<td align="center">
					<input type="hidden" id="currentPage" name="currentPage" value=""/>
					<input type="hidden" id="menu" name="menu" value=""/>
					<input type="hidden" id="sortCode" name="sortCode" value="${search.sortCode}"/>
					<input type="hidden" id="hiddingEmptyStock" name="hiddingEmptyStock" value="${search.hiddingEmptyStock}"/>
					
					<c:import url="/common/pageNavigator.jsp">
						<c:param name="domainName" value="Purchase"/>
					</c:import>	
				</td>
			</tr>
			<tr>
				<td align="center">
					<a href="#" class="sort"></a>
					<a class="sort">��� �غ����� ��ǰ</a>
					&nbsp;
					<a  class="sort">������� ��ǰ</a>
					&nbsp;
					<a  class="sort">�ŷ� �Ϸ�� ��ǰ</a>
					&nbsp;
					<a  class="sort">���� ��ҵ� ��ǰ</a>
				</td>
			</tr>
			<tr>
				<td align="center">
					<a  id="hidding">�ŷ����� ��ǰ�� ����</a>
					&nbsp;
					<a  id="unHidding">��� ��ǰ ����</a>
				</td>
			</tr>
			<tr>
				<td align="center">
					<a  id="reset">�˻� ���� �ʱ�ȭ</a>
				</td>
			</tr>
		</table>
	
		<!--  ������ Navigator �� -->
	</form>

</div>

<div id="dialog"></div>
</body>
</html>