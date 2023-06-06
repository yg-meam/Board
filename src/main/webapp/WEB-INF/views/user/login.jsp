<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>

<link rel="stylesheet" href="/resources/css/board.css?after">

<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/3.1.2/rollups/aes.js"></script>

<script>
window.onload = async() => {
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
	
	let userid = getCookie('userid');
	let password = getCookie('password');
	let authkey = getCookie('authkey');
	
	//로그인 화면 로드시 userid 체크 박스 관리
	if(userid !== undefined) { //userid라는 쿠키가 존재
		document.querySelector("#rememberUserid").checked = true;
		document.querySelector("#userid").value = userid;
	} else { //userid 쿠키가 없을 경우
		document.querySelector("#rememberUserid").checked = false;
	}
	
	//로그인 화면 로드시 password 체크 박스 관리
	if(password !== undefined) { //password라는 쿠키가 존재
		document.querySelector("#rememberPassword").checked = true;

		//Base64로 인코딩 된 password를 디코딩
		const decrypt = CryptoJS.enc.Base64.parse(password);
		const hashData = decrypt.toString(CryptoJS.enc.Utf8);
		
		password = hashData;
		
		document.querySelector("#password").value = password;
	} else { //password 쿠기가 없을 경우
		document.querySelector("#rememberPassword").checked = false;
	}
	
	
	//로그인 화면 로드시 자동 로그인 처리
	//PASS : 이미 쿠키가 생성되어 있는 상태에서 로그인
	if(authkey !== undefined){
		
		let formData = new FormData();
		formData.append("authkey",authkey);
		await fetch('/user/login?autologin=PASS',{
			method : 'POST',
			body : formData
		}).then((response) => response.json())
		  .then((data) => {
			 if(data.message == 'good'){				 
				 document.location.href='/board/list?page=1';
			} else {
				alert("시스템 장애로 자동 로그인이 실패 했습니다.");		 
			}		  
	    }).catch((error)=> { console.log("error = " + error);} );
	}
}

//자동 로그인 체크 관리
const checkRememberMe = () => {
	if(document.querySelector("#rememberMe").checked) {
		document.querySelector("#rememberUserid").checked = false;
		document.querySelector("#rememberPassword").checked = false;
	}
}

//아이디 체크 관리
const checkRememberUserid = () => {
	if(document.querySelector("#rememberUserid").checked) {
		document.querySelector("#rememberMe").checked = false;
	}
}

//패스워드 체크 관리
const checkRememberPassword = () => {
	if(document.querySelector("#rememberPassword").checked) {
		document.querySelector("#rememberMe").checked = false;
	}
}

const loginCheck = async() => {
	/*
	if(document.loginForm.userid.value == ''){
		alert("아이디를 입력하세요");
		return false;
	}
	if(document.loginForm.password.value == ''){
		alert("패스워드를 입력하세요");
		return false;
	}
	document.loginForm.action = '/user/login';
	document.loginForm.submit();
	*/
	
	//유효성 검사
	if(userid.value === "" || userid.value === null) {
		alert("아이디를 입력하세요");
		userid.focus();
		
		return false;
	}
	if(password.value === "" || password.value === null) {
		alert("패스워드를 입력하세요");
		password.focus();
		
		return false;
	}
	
	let formData = new FormData();
	formData.append("userid", userid.value);
	formData.append("password", password.value);
	
	//NEW : 로그인하면서 쿠키 새로 생성
	await fetch("/user/login?autologin=NEW", {
		method: "POST",
		body: formData
	}).then((response) => response.json())
	.then((data) => {
		if(data.message === "good") {
			cookieManage(userid.value, password.value, data.authkey);
			
			document.location.href = "/board/list?page=1";
		} else if(data.message === "ID_NOT_FOUND") {
			msg.innerHTML = "존재하지 않는 아이디입니다.";
		} else if(data.message === "PASSWORD_NOT_FOUND") {
			msg.innerHTML = "잘못된 패스워드입니다.";
		} else if(data.message === "CHANGE_PASSWORD") {
			document.location.href = "/user/pwCheckNotice";
		} else if(data.message === "NOT_CHANGE_PASSWORD") {
			document.location.href = "/board/list?page=1";
		} else {
			alert("시스템 장애로 로그인 실패");
		}
	}).catch((error) => {
		console.log("error = " + error);
	});
}

const press = () => {
	if(event.keyCode == 13){loginCheck();}

}

//쿠키 관리 -> 쿠키 생성, 삭제
const cookieManage = (userid, password, authkey) => {
	//rememberMe(자동로그인)가 체크시 쿠키 생성
	if(rememberMe.checked) {
		document.cookie = "authkey=" + authkey + "; path=/; expires=Sun, 31 Dec 2023 23:59:59 GMT";
	} else { //rememberMe(자동로그인)의 체크 해제하면 쿠키 삭제
		document.cookie = "authkey=" + authkey + "; path=/; max-age=0";
	}
	
	//rememberUserid(아이디기억) 쿠키 관리
	if(rememberUserid.checked) {
		document.cookie = "userid=" + userid + "; path=/; expires=Sun, 31 Dec 2023 23:59:59 GMT";
	} else { //아이디기억의 체크 해제하면 쿠키 삭제
		document.cookie = "userid=" + userid + "; path=/; max-age=0";
	}
	
	//rememberPassword(패스워드기억) 쿠키 관리
	//Base 64(양방향 복호화 64비트 알고리즘)
	const key = CryptoJS.enc.Utf8.parse(password);
	const base64 = CryptoJS.enc.Base64.stringify(key);
	
	password = base64;
	
	if(rememberPassword.checked) {
		document.cookie = "password=" + password + "; path=/; expires=Sun, 31 Dec 2023 23:59:59 GMT";
	} else { //rememberMe(자동로그인)의 체크 해제하면 쿠키 삭제
		document.cookie = "password=" + password + "; path=/; max-age=0";
	}
}
</script>
</head>
<body>
<div class="main" align="center">

  <div>
    <img id="topBanner" src ="/resources/images/logo.jpg" title="서울기술교육센터" >
  </div>
  
	<div class="login">
		<h1>로그인</h1>
		<form name="loginForm" id="loginForm" class="loginForm" method="post"> 

			<input type="text" name="userid" id="userid" class="userid" placeholder="아이디를 입력하세요.">
         	<input type="password" id="password" name="password" class="userpasswd" onkeydown="press(this.form)" placeholder="비밀번호를 입력하세요.">
         	<p id="msg" style="color: red; text-align: center;"></p>
         	<br>
         	<label><input type="checkbox" id="rememberUserid" onclick="checkRememberUserid()">아이디 기억</label>
         	<label><input type="checkbox" id="rememberPassword" onclick="checkRememberPassword()">패스워드 기억</label>
         	<label><input type="checkbox" id="rememberMe" onclick="checkRememberMe()">자동 로그인</label>
         	<br><br>
         	<a href="/user/searchID">[아이디 찾기]</a>&nbsp;&nbsp;
         	<a href="/user/searchPassword">[비밀번호 찾기]</a><br><br>
     		<input type="button" id="btn_login" class="login_btn" value="로그인" onclick="loginCheck()"><br><br>
     		<input type="button" id="btn_signup" class="login_btn" value="회원가입" onclick="location.href='/user/signup';"><br><br>
		</form>
	</div>
 
</div>



</body>
</html>