<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>

<link rel="stylesheet" href="/resources/css/board.css?after">

<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<style>   
#IDSearchResult {
  width:900px;
  height:auto;
  padding: 20px, 20px;
  background-color:#FFFFFF;
  text-align:center;
  border:5px solid gray;
  border-radius: 30px;
  margin: auto;
}   

#btn_goHome  {
  position:relative;
  left:40%;
  transform: translateX(-50%);
  margin-bottom: 40px;
  width:80%;
  height:40px;
  background: linear-gradient(125deg,#81ecec,#6c5ce7,#81ecec);
  background-position: left;
  background-size: 200%;
  color:white;
  font-weight: bold;
  border:none;
  cursor:pointer;
  transition: 0.4s;
  display:inline;
}
</style>
</head>

<body>
<div>
	<img id="topBanner" src ="/resources/images/logo.jpg" title="서울기술교육센터">
</div>

<div class="main" align="center">
	<div id="IDSearchResult"><br><br>
		<h1>아이디 : ${userid}</h1><br><br>
     	<a href="/user/searchPassword">[비밀번호 찾기]</a><br><br>
       	<button id="btn_goHome" onclick="location.href='/'">로그인</button>
  	</div> 
</div>
</body>
</html>