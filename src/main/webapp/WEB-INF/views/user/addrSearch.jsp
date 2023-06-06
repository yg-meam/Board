<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주소 검색</title>

<link rel="stylesheet" href="/resources/css/board.css?after">

<script>
const addrCheck = (zipcode, newaddr) => {
	window.opener.document.getElementById("zipcode").value = zipcode; //선택한 우편번호 불러옴
	window.opener.document.getElementById("addr1").value = newaddr; //선택한 주소 불러옴
	window.close();
}
</script>
</head>

<body>
<div class="tableDiv">
	<h1>주소 검색</h1>
	
	<table class="InfoTable">
  		<tr>
   			<th>우편번호</th>
   			<th>주소</th>
   			<th>선택</th>
  		</tr>

 		<tbody>
 		<c:if test="${list != null}">
			<c:forEach items="${list}" var="list">
			 	<tr onMouseover="this.style.background='#46D2D2';" onmouseout="this.style.background='white';">
					<td>${list.zipcode}</td>
					<td style="text-align:left;">${list.province}${list.road}${list.building}<br>${list.oldaddr}</td>  
					<td><input type="button" value="선택" onclick="addrCheck('${list.zipcode}','${list.province}${list.road}${list.building}');"></td>
				</tr>
			</c:forEach>
		</c:if>
		
		<c:if test="${list == null}">
			<tr>
				<td colspan="3">검색된 주소가 없습니다.</td>
			</tr>
		</c:if>
		</tbody>
	</table>

	<div>
		${pageListView}
	</div>
</div>
</body>
</html>