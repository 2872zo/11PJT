<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<html>
<head>
<link rel="stylesheet" href="/css/admin.css" type="text/css">

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
	//Form ��ȿ�� ����
 	var name = $("input[name=prodName]").val();
	var detail = $("input[name=prodDetail]").val();
	var manuDate = $("input[name=manuDate]").val();
	var price = $("input[name=price]").val();

	if(name == null || name.length<1){
		alert("��ǰ���� �ݵ�� �Է��Ͽ��� �մϴ�.");
		return;
	}
	if(detail == null || detail.length<1){
		alert("��ǰ�������� �ݵ�� �Է��Ͽ��� �մϴ�.");
		return;
	}
	if(manuDate == null || manuDate.length<1){
		alert("�������ڴ� �ݵ�� �Է��ϼž� �մϴ�.");
		return;
	}
	if(price == null || price.length<1){
		alert("������ �ݵ�� �Է��ϼž� �մϴ�.");
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

<title>�������� ����</title>

</head>

<body>

	<div class="container">
		
		<div class="page-header">
	       <h3 class=" text-info">������������</h3>
	    </div>
		
		<form class="form-horizontal">
		
			<input type="hidden" name="prodNo" value="${purchase.purchaseProd.prodNo}">
			<input type="hidden" name="tranNo" value="${purchase.tranNo}">
			
			<div class="form-group">
			    <label class="col-sm-offset-1 col-sm-3 control-label">������ ���̵�</label>
			    <div class="col-sm-4">
			    	<input type="text" id="userId" name="userId" class="form-control" value="${purchase.buyer.userId}"/>
				</div>
			</div>
			
			<hr/>
		
			<div class="form-group">
			    <label class="col-sm-offset-1 col-sm-3 control-label">���� ����</label>
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
			    <label class="col-sm-offset-1 col-sm-3 control-label">���� ���</label>
			    <div class="col-sm-4">
			    	<select name="paymentOption" class="form-control">
						<option value="1" ${purchase.paymentOption eq '0'?"selected='selected'":""}>���ݱ���</option>
						<option value="2" ${purchase.paymentOption eq '1'?"selected='selected'":""}>�ſ뱸��</option>
					</select>
				</div>
			</div>
			
			<hr/>
			
			<div class="form-group">
			    <label for="receiverName" class="col-sm-offset-1 col-sm-3 control-label">������ �̸�</label>
			    <div class="col-sm-4">
			    	<input type="text" id="receiverName" name="receiverName" class="form-control" value="${purchase.receiverName}"/>
				</div>
			</div>
			
			<hr/>
			
			<div class="form-group">
			    <label for="receiverPhone" class="col-sm-offset-1 col-sm-3 control-label">������ ����ó</label>
			    <div class="col-sm-4">
			    	<input 	type="text" id="receiverPhone" name="receiverPhone" class="form-control" value="${purchase.receiverPhone}"/>
				</div>
			</div>
			
			<hr/>
			
			<div class="form-group">
			    <label class="col-sm-offset-1 col-sm-3 control-label">������ �ּ�</label>
			    <div class="col-sm-4">
			    	<input 	type="text" class="dlvyAddr form-control" name="zonecode" 	   value="${purchase.zoneCode}" 		placeholder="�����ȣ" readonly="readonly"/>
					<input 	type="text" class="dlvyAddr form-control" name="firstAddress"  value="${purchase.firstAddress}" 	placeholder="�⺻�ּ�" readonly="readonly"/>
					<input 	type="text" class="dlvyAddr form-control" name="secondAddress" value="${purchase.secondAddress}" 	placeholder="���ּ�"/>
				</div>
			</div>
			
			<hr/>
			
			<div class="form-group">
			    <label for="dlvyRequest" class="col-sm-offset-1 col-sm-3 control-label">��û����</label>
			    <div class="col-sm-4">
			    	<input type="text" name="dlvyRequest" class="form-control" value="${purchase.dlvyRequest}"/>
				</div>
			</div>
			
			<hr/>
			
			<div class="form-group">
			    <label for="dlvyRequest" class="col-sm-offset-1 col-sm-3 control-label">����������</label>
			    <div class="col-sm-4">
			    	<input type="text" readonly="readonly" id="datepicker" name="dlvyDate" class="form-control" value="${purchase.dlvyDate}"/>
				</div>
			</div>
			
			<hr/>
			
			<div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button class="btn btn-primary" id="update">����</button>
			  <button class="btn btn-primary" id="cancel">�� ��</button>
		    </div>
		  </div>
			
		</form>
		
	</div>

</body>
</html>