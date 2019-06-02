<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!--  ///////////////////////// javascript  ////////////////////////// -->
<script src="/javascript/toolbar.js"></script>

<!-- ToolBar Start /////////////////////////////////////-->
<div class="navbar  navbar-inverse navbar-fixed-top">
	
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
		
	    <!--  dropdown hover Start -->
		<div 	class="collapse navbar-collapse" id="target" 
	       			data-hover="dropdown" data-animations="fadeInDownNew fadeInRightNew fadeInUpNew fadeInLeftNew">
	         
	         	<!-- Tool Bar �� �پ��ϰ� ����ϸ�.... -->
	             <ul class="nav navbar-nav">
	             
                  <c:if test="${sessionScope.user.role == 'admin'}">
	              <!--  ȸ������ DrowDown -->
	              <li class="dropdown">
	                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
	                         <span >ȸ������</span>
	                         <span class="caret"></span>
	                     </a>
	                     <ul class="dropdown-menu">
	                         
	                         
	                         	<li><a href="#">ȸ��������ȸ</a></li>
	                     </ul>
	                 </li>
                  </c:if>
	                 
	              <!-- �ǸŻ�ǰ���� DrowDown  -->
	               <c:if test="${sessionScope.user.role == 'admin'}">
		              <li class="dropdown">
		                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
		                         <span >�ǸŻ�ǰ����</span>
		                         <span class="caret"></span>
		                     </a>
		                     <ul class="dropdown-menu">
		                         <li><a href="#">�ǸŻ�ǰ���</a></li>
		                         <li><a href="#">�ǸŻ�ǰ����</a></li>
		                     </ul>
		                </li>
	                 </c:if>
	                 
	              <!-- ���Ű��� DrowDown -->
	              <li class="dropdown">
	                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
	                         <span >��ǰ����</span>
	                         <span class="caret"></span>
	                     </a>
	                     <ul class="dropdown-menu">
	                         <li><a href="#">�� ǰ �� ��</a></li>
	                         <li><a href="#">�ֱٺ���ǰ</a></li>
	                     </ul>
	                 </li>
	                 
	                 <!-- ���������� DrowDown -->
	                 <li class="dropdown">
	                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
	                         <span >����������</span>
	                         <span class="caret"></span>
	                     </a>
	                     <ul class="dropdown-menu">
	                     	  <li><a href="#">����������ȸ</a></li>
	                          <c:if test="${sessionScope.user.role == 'user'}">
	                          	<li><a href="#">�����̷���ȸ</a></li>
	                          </c:if>
	                          <c:if test="${sessionScope.user.role == 'admin'}">
	                           	<li><a href="#">�ŷ�����</a></li>
	                          </c:if>
	                     </ul>
	                 </li>
	             </ul>

	             <ul class="nav navbar-nav navbar-right">
	             	<li><a href="#" id="cart"><span class="glyphicon glyphicon-shopping-cart"></span></a></li>
	                <li><a href="#">�α׾ƿ�</a></li>
	            </ul>
		</div>
		<!-- dropdown hover END -->	       
	    
	</div>
</div>
		<!-- ToolBar End /////////////////////////////////////-->
 	
   	
   	
   	<script type="text/javascript">
	
		
/////////////////////////////////////////ȸ������//////////////////////////////////////
		//============= ȸ��������ȸ Event  ó�� =============	
		 $(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		 	$("a:contains('ȸ��������ȸ')").on("click" , function() {
				//$(self.location).attr("href","/user/logout");
				self.location = "/user/listUser"
			}); 
		 });
		//=============  ����������ȸ Event  ó�� =============	
	 	$( "a:contains('����������ȸ')" ).on("click" , function() {
	 		//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$(self.location).attr("href","/user/getUser?userId=${sessionScope.user.userId}");
		});

		
/////////////////////////////////////////��ǰ������//////////////////////////////////////
	 	//=============  �ǸŻ�ǰ��� Event  ó�� =============	
	 	$( "a:contains('�ǸŻ�ǰ���')" ).on("click" , function() {
	 		//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$(self.location).attr("href","/product/addProductView.jsp");
		});
	 	//=============  �ǸŻ�ǰ���� Event  ó�� =============	
	 	$( "a:contains('�ǸŻ�ǰ����')" ).on("click" , function() {
	 		//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$(self.location).attr("href","/product/listProduct?menu=manage");
		});
	 	
		
/////////////////////////////////////////��ǰ������//////////////////////////////////////
	 	//=============  ��ǰ�˻� Event  ó�� =============	
	 	$( "a:contains('�� ǰ �� ��')" ).on("click" , function() {
	 		//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$(self.location).attr("href","/product/listProduct?menu=search");
		});
	 	//=============  �ֱٺ���ǰ Event  ó�� =============	
	 	$( "a:contains('�ֱٺ���ǰ')" ).on("click" , function() {
	 		//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$(self.location).attr("href","javascript:history()");
		});
	 	//=============  �����̷���ȸ, �ŷ����� Event  ó�� =============	
	 	$( "a:contains('�����̷���ȸ'), a:contains('�ŷ�����')" ).on("click" , function() {
	 		//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$(self.location).attr("href","/purchase/listPurchase");
		});
	 		 	
///////////////////////////////////////toolbar right////////////////////////////////////////
	 	//=============  ��ٱ��� Event  ó�� =============	
	 	$( "#cart" ).on("click" , function() {
			$(self.location).attr("href","/purchase/viewCart");
		});
	 	
	 	//============= logout Event  ó�� =============	
		 $(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		 	$("a:contains('�α׾ƿ�')").on("click" , function() {
				$(self.location).attr("href","/user/logout");
				//self.location = "/user/logout"
			}); 
		 });
		
	</script>  