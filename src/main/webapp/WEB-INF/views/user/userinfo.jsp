<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보</title>

<link rel="stylesheet" href="/resources/css/board.css?after">

</head>

<body>
<div>
	<img id="topBanner" src="/resources/images/logo.jpg">
</div>

<div class="main" align="center">
	<h1>회원 정보</h1><br>
	
	<div class="boardView">
		<div class="imgView" style="width: 60%; height: auto; margin: auto; vertical-align: middle; padding: 10px 10px;"><img src="/profile/${user.stored_filename }" style="width: 350px; height: auto; padding: 10px 10px;"></div>
		<div class="field">아이디 : ${user.userid }</div>
		<div class="field">이름 : ${user.username }</div>
		<div class="field">성별 : ${user.gender }</div>
		<div class="field">취미 : ${user.hobby }</div>
		<div class="field">직업 : ${user.job }</div>
		<div class="field">전화번호 : ${user.telno }</div>
		<div class="field">email : ${user.email }</div>
		<div class="content">${user.description }</div>
	</div>
	
	<div class="bottom_menu" align="center">
		
		&nbsp;&nbsp;<a href="/board/list?page=1">처음으로</a>&nbsp;&nbsp;
		<a href="/user/userInfoModify">기본정보 수정</a>&nbsp;&nbsp;
		<a href="/user/userPasswordModify">패스워드 변경</a>&nbsp;&nbsp;
		<a href="javascript:userInfoDelete()">회원탈퇴</a>
	</div>
</div>
</body>
</html>