<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript" src="../javascript/common.js">

</script>

<!DOCTYPE html>
<html>
	<head>
	<meta charset="EUC-KR">
	<title>입점 목록조회</title>
	<link rel="stylesheet" href="/css/admin.css" type="text/css">
	</head>
	<body bgcolor="#ffffff" text="#000000">
	<div style="width:98%; margin-left:10px;">
	<form name="detailForm" action="/product/listProduct?menu=${menu}" method="post">
		<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
			<tr>
				<td width="15" height="37">
					<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
				</td>
				<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="93%" class="ct_ttl01">
								입점 목록조회
							</td>
						</tr>
					</table>
				</td>
				<td width="12" height="37">
					<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
				</td>
			</tr>
		</table>
		<!-- 
		<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
			<tr>
				<td align="right">
					<select name="searchCondition" class="ct_input_g" style="width:80px">
						<option value="no" ${! empty search.searchCondition && search.searchCondition == 'no' ? 'selected' : ""}>상품번호</option>
						<option value="name" ${! empty search.searchCondition && search.searchCondition == 'name' ? 'selected' : ""}>상품명</option>
						<option value="price" ${! empty search.searchCondition && search.searchCondition == 'price' ? 'selected' : ""}>상품가격</option>
					</select>
					<input type="text" name="searchKeyword"  class="ct_input_g" style="width:200px; height:19px" value="${search.searchKeyword}" />
				</td>
				
				<td align="right" width="70">
					<table border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="17" height="23">
								<img src="/images/ct_btnbg01.gif" width="17" height="23">
							</td>
							<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
								<a href="javascript:fncGetList('1');">검색</a>
							</td>
							<td width="14" height="23">
								<img src="/images/ct_btnbg03.gif" width="14" height="23">
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		-->
		<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
			<tr>
				<td colspan="13" >전체 ${resultPage.totalCount} 건수, 현재 ${resultPage.currentPage} 페이지</td>
			</tr>
			<tr>
				<td class="ct_list_b" width="100">No</td>
				<td class="ct_line02"></td>
				<td class="ct_list_b" width="150">업체번호</td>
				<td class="ct_line02"></td>
				<td class="ct_list_b" width="150">상호명</td>
				<td class="ct_line02"></td>
				<td class="ct_list_b" width="230">소개</td>
				<td class="ct_line02"></td>
				<td class="ct_list_b" width="150">회원아이디</td>
				<td class="ct_line02"></td>
				<td class="ct_list_b">영업 시작일</td>	
				<td class="ct_line02"></td>
				<td class="ct_list_b">현재상태</td>	
			</tr>
			<tr>
				<td colspan="13" bgcolor="808285" height="1"></td>
			</tr>
			<c:forEach var="market" items="${list}" >
				<c:set var="i" value="${ i+1 }" />
				<tr class="ct_list_pop">
					<td align="center">${i}</td>
					<td></td>
					<td align="left">
						${market.marketNo}
					</td>
					<td></td>
					<td align="left">
						<a href="/market/getMarket?marketNo=${market.marketNo}&menu=manage">${market.marketName}</a>
					</td>
					<td></td>
					<td align="left">${market.marketIntro}</td>
					<td></td>
					<td align="left">${market.userId}</td>
					<td></td>
					<td align="left">${market.openDate }</td>
					<td></td>
					<td align="left">
						<c:if test="${market.manaFlag == 'W'}">
							승인 대기중
							&nbsp;
							<a href="/market/updateMarket?marketNo=${market.marketNo}&manaFlag=${market.manaFlag}&userId=${market.userId}">승인</a>
						</c:if>
						<c:if test="${market.manaFlag == 'Y'}">
							승인 완료
							&nbsp;
							<a href="/market/updateMarket?marketNo=${market.marketNo}&manaFlag=${market.manaFlag}&userId=${market.userId}">영업정지</a>							
						</c:if>
						<c:if test="${market.manaFlag == 'F'}">
							영업 정지
						</c:if>
					</td>	
				</tr>
				<tr>
					<td colspan="13" bgcolor="D6D7D6" height="1"></td>
				</tr>
			</c:forEach>
		</table>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
			<tr>
				<td align="center">
					<input type="hidden" id="currentPage" name="currentPage" value="${resultPage.currentPage}"/>
					${resultPage.paging}
		    	</td>
			</tr>
		</table>
	</form>
	</div>
	</body>
</html>
