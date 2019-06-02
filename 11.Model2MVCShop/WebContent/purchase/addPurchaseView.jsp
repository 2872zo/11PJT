<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js?autoload=false"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=af129d6f31fb9f7c15612976228f2d81"></script>

<script type="text/javascript">
$(function(){
	$("[name=zoneCode],[name=firstAddress]").on("click",function(){
		daum.postcode.load(function(){
			new daum.Postcode({
		        oncomplete: function(data) {
// 		        	for(i in data) {
//  				   		console.log("no is " + [i] + ", value is " + data[i]);
// 					}

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

	$("#add").on("click",function(){
		fncAddPurchase();	
	});
	
	$("#cancel").on("click",function(){
		cancel();
	});
	
	$("#datepicker").datepicker();
	$( "#datepicker" ).datepicker( "option", "dateFormat", "yy-mm-dd" );
	
	
	//////////��������//////////////////
// 	var container = document.getElementById("map"); //������ ���� ������ DOM ���۷���
// 	alert(container);
// 	var options = { //������ ������ �� �ʿ��� �⺻ �ɼ�
// 		center: new daum.maps.LatLng(33.450701, 126.570667), //������ �߽���ǥ.
// 		level: 3 //������ ����(Ȯ��, ��� ����)
// 	};
// 	var map = new daum.maps.Map(container, options); //���� ���� �� ��ü ����
	///////////////////////////////////

});


function fncAddPurchase() {
	$("form").attr("method","POST").attr("action","/purchase/addPurchase").submit();
}

</script>

<c:if test="${!empty user}"><c:import url="/layout/toolbar.jsp"></c:import></c:if>
<c:if test="${empty user}"><c:import url="/layout/toolbar2.jsp"></c:import></c:if>

<title>���� ����</title>
</head>

<body>
<!-- <div id="map" style="width:500px;height:400px;"></div> -->

	<div class="container">
		<div class="page-header">
	       <h3 class=" text-info">�� ǰ �� �� �� ȸ</h3>
	    </div>
		
		<form class="form-horizontal">
		
			<input type="hidden" name="prodNo" value="${product.prodNo}" />
			<input type="hidden" name="buyerId" value="${user.userId}" />
		
			<div class="form-group">
			    <label class="col-sm-offset-1 col-sm-3 control-label">��ǰ��ȣ</label>
			    <div class="col-sm-4">
			    	${product.prodNo}
				</div>
			</div>
			
			<hr/>
			
			<div class="form-group">
			    <label class="col-sm-offset-1 col-sm-3 control-label">�� ǰ ��</label>
			    <div class="col-sm-4">
			    	${product.prodName}
				</div>
			</div>
			
			<hr/>
			
			<div class="form-group">
			    <label class="col-sm-offset-1 col-sm-3 control-label">�� ǰ �� �� �� ��</label>
			    <div class="col-sm-4">
			    	${product.prodDetail}
				</div>
			</div>
			
			<hr/>
			
			<div class="form-group">
			    <label class="col-sm-offset-1 col-sm-3 control-label">�� �� �� ��</label>
			    <div class="col-sm-4">
			    	${product.manuDate}
				</div>
			</div>
			
			<hr/>
			
			<div class="form-group">
			    <label class="col-sm-offset-1 col-sm-3 control-label">�� ��</label>
			    <div class="col-sm-4">
			    	${product.price}
				</div>
			</div>
			
			<hr/>
			
			<div class="form-group">
			    <label class="col-sm-offset-1 col-sm-3 control-label">�������</label>
			    <div class="col-sm-4">
			    	${product.regDate}
				</div>
			</div>
			
			<hr/>
			
			<div class="form-group">
			    <label class="col-sm-offset-1 col-sm-3 control-label">������ ���̵�</label>
			    <div class="col-sm-4">
			    	${user.userId}
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
						<option value="0" selected="selected">���ݱ���</option>
						<option value="1">�ſ뱸��</option>
					</select>
				</div>
			</div>
			
			<hr/>
			
			<div class="form-group">
			    <label for="receiverName" class="col-sm-offset-1 col-sm-3 control-label">������ �̸�</label>
			    <div class="col-sm-4">
			    	<input type="text" id="receiverName" name="receiverName" class="form-control" value="${user.userName}"/>
				</div>
			</div>
			
			<hr/>
			
			<div class="form-group">
			    <label for="receiverPhone" class="col-sm-offset-1 col-sm-3 control-label">������ ����ó</label>
			    <div class="col-sm-4">
			    	<input 	type="text" id="receiverPhone" name="receiverPhone" class="form-control" value="${user.phone}"/>
				</div>
			</div>
			
			<hr/>
			
			<div class="form-group">
			    <label class="col-sm-offset-1 col-sm-3 control-label">������ �ּ�</label>
			    <div class="col-sm-4">
			    	<input 	type="text" class="dlvyAddr form-control" name="zoneCode" 	   value="${user.zoneCode}" 		placeholder="�����ȣ" readonly="readonly"/>
					<input 	type="text" class="dlvyAddr form-control" name="firstAddress"  value="${user.firstAddress}" 	placeholder="�⺻�ּ�" readonly="readonly"/>
					<input 	type="text" class="dlvyAddr form-control" name="secondAddress" value="${user.secondAddress}" 	placeholder="���ּ�"/>
				</div>
			</div>
			
			<hr/>
			
			<div class="form-group">
			    <label for="dlvyRequest" class="col-sm-offset-1 col-sm-3 control-label">��û����</label>
			    <div class="col-sm-4">
			    	<input type="text" name="dlvyRequest" class="form-control"/>
				</div>
			</div>
			
			<hr/>
			
			<div class="form-group">
			    <label for="dlvyRequest" class="col-sm-offset-1 col-sm-3 control-label">����������</label>
			    <div class="col-sm-4">
			    	<input type="text" readonly="readonly" id="datepicker" name="dlvyDate" class="form-control"/>
				</div>
			</div>
			
			<hr/>
			
			<div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button class="btn btn-primary" id="add">�� ��</button>
			  <button class="btn btn-primary" id="cancel">�� ��</button>
		    </div>
		  </div>
			
		</form>
		
	</div>


	
</body>
</html>