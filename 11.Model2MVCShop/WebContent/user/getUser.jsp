<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- ���� : http://getbootstrap.com/css/   ���� -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
   
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
 		body {
            padding-top : 50px;
        }
     </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
     <script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
     <script src="/javascript/CommonScript.js"></script>
	<script type="text/javascript">
	//===============īī�� �α���=====================
	$(function(){
		 // ����� ���� JavaScript Ű�� ������ �ּ���.
	    Kakao.init('654a6ed2c467856336978af7f4c590bf');
	    // īī�� �α��� ��ư�� �����մϴ�.
	    Kakao.Auth.createLoginButton({
	      container: '#kakao-login-btn',
	      success: function(authObj) {
	        // �α��� ������, API�� ȣ���մϴ�.
	        Kakao.API.request({
	          url: '/v2/user/me',
	          success: function(res) {
//		            alert(JSON.stringify(res));
	            ValidationCheck("users", "kakao", "kakao", res.id, function(result){
	            	if(result == "false"){
	            		alert("������ ������ ������ �����մϴ�.");
	            	}else{
	            		UpdateData("users", "kakao", res.id, "user_id", "${user.userId}", function(result){
	            			alert("����? : " + reslut);
	            		});
	            		location.href = "/user/getUser?userId=" + "${user.userId}";
	            	}
	            	
	            	
	            });
	          },
	          fail: function(error) {
	            alert(JSON.stringify(error));
	          }
	        });
	      },
	      fail: function(err) {
	        alert(JSON.stringify(err));
	      }
	    });
	});
		
		//============= ȸ���������� Event  ó�� =============	
		 $(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			 $( "#updateUser" ).on("click" , function() {
					self.location = "/user/updateUser?userId=${user.userId}"
				});
		});
		
		//============= ���� ��� Event  ó�� =============	
		 $(function() {
			$( "#cancelKakao" ).on("click" , function() {
				UpdateData("users", "kakao", "", "user_id", "${user.userId}", function(result){
        			alert("����? : " + reslut);
        		});
        		location.href = "/user/getUser?userId=" + "${user.userId}";
			});
		});
		 
	</script>
	
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header">
	       <h3 class=" text-info">ȸ��������ȸ</h3>
	       <h5 class="text-muted">�� ������ <strong class="text-danger">�ֽ������� ����</strong>�� �ּ���.</h5>
	    </div>
	
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>�� �� ��</strong></div>
			<div class="col-xs-8 col-md-4">${user.userId}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>�� ��</strong></div>
			<div class="col-xs-8 col-md-4">${user.userName}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>�ּ�</strong></div>
			<div class="col-xs-8 col-md-4">${user.addr}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>�޴���ȭ��ȣ</strong></div>
			<div class="col-xs-8 col-md-4">${ !empty user.phone ? user.phone : ''}	</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>�� �� ��</strong></div>
			<div class="col-xs-8 col-md-4">${user.email}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>��������</strong></div>
			<div class="col-xs-8 col-md-4">${user.regDate}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>���� ����</strong></div>
			<div class="col-xs-8 col-md-4">
				<c:if test="${!empty user.kakao}">
					kakao ���� �Ϸ� <button type="button" class="btn btn-primary" id="cancelKakao">���� ���</button>
				</c:if>
				<c:if test="${empty user.kakao}">
					<a id="kakao-login-btn"></a>
				</c:if>  
			</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-md-12 text-center ">
	  			<button type="button" class="btn btn-primary" id="updateUser">ȸ����������</button>
	  		</div>
		</div>
		
		<br/>
		
 	</div>
 	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->

</body>

</html>