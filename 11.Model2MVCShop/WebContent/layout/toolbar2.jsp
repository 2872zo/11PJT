<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!--  ///////////////////////// javascript  ////////////////////////// -->
<script src="/javascript/toolbar.js"></script>

<!-- ToolBar Start /////////////////////////////////////-->
	<div class="navbar  navbar-default navbar-fixed-top">
		
        <div class="container">
        
        	<a class="navbar-brand" href="/index.jsp">Model2 MVC Shop</a>
			
			<!-- toolBar Button Start //////////////////////// -->
			<div class="navbar-header">
			    <button class="navbar-toggle collapsed" data-toggle="collapse" data-target="#target">
			        <span class="sr-only">Toggle navigation</span>
			        <span class="icon-bar"></span>
			        <span class="icon-bar"></span>
			        <span class="icon-bar"></span>
			    </button>
			</div>
			<!-- toolBar Button End //////////////////////// -->
			
			<div class="collapse navbar-collapse"  id="target">
	             <ul class="nav navbar-nav navbar-right">
	                 <li><a href="#">ȸ������</a></li>
	                 <li><a href="#">�� �� ��</a></li>
	           	</ul>
	       </div>
   		
   		</div>
   	</div>
<!-- ToolBar End /////////////////////////////////////-->
 	
   	
   	
   	<script type="text/javascript">
	
  	//============= ȸ�������� ȭ���̵� =============
	$( function() {
		//==> �߰��Ⱥκ� : "addUser"  Event ����
		$("a[href='#' ]:contains('ȸ������')").on("click" , function() {
			self.location = "/user/addUser"
		});
	});
	
	//============= �α��� ȭ���̵� =============
	$( function() {
		//==> �߰��Ⱥκ� : "addUser"  Event ����
		$("a[href='#' ]:contains('�� �� ��')").on("click" , function() {
			self.location = "/user/login"
		});
	});
		
	</script>  