<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript" src="../javascript/calendar.js">
</script>

<script type="text/javascript">
<!--
function fncAddMarket()
{
	//Form 유효성 검증
 	var name = document.detailForm.marketName.value;
	var intro = document.detailForm.marketIntro.value;
	var addr = document.detailForm.marketAddr.value;

	if(name == null || name.length<1)
	{
		alert("상호명은 반드시 입력하여야 합니다.");
		document.detailForm.marketName.focus();
		return;
	}
	if(intro == null || intro.length<1)
	{
		alert("소개는 반드시 입력하여야 합니다.");
		document.detailForm.marketIntro.focus();
		return;
	}
	if(addr == null || addr.length<1)
	{
		alert("사업장 주소는 반드시 입력하셔야 합니다.");
		document.detailForm.marketAddr.focus();
		return;
	}

	document.detailForm.action='/market/addMarket';
	document.detailForm.submit();
}

function resetData()
{
	document.detailForm.reset();
}

function fncCancelMarket()
{
	 if (!confirm("취소 진행 시 정보는 초기화되며, 재신청 시 다시 작성하셔야 합니다. \n취소하시겠습니까?")) 
	 {
	 } else 
	 {
		alert("취소 처리가 되었습니다.");
		document.detailForm.action='/market/deleteMarket?marketNo=${market.marketNo}';
		document.detailForm.submit();
	 }
}
-->
</script>

<!DOCTYPE html>
<html>
	<head>
	<title>입점신청</title>
	<link rel="stylesheet" href="/css/admin.css" type="text/css">
	</head>
	<body bgcolor="#ffffff" text="#000000">
		<form name="detailForm" method="post">
		<input type="hidden" name="userId" value="${user.userId}"/>
			<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
				<tr>
					<td width="15" height="37">
						<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
					</td>
					<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="93%" class="ct_ttl01">입점신청</td>
								<td width="20%" align="right">&nbsp;</td>
							</tr>
						</table>
					</td>
					<td width="12" height="37">
						<img src="/images/ct_ttl_img03.gif"	width="12" height="37"/>
					</td>
				</tr>
			</table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 13px;">
				<c:if test="${!empty market}">
					<tr>
						<td height="1" colspan="3" bgcolor="D6D6D6"></td>
					</tr>
					<tr>
						<td width="104" class="ct_write">
							신청번호
							<imgsrc="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle">
						</td>
						<td bgcolor="D6D6D6" width="1"></td>
						<td class="ct_write01">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width="105">
										${market.marketNo}
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</c:if>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">
						신청자 아이디 
						<imgsrc="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle">
					</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="105">
									${user.userId}
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">
						상호명 
						<imgsrc="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle">
					</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<c:if test="${!empty market}">
									<td width="105">
										${market.marketName}
									</td>
								</c:if>
								<c:if test="${empty market}">
									<td width="105">
										<input type="text" name="marketName" class="ct_input_g" style="width: 100px; height: 19px" maxLength="20">
									</td>
								</c:if>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">
						소개 
						<img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
					</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<c:if test="${!empty market}">
									<td width="105">
										${market.marketIntro}
									</td>
								</c:if>
								<c:if test="${empty market}">
									<td width="105">
										<input type="text" name="marketIntro" class="ct_input_g" style="width: 100px; height: 19px" maxLength="10" minLength="6"/>
									</td>
								</c:if>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">
						사업장 주소 
						<img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
					</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<c:if test="${!empty market}">
									<td width="105">
										${market.marketAddr}
									</td>
								</c:if>
								<c:if test="${empty market}">
									<td width="105">
										<input type="text" name="marketAddr" class="ct_input_g" style="width: 100px; height: 19px" maxLength="10" minLength="6"/>
									</td>
								</c:if>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<c:if test="${!empty market }">
					<tr>
						<td width="104" class="ct_write">
							신청 현황
							<img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
						</td>
						<td bgcolor="D6D6D6" width="1"></td>
						<td class="ct_write01">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<c:if test="${market.manaFlag == 'W'}">
										<td width="105">
											승인 대기중
										</td>
									</c:if>
									<c:if test="${market.manaFlag == 'Y'}">
										<td width="105">
											승인완료 [영업가능]
										</td>
									</c:if>
									<c:if test="${market.manaFlag == 'F'}">
										<td width="105">
											영업중지 [영업 불가능]
										</td>
									</c:if>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td height="1" colspan="3" bgcolor="D6D6D6"></td>
					</tr>
				</c:if>
			</table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
				<tr>
					<td width="53%"></td>
					<td align="right">
					<table border="0" cellspacing="0" cellpadding="0">
						<c:if test="${!empty market }">
							<tr>
								<td width="17" height="23">
									<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
								</td>
								<td background="/images/ct_btnbg02.gif" class="ct_btn01"  style="padding-top: 3px;">
									<a href="javascript:fncCancelMarket();">입점취소</a>
								</td>
								<td width="14" height="23">
									<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
								</td>
								
								<td width="17" height="23">
									<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
								</td>
								<td background="/images/ct_btnbg02.gif" class="ct_btn01"	 style="padding-top: 3px;">
									<a href="javascript:resetData();">이전</a>
								</td>
								<td width="14" height="23">
									<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
								</td>
							</tr>
						</c:if>
						<c:if test="${empty market }">
							<tr>
								<td width="17" height="23">
									<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
								</td>
								<td background="/images/ct_btnbg02.gif" class="ct_btn01"  style="padding-top: 3px;">
									<a href="javascript:fncAddMarket();">입점신청</a>
								</td>
								<td width="14" height="23">
									<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
								</td>
								
								<td width="17" height="23">
									<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
								</td>
								<td background="/images/ct_btnbg02.gif" class="ct_btn01"	 style="padding-top: 3px;">
									<a href="javascript:resetData();">취소</a>
								</td>
								<td width="14" height="23">
									<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
								</td>
							</tr>
						</c:if>
					</table>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>