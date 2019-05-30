<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>

<head>
	<meta charset="EUC-KR">
	
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
	<link rel="stylesheet" href="/css/jquery.raty.css" type="text/css">
	
	<!-- CDN(Content Delivery Network) ȣ��Ʈ ��� -->
    <script type="text/javascript" src="/javascript/jquery.raty.js"></script>
	<script src="../javascript/CommonScript.js"></script>
	<script type="text/javascript">
		
		function fncAddReview() {
// 			$("[name=text]").val($("[name=text]").val().replace(/(?:\r\n|\r|\n)/g, '<br/>'));
// 			alert("[name=text]");
			var tmp = $("[name=text]").val().replace(/(?:\r\n|\r|\n)/g, '<br/>');
			$("[name=text]").val(tmp);
			
// 			alert($("[name=rating]").val());
			$("form").attr("method" , "POST").attr("action" , "/review/addReview").submit();
		}
		
		//==>"����"  Event ����
		 $(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 1 �� 3 ��� ���� : $("tagName.className:filter�Լ�") �����.	
			 $( "#add" ).on("click" , function() {
				fncAddReview();
			});
		});	
		
		
		//==>"���"  Event ó�� ��  ����
		$(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 1 �� 3 ��� ���� : $("tagName.className:filter�Լ�") �����.	
			 $( "#cancel" ).on("click" , function() {
					//Debug..
					//alert(  $( "td.ct_btn01:contains('���')" ).html() );
					$("form")[0].reset();
			});
		});	
		
		//���� �÷����� �ɼ�
		$(function() {
            $('div#star').raty({
                score: 3
                ,path : "/images"
                ,width : 200
                ,click: function(score, evt) {
                    $("#starRating").val(score);
                }
            });
        });
		
		$(function(){
			$("[name=tranNo]").val(${param.tranNo});
			$("[name=prodNo]").val(${param.prodNo});
			$("[name=userId]").val(${param.userId});
		});
	</script>		
	
	<c:if test="${!empty user}"> <c:import url="/layout/toolbar.jsp">  </c:import></c:if>
	<c:if test="${empty user}">	 <c:import url="/layout/toolbar2.jsp"> </c:import></c:if>
		
	<title>���� �ۼ�</title>
</head>

<body bgcolor="#ffffff" text="#000000">

	<div class="container">
		
		<div class="page-header text-info text-center">
			<h3 style="color:#000">�� �� �� ��</h3>
		</div>
	
		<form class="form-horizontal" enctype="multipart/form-data">
			<input type="hidden" class="form-control" name="tranNo" value="">
			<input type="hidden" class="form-control" name="prodNo" value="">
			<input type="hidden" class="form-control" name="userId" value="">

			<div class="form-group">
				<label for="title" class="col-sm-offset-1 col-sm-3 control-label">�� ��</label>
			    <div class="col-sm-4">
			      <input type="text" class="form-control" name="title" id="title">
			    </div>
			</div>
			
			<div class="form-group">
				<label for="text" class="col-sm-offset-1 col-sm-3 control-label">�� ��</label>
			    <div class="col-sm-4">
			      <textarea name="text" class="form-control" rows="6" maxLength="300"></textarea>
			    </div>
			</div>
		
			<div class="form-group">
				<label for="rating" class="col-sm-offset-1 col-sm-3 control-label">�� ��</label>
			    <div class="col-sm-4">
			     	<div id="star"></div>
					<input type="hidden" id="starRating" name="rating" value="3">
			    </div>
			</div>
			
			<div class="form-group">
			    <label for="files" class="col-sm-offset-1 col-sm-3 control-label">���� ÷��</label>
			    <div class="col-sm-4">
			    	<input multiple="multiple" type="file" name="files" id="files" class="form-control">
			    </div>
			</div>
			
			<div class="form-group">
			    <div class="col-sm-offset-4  col-sm-4 text-center">
			      <button type="button" class="btn btn-primary" id="add" >�ۼ� �Ϸ�</button>
				  <button type="button" class="btn btn-primary" id="reset">��&nbsp;��</button>
			    </div>
			</div>

		</form>
	</div>
</body>

</html>