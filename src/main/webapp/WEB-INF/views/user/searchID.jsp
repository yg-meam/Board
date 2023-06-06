<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>

<link rel="stylesheet" href="/resources/css/board.css?after">

<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/3.1.2/rollups/aes.js"></script>

<script>
const IDSearchCheck = () => {
	if(username.value == "") {
		alert("이름을 입력하세요.");
		username.focus();
		
		return false;
	}
	if(telno.value == '') {
		alert("전화번호를 입력하세요.");
		telno.focus();
		
		return false;
	}
	
	//$("#IDSearchForm").attr("action", "/user/searchID").submit();
	document.IDSearchForm.action = '/user/searchID';
	document.IDSearchForm.submit();
}

const press = () => {
	if(event.keyCode == 13) {
		pwSearchCheck();
	}
}
</script>
<style>
.IDSearchForm {
  width:900px;
  height:auto;
  padding: 20px, 20px;
  margin:auto;
  background-color:#FFFFFF;
  text-align:center;
  border:5px solid gray;
  border-radius: 30px;
}

.username, .telno {
  width: 80%;
  border:none;
  border-bottom: 2px solid #adadad;
  margin: 10px;
  padding: 10px 10px;
  outline:none;
  color: #636e72;
  font-size:16px;
  height:25px;
  background: none;
}

.btn_IDSearch  {
    position:relative;
    left:20%;
    transform: translateX(-50%);
    margin-top: 20px;
    margin-bottom: 10px;
    width:40%;
    height:40px;
    background: red;
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
	<img id="topBanner" src ="/resources/images/logo.jpg" title="서울기술교육센터" >
</div>

<div class="main" align="center">
	<form name="IDSearchForm" class="IDSearchForm" id="IDSearchForm" method="post">
        <h1>아이디 찾기</h1>
        
     	<div class="IDSearchFormDivision">
         	<input type="text" name="username" id="username" class="username" placeholder="이름을 입력하세요.">
         	<input type="text" id="telno" name="telno" class="telno" onkeydown="press(this.form)" placeholder="전화번호를 입력하세요.">
         	<c:if test="${msg == 'ID_NOT_FOUND'}">
         		<p style="text-align: center; color:red;">입력한 조건에 맞는 사용자가 존재하지 않습니다. 다시 입력하세요 !!!</p>
         	</c:if>
         	
         	<input type="button" id="btn_IDSearch" class="btn_IDSearch" value="아이디 찾기" onclick="IDSearchCheck()"> 
            <input type="button" class="btn_cancel" value="취소" onclick='javascript:location.href="/"'> 
     	</div> 
	</form>
</div>
</body>
</html>