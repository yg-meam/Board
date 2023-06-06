<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>게시물 목록</title>

<link rel="stylesheet" href="/resources/css/board.css?after">

<script>
const search = () => {
	const keyword = document.querySelector('#keyword');
		
	//keyword.value = encodeURIComponent(keyword.value);
		
	document.location.href = "/board/list?page=1&keyword=" + keyword.value;
}
	
const logout = () => {
	if(confirm("로그아웃하시겠습니까?")) {
		//자동로그인 시에만 해당
		let authkey = getCookie("authkey");
			
		if(authkey !== undefined) {
			document.cookie = "authkey=" + authkey + "; path=/; max-age=0";
		}
			
		document.location.href = "/user/logout";
	}
}
	
//쿠키값 가져오기
const getCookie = (name) => {
const cookies = document.cookie.split(`; `).map((el) => el.split('='));
	let getItem = [];
		
	for(let i = 0; i < cookies.length; i++) {
		if(cookies[i][0] === name) {
			getItem.push(cookies[i][1]);
				
			break;
		}
	}
		
	if(getItem.length > 0) {
		console.log(getItem[0]);
		return decodeURIComponent(getItem[0]);
	}
}
	
//enter키 누르면 넘어감
const press = () => {
	if(event.keyCode == 13) {
		search();
	}
}
</script>
</head>

<body>
<!-- 사용자 권한 -->
<%
	String userid = (String)session.getAttribute("userid");
	if(userid == null) response.sendRedirect("/");
%>

<div>
	<img id="topBanner" src="/resources/images/logo.jpg" title="서울기술교육센터">
</div>

<div class="tableDiv">
	<h1>게시물 목록</h1>
	<input style="width: 30%; height: 30px; border: 2px solid #168; font-size: 16px;" type="text" name="keyword" id="keyword" placeholder="검색할 제목, 작성자 이름 및 내용을 입력해 주세요" onkeydown="press()">
	<input style="width: 5%; height: 30px; background: #158; font-size: 16px; color: white; font-weight: bold; cursor: pointer;" type="button" value="검색" onclick="search()"><br><br>
	
	<table class="InfoTable">
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작서일</th>
			<th>조회수</th>
		</tr>
		
		<tbody>
		<c:if test="${list != null}">
			<c:forEach items="${list }" var="list"> <!-- 데이터베이스가 반복되는 부분 -->
				<tr onmouseover="this.style.background='#45D2D2'" onmouseout="this.style.background='red'"></tr>
					<td>${list.seq }</td>
					<td style="text-align:left">
						<a id="hypertext" href="/board/view?seqno=${list.seqno }&page=${page }&keyword=${keyword}" onmouseover="this.style.textDecoration='underline'" onmouseout="this.style.textDecoration='none'">${list.title }</a>
					</td>
					<td>${list.writer }</td>
					<td>${list.regdate }</td>
					<td>${list.hitno }</td>
			</c:forEach>
		</c:if>
		<c:if test="${list == null}">
			<tr>
				<td colspan="5">입력된 게시물이 없습니다.</td>
			</tr>
		</c:if>
		</tbody>
	</table>
	
	<div>${pageList }</div>
	<div class="bottom_menu">
		<a href="/board/write">글쓰기</a>&nbsp;&nbsp;
		<a href="/board/list?page=1">처음으로</a>&nbsp;&nbsp;
		<a href="/user/userinfo">사용자관리</a>&nbsp;&nbsp;
		<c:if test="${role == 'MASTER' }">
			<a href="/master/sysmanage">시스템관리</a>&nbsp;&nbsp;
		</c:if>
		<a href="javascript:logout()">로그아웃</a>
	</div>	
</div>
</body>
</html>