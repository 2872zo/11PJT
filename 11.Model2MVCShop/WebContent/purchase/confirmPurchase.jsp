<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<html>
<head>
<title>���� ���� Ȯ��</title>
</head>

<body>

<form name="updatePurchase" action="/purchase/updatePurchaseView" method="post">

������ ���� ���Ű� �Ǿ����ϴ�.

<table border=1>
	<tr>
		<td>��ǰ��ȣ</td>
		<td>${purchase.purchaseProd.prodNo}</td>
	</tr>
	<tr>
		<td>�����ھ��̵�</td>
		<td>${purchase.buyer.userId}</td>
	</tr>
	<tr>
		<td>���Ź��</td>
		<td>
			<c:choose>
				<c:when test="${purchase.paymentOption eq '0'}">
					���ݱ���
				</c:when>
				<c:when test="${purchase.paymentOption eq '1'}">
					�ſ뱸��
				</c:when>
			</c:choose>
		</td>
	</tr>
	<tr>
		<td>�������̸�</td>
		<td>${purchase.receiverName}</td>
	</tr>
	<tr>
		<td>�����ڿ���ó</td>
		<td>${purchase.receiverPhone}</td>
	</tr>
	<tr>
		<td>�������ּ�</td>
		<td>${purchase.dlvyAddr}</td>
	</tr>
		<tr>
		<td>���ſ�û����</td>
		<td>${purchase.dlvyRequest}</td>
	</tr>
	<tr>
		<td>����������</td>
		<td>${purchase.dlvyDate}</td>
	</tr>
</table>
</form>
</body>
</html>