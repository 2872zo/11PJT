<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<div class="container">    
	<div class="row">
		<div class="col-md-6">
	
			<table class="table table-striped">
				<tr>
					<td width="15" height="37">
						<img src="/images/ct_ttl_img01.gif"	width="15" height="37"/>
					</td>
					<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="93%" class="ct_ttl01">${list[0]}</td>
								<td width="20%" align="right">&nbsp;</td>
							</tr>
						</table>
					</td>
					<td width="12" height="37">
						<img src="/images/ct_ttl_img03.gif"	width="12" height="37"/>
					</td>
				</tr>
			</table>
			
			<table class="table table-striped">
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<c:forEach var="list" items="${list}" begin="1">
					<c:set var="splitList" value="${fn:split(list,',')}" />
					<tr>
						<td width="104" class="ct_write">${splitList[0]}</td>
						<td bgcolor="D6D6D6" width="1"></td>
						<td class="ct_write01">${splitList[1]}</td>
					</tr>
					<tr>
						<td height="1" colspan="3" bgcolor="D6D6D6"></td>
					</tr>
				</c:forEach>
				
			</table>
		
		</div>
	</div>
</div>