<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


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
<link rel="stylesheet" href="/resources/demos/style.css">

<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script type="text/javascript">
	$(function(){
		$("#datepicker").datepicker();
		$( "#datepicker" ).datepicker( "option", "dateFormat", "yy-mm-dd" );
	    
		$("#reset").on("click",function(){
			resetData();
		});
		
		$("#add").on("click",function(){
			fncAddProduct();
		});
	});
	
	function fncAddProduct() {
		//Form ��ȿ�� ����
		var name = $("input[name=prodName]").val();
		var detail = $("input[name=prodDetail]").val();
		var manuDate = $("input[name=manuDate]").val();
		var price = $("input[name=price]").val();

		if (name == null || name.length < 1) {
			alert("��ǰ���� �ݵ�� �Է��Ͽ��� �մϴ�.");
			return;
		}
		if (detail == null || detail.length < 1) {
			alert("��ǰ�������� �ݵ�� �Է��Ͽ��� �մϴ�.");
			return;
		}
		if (manuDate == null || manuDate.length < 1) {
			alert("�������ڴ� �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}
		if (price == null || price.length < 1) {
			alert("������ �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}
		
// 		alert($("form").serialize());

		$("form").attr("method","POST").attr("action","/product/addProduct").submit();
	}

	function resetData() {
		$("form").reset();
	}
</script>


<c:if test="${!empty user}"><c:import url="/layout/toolbar.jsp"></c:import></c:if>
<c:if test="${empty user}"><c:import url="/layout/toolbar2.jsp"></c:import></c:if>


<title>��ǰ���</title>

</head>

<body>
<div class="container">
	<div class="page-header text-info text-center">
		<h3 style="color:#000">�� ǰ �� ��</h3>
	</div>
	
	<form class="form-horizontal" name="detailForm" enctype="multipart/form-data">
	
		<div class="form-group">
			<label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">�� ǰ ��</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" name="prodName" id="prodName" placeholder="��ǰ��">
		    </div>
		</div>
		
		<div class="form-group">
		    <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">��ǰ �� ����</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="prodDetail" name="prodDetail">
		    </div>
		</div>
		
		<div class="form-group">
		    <label for="datepicker" class="col-sm-offset-1 col-sm-3 control-label">��������</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" name="manuDate" readonly="readonly" id="datepicker"/>
		    </div>
		</div>
		
		<div class="form-group">
		    <label for="price" class="col-sm-offset-1 col-sm-3 control-label">����</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="price" name="price">
		    </div>
		</div>
		
		<div class="form-group">
		    <label for="files" class="col-sm-offset-1 col-sm-3 control-label">��ǰ�̹���</label>
		    <div class="col-sm-4">
		      <input multiple="multiple" type="file" name="files" id="files" class="form-control">
		    </div>
		</div>
		
		<div class="form-group">
		    <label for="stock" class="col-sm-offset-1 col-sm-3 control-label">�� ��</label>
		    <div class="col-sm-4">
		      <input type="text" name="stock" id="stock" class="form-control">
		    </div>
		</div>
	
	
		<div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary" id="add" >�� &nbsp;��</button>
			  <button type="button" class="btn btn-primary" id="reset">��&nbsp;��</button>
		    </div>
		 </div>
	</form>
</div>
</body>
</html>