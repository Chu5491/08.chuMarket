<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="../javascript/common.js">

</script>
<!DOCTYPE html>
	<html>
	<head>
	<link rel="stylesheet" href="/css/admin.css" type="text/css">
	<title>Insert title here</title>
	</head>	
	<body bgcolor="#ffffff" text="#000000">
	<form name="detailForm" method="post" action="/market/getMarket?marketNo=${market.marketNo}&menu=${menu}">
		<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
			<tr>
				<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"	width="15" height="37"></td>
				<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="93%" class="ct_ttl01">
								<b>${market.marketName}</b>
							</td>
							<td width="20%" align="right">&nbsp;</td>
						</tr>
					</table>
				</td>
				<td width="12" height="37">
					<img src="/images/ct_ttl_img03.gif"  width="12" height="37"/>
				</td>
			</tr>
		</table>
	
		<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 13px;">
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			<tr>
				<td width="104" class="ct_write">
					소개
				</td>
				<td bgcolor="D6D6D6" width="1"></td>
				<td class="ct_write01">${market.marketIntro}</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			<tr>
				<td width="104" class="ct_write">
					운영정보 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
				</td>
				<td bgcolor="D6D6D6" width="1"></td>
				<td class="ct_write01">
					<c:if test="${market.manaFlag == 'Y' }">
						현재 운영중인 쇼핑몰입니다.
					</c:if>
					<c:if test="${market.manaFlag == 'W' }">
						현재 승인 대기중인 쇼핑몰입니다.
					</c:if>
					<c:if test="${market.manaFlag == 'F' }">
						현재 운영이 중단된 쇼핑몰입니다.
					</c:if>
				</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
		</table>
		<h3>판매중인 상품</h3>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
			<tr>
				<td colspan="13" >전체 <b>${resultPage.totalCount}</b> 건수</td>
			</tr>
			<tr>
				<td class="ct_list_b" width="100">No</td>
				<td class="ct_line02"></td>
				<td class="ct_list_b" width="150">상품명</td>
				<td class="ct_line02"></td>
				<td class="ct_list_b" width="150">가격</td>
				<td class="ct_line02"></td>
				<td class="ct_list_b">등록일</td>	
				<td class="ct_line02"></td>
				<td class="ct_list_b">쇼핑몰</td>	
				<td class="ct_line02"></td>
				<td class="ct_list_b">현재상태</td>	
			</tr>
			<tr>
				<td colspan="13" bgcolor="808285" height="1"></td>
			</tr>
			<c:forEach var="prod" items="${list}" >
				<c:set var="i" value="${ i+1 }" />
				<tr class="ct_list_pop">
					<td align="center">${i}</td>
					<td></td>
					<td align="left">
						<c:if test="${prod.prodStock > 0}">
							<a href="/product/getProduct?prodNo=${prod.prodNo}&menu=${menu}">
								${prod.prodName}
							</a>
						</c:if>
						<c:if test="${prod.prodStock <= 0}">
							<c:if test="${menu == 'manage'}">
								<a href="/product/getProduct?prodNo=${prod.prodNo}&menu=${menu}">
									${prod.prodName}
								</a>
							</c:if>
							<c:if test="${menu != 'manage'}">
								${prod.prodName}
							</c:if>
						</c:if>
					</td>
					<td></td>
					<td align="left">${prod.price}</td>
					<td></td>
					<td align="left">${prod.regDate}</td>
					<td></td>
					<td align="left">${market.marketName}</td>
					<td></td>
					<td align="left">
						<c:if test="${prod.prodStock <= 0}">
							재고없음
						</c:if>
						<c:if test="${prod.prodStock > 0}">
							<c:if test="${menu != 'manage'}">
								<c:if test="${prod.prodStock <= 5}">
									품절임박 [ ${prod.prodStock} 개 남음 ]
								</c:if>
								<c:if test="${prod.prodStock > 5}">
									판매중
								</c:if>
							</c:if>
							<c:if test="${menu == 'manage'}">
								재고 : ${prod.prodStock} 개 남음
							</c:if>
						</c:if>
					</td>	
				</tr>
				<tr>
					<td colspan="13"z bgcolor="D6D7D6" height="1"></td>
				</tr>
			</c:forEach>
		</table>
		
		<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
			<tr>
				<td width="53%"></td>
				<td align="right">
				<table border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="17" height="23">
							<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
						</td>
						<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
							<a href="javascript:history.go(-1)">이전</a>
						</td>
						<td width="14" height="23">
							<img src="/images/ct_btnbg03.gif" width="14" height="23">
						</td>
						<td width="30"></td>
					</tr>
				</table>
		
				</td>
			</tr>
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
	</body>
</html>