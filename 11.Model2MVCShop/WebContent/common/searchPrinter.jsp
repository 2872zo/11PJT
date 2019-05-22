<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<c:if test="${!empty searchOptionList}">
		<td align="right">
			<select name="searchCondition" class="ct_input_g" style="width:80px" id="searchCondition">
				<c:forEach var="i" begin="0" end="${fn:length(searchOptionList)-1}">
					<option value="${i}" ${(!empty search.searchKeyword && search.searchCondition eq i)?"selected='selected'":""}>${searchOptionList[i]}</option>
				</c:forEach>				
			</select>
			<input type="text" name="searchKeyword" id="searchKeyword" class="ct_input_g" style="width:200px; height:19px" value="${!empty search.searchKeyword?search.searchKeyword:''}"/>
		</td>
	
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23">
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<a href="#" id="search">°Ë»ö</a>
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
				</tr>
			</table>
		</td>
		</c:if>
	</tr>
</table>