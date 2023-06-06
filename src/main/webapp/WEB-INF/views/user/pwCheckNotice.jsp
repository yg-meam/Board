<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경 확인</title>

<link rel="stylesheet" href="/resources/css/board.css?after">

</head>

<body>
<div class="NoticeDivision">
	<h1><p style="text-align: center;">패스워드를 변경해 주세요.</p><br></h1>
		
	<input type="button" class="after_30" value="30일 후에 변경" onclick="location.href='/user/userPasswordModifyAfter30'">
    <input type="button" class="now_change" value="지금 변경" onclick="location.href='/user/userPasswordModify'">
</div>
</body>
</html>