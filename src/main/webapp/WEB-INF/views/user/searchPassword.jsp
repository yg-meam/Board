<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>패스워드 찾기</title>

<link rel="stylesheet" href="/resources/css/board.css?after">

<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script><!-- jQuery 사용 -->

<script>
const pwSearchCheck = () => {
	if(userid.value == "") {
		alert("아이디를 입력하세요.");
		userid.focus();
		
		return false;
	}
	if(username.value == '') {
		alert("이름을 입력하세요.");
		username.focus();
		
		return false;
	}
	
	//$("#pwSearchForm").attr("action", "/user/searchPassword").submit();
	document.pwSearchForm.action = '/user/searchPassword';
	document.pwSearchForm.submit();
}

const press = () => {
	if(event.keyCode == 13) {
		pwSearchCheck();
	}
}

</script>
<style>
.userid, .username {
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

.pwSearchForm {
  width:900px;
  height:auto;
  padding: 20px, 20px;
  margin: auto;
  background-color:#FFFFFF;
  text-align:center;
  border:5px solid gray;
  border-radius: 30px;
}
</style>
</head>

<body>
<div>
    <img id="topBanner" src ="/resources/images/logo.jpg" title="서울기술교육센터" >
</div>

<div class="main" align="center">
	<form name="pwSearchForm" class="pwSearchForm" id="pwSearchForm" method="post">
    <h1>임시 패스워드 발급</h1>
    
     	<div class="pwSearchFormDivision">
         	<input type="text" name="userid" id="userid" class="userid" placeholder="아이디를 입력하세요.">
         	<input type="text" id="username" name="username" class="username" onkeydown="press(this.form)" placeholder="이름을 입력하세요.">
      		<c:if test="${msg == 'PASSWORD_NOT_FOUND'}"><p style="text-align: center; color:red;">입력한 조건에 맞는 사용자가 존재하지 않습니다. 다시 입력하세요 !!!</p></c:if>
         	
         	<input type="button" id="btn_pwSearch" class="btn_pwSearch" value="임시 패스워드 발급" onclick="pwSearchCheck()"> 
         	<input type="button" class="btn_cancel" value="취소" onclick="javascript:location.href='/'">
        </div> 
	</form>
</div>
</body>
</html>