<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java"%>
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

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
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js?autoload=false"></script>
	<script type="text/javascript">
	function addPurchaseByCart(){
		countCheck = $(".listcheckbox:checkbox:checked").length
		
		var prodNo = "";
		if(countCheck < 1){
			alert("������ ��ǰ�� �����Ͻʽÿ�.");
			return;
		}else{
			var productArray = new Array();
			
			for(var i = 0; i < $(".listcheckbox:checkbox:checked").length; i++){
				var product = new Object();
				
				product.prodNo = $($($(".listcheckbox:checkbox:checked")[i]).parent().next().next()).text().trim();
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
					if(j>100){
						break;
					}
					selectOption += "<option value='" + j + "'>" + j + "</option>";
				}
				var selectEnd = "</select>";
				
				$(obj[i]).empty().append(selectStart+selectOption+selectEnd);
			}else{
				$(obj[i]).parent().children("td:first").empty();
				$(obj[i]).empty().text("ǰ���� ��ǰ�Դϴ�.");
			}
		}
	}
	
	$(function(){
		//��¥ �Է�
		$("#datepicker").datepicker();
		$( "#datepicker" ).datepicker( "option", "dateFormat", "yy-mm-dd" );
		
		//�ּ� �Է�
		$("[name=zoneCode],[name=firstAddress]").on("click",function(){
			daum.postcode.load(function(){
				new daum.Postcode({
			        oncomplete: function(data) {
//	 		        	console.log("data : " + data.address);
						$("[name=zoneCode]").val(data.zoneCode);
						if(data.userSelectedType == "J"){
			        		$("[name=firstAddress]").val(data.jibunAddress);
						}else{
							$("[name=firstAddress]").val(data.roadAddress);
						}				
			        }
			    }).open();
			});
		});	
		
		makeSelect($("table tr td:nth-child(6)"));
		
		$("#goBack").on("click",function(){
			history.go(-1);
		});
		
		$("#buy").on("click",function(){
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
		
		$("table tr td:nth-child(6)").on("click",function(){
			deleteCart($(this).parent());
		});
		
		
	});
		
	
</script>
<head>
	<link rel="stylesheet" href="/css/admin.css" type="text/css">
	
	<c:if test="${!empty user}"> <c:import url="/layout/toolbar.jsp">  </c:import></c:if>
	<c:if test="${empty user}">	 <c:import url="/layout/toolbar2.jsp"> </c:import></c:if>
	
	<title>��ٱ���</title>
</head>
<body bgcolor="#ffffff" text="#000000">

<form class="form-horizontal" name="detailForm">
<c:import url="/common/listPrinter.jsp"/>

	<div class="container">
		  <div class="form-group">
		    <label for="userId" class="col-sm-offset-1 col-sm-3 control-label">������ ���̵�</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="userId" name="userId" value="${user.userId }">
		      <span id="helpBlock" class="help-block">
		      </span>
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="paymentOption" class="col-sm-offset-1 col-sm-3 control-label">��й�ȣ</label>
		    <div class="col-sm-4">
		      <select name="paymentOption" class="form-control">
				<option value="0" selected="selected">���ݱ���</option>
				<option value="1">�ſ뱸��</option>
			  </select>
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="password2" class="col-sm-offset-1 col-sm-3 control-label">������ �̸�</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="receiverName" name="receiverName" value="${user.userName }">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">�޴���ȭ��ȣ</label>
		     <div class="col-sm-2">
		      <select class="form-control" name="phone1" id="phone1">
				  	<option value="010" >010</option>
					<option value="011" >011</option>
					<option value="016" >016</option>
					<option value="018" >018</option>
					<option value="019" >019</option>
				</select>
		    </div>
		    <div class="col-sm-2">
		      <input type="text" class="form-control" id="phone2" name="phone2" placeholder="��ȣ">
		    </div>
		    <div class="col-sm-2">
		      <input type="text" class="form-control" id="phone3" name="phone3" placeholder="��ȣ">
		    </div>
		    <input type="hidden" name="phone"  />
		  </div>
		  
		  <div class="form-group">
		    <label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">�ּ�</label>
		    <div class="col-sm-4">
		      	<input 	type="text" class="dlvyAddr form-control" name="zoneCode" 	   readonly="readonly" 	placeholder="�����ȣ" style="width: 100px;"/>
				<input 	type="text" class="dlvyAddr form-control" name="firstAddress"  readonly="readonly" 	placeholder="�⺻ �ּ�"/>
				<input 	type="text" class="dlvyAddr form-control" name="secondAddress" maxLength="20" 		placeholder="�� �ּ�"/>
		    </div>
		  </div>
		  
		   <div class="form-group">
		    <label for="dlvyDate" class="col-sm-offset-1 col-sm-3 control-label">����������</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" readonly="readonly" id="datepicker" name="dlvyDate"/>
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  id="buy">�� &nbsp;��</button>
			  <button type="button" class="btn btn-primary"  id="goBack">�� &nbsp;��</button>
		    </div>
		  </div>
		  
	</div>
	
</form>

</body>
</html>