<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>

<link rel="stylesheet" href="/resources/css/board.css?after">

<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script><!-- jQuery 사용 -->
<style>
.registerForm {
  width:900px;
  height:auto;
  padding: 10px, 10px;
  background-color:#FFFFFF;
  border:4px solid gray;
  border-radius: 20px;
}
.userid, .username, .userpasswd, .userpasswd1, .telno, .email, .zip, .addr1, .addr2, .zipcode, .old_addr {
  width: 80%;
  border:none;
  border-bottom: 2px solid #adadad;
  margin: 5px;
  padding: 10px 10px;
  outline:none;
  color: #636e72;
  font-size:16px;
  height:25px;
  background: none;
}
.addrSearch{
  width: 71%;
  border:none;
  border-bottom: 2px solid #adadad;
  margin: 5px;
  padding: 10px 10px;
  outline:none;
  color: #636e72;
  font-size:16px;
  height:25px;
  background: none;
}
.btn_modify  {
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
.btn_cancel  {
  position:relative;
  left:20%;
  transform: translateX(-50%);
  margin-top: 20px;
  margin-bottom: 10px;
  width:40%;
  height:40px;
  background: pink;
  background-position: left;
  background-size: 200%;
  color:white;
  font-weight: bold;
  border:none;
  cursor:pointer;
  transition: 0.4s;
  display:inline;
}

.imageZone {
	border: 2px solid #92AAB0;
    width: 60%;
    height: auto;
    color: #92AAB0;
    text-align: center;
    vertical-align: middle;
    margin: auto;
  	padding: 10px 10px;
    font-size:200%;
}

</style>

<script>
window.onload = () => {
	$("#job").val("${user.job}").attr("selected","selected");
	
	var checkYn = "${user.gender}";
	if(checkYn == "여성"){
		$("#girl").prop("checked", true);
	} else if(checkYn == "남성"){
		$("#man").prop("checked", true);
	} 
	
	var checkYn = "${user.hobby}";
	if(checkYn == "음악감상"){
		$("#music").prop("checked", true);
		$("#movie").prop("checked", false);
		$("#sport").prop("checked", false);
	} else if(checkYn == "영화보기"){
		$("#music").prop("checked", false);
		$("#movie").prop("checked", true);
		$("#sport").prop("checked", false);
	} else if(checkYn == "스포츠"){
		$("#music").prop("checked", false);
		$("#movie").prop("checked", false);
		$("#sport").prop("checked", true);
	} else if(checkYn == "음악감상,영화보기"){
		$("#music").prop("checked", true);
		$("#movie").prop("checked", true);
		$("#sport").prop("checked", false);
	} else if(checkYn == "음악감상,영화보기,스포츠"){
		$("#music").prop("checked", true);
		$("#movie").prop("checked", true);
		$("#sport").prop("checked", true);
	} else if(checkYn == "영화보기,스포츠"){
		$("#music").prop("checked", false);
		$("#movie").prop("checked", true);
		$("#sport").prop("checked", true);
	} else if(checkYn == "음악감상,스포츠"){
		$("#music").prop("checked", true);
		$("#movie").prop("checked", false);
		$("#sport").prop("checked", true);
	}
	
	
	var imgcheck = "N"; //파일 유효성 검사
	var imgZone = document.querySelector('#imageZone');
	var fileEvent = document.querySelector('#imageFile');

	//imageZone 영역 클릭 시 화면 이변트 처리 (자바스크립트에서는 이벤트 발생 시 이벤트 정보를 담고 있는 event(e)라는 객체를 자동 생성)
	imgZone.addEventListener('click', (e) => {
		fileEvent.click(e) //사용자가 만든 UI를 통해 <input type="file">을 클릭하는 것과 같은 효과
	});

	//파일 선택 창 열기 이벤트(자바스크립트에서 객체는 자신과 더불어 prototype이라고 하는 본인 객체의 도플갱어 형태의 객체를 같이 생성)
	fileEvent.addEventListener('change', (e) => { //선택한 파일 가져오기
		const files = e.target.files; //선택한 파일 정보를 배열 형태로 저장
		showImage(files); //읽어 온 파일 -> 파일 미리보기
	});

	const showImage = (files) => {
		imgZone.innerHTML = "";
		
		const imgFile = files[0];

		//if(imgFile.size > 1024*1024) { alert("1MB 이하 파일만 올려주세요."); return false; }
		if(imgFile.type.indexOf("image") < 0) {
			alert("이미지 파일만 올려주세요");
		
			return false;
		}

		const reader = new FileReader(); //new 연산자를 통해 FileReader() 객체를 reader가 참조(상속)
	
		reader.onload = function(event){ //<img>를 통해 만들어진 element에 이미지를 보낸다는 선언 -> 파일을 읽고 나서 해야할 일
			imgZone.innerHTML = "<img src=" + event.target.result + " id='uploadImg' style='width: 350px; height: auto;'>";
		};
			
		reader.readAsDataURL(imgFile); //실제로 파일을 읽음
	
		imgcheck = "Y";
	}

	btn_modify.addEventListener('click', () => {
		if(username.value == '') {
			alert("이름을 입력하세요.");
			username.focus();
		
			return false;
		}
		//$('#RegistryForm').attr('action', '/user/signup').submit();
		/*document.RegistryForm.action = '/board/signup';
		document.RegistryForm.submit(); */
	
		const gender = document.querySelector('input[name=gender]:checked');
		const hobby = document.querySelectorAll('input[name=hobby]:checked');
	
		let hobbyArray = [];
	
		for(let i = 0; i < hobby.length; i++) {
			hobbyArray.push(hobby[i].value);
		}
	
		const job = document.querySelector('select[name=job] option:checked');
	
		if($("input[name=gender]:radio:checked").length < 1) {
			alert("성별을 선택하세요.");
		
			return false;
		}
		if($("input[name=hobby]:checkbox:checked").length < 1) {
			alert("취미를 선택하세요.");
		
			return false;
		}
		if(job.value === "") {
			alert("직업을 선택하세요.");
		
			return false;
		}
	
		address.value = addr1.value + " " + addr2.value;
	
		if(telno.value == '') {
			alert("전화번호를 입력하세요.");
			telno.focus();
		
			return false;
		}
	
		//전화번호 문자열 정리
		const beforeTelno = telno.value;
		const afterTelno = beforeTelno.replace(/\-/gi,"").replace(/\ /gi,"").trim(); //-나 공백 제거 처리  trim() : 앞뒤 공백

		telno.value = afterTelno;
		 	
		const realEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	
		if(email.value == '') {
			alert("이메일을 입력하세요.");
			email.focus();
		
			return false;
		}
		if(!email.value.match(realEmail)) {
			alert("이메일 주소 형식이 맞지 않습니다.");
			email.focus();
		
			return false;
		}
		if(description.value == '') {
			alert("자기소개를 입력하세요.");
			description.focus();
		
			return false;
		}
		
		document.registerForm.action = '/user/userInfoModify';
		document.registerForm.submit();
	
	});
}

const selectAll = (checkElement) => {
	const checkboxes = document.getElementsByName("hobby");
		
	/* if(document.getElementById('all').checked == true) {
			for(var i = 0; i < document.getElementsByName('hobby').length; i++) {
				document.getElementsByName('hobby')[i].checked = true;
			}
		} else {
			for(var i = 0; i < document.getElementsByName('hobby').length; i++) {
				document.getElementsByName('hobby')[i].checked = false;
			}
		}
	*/
	checkboxes.forEach((checkbox) => {
		checkbox.checked = checkElement.checked;
	});
}
	
/*
$(document).ready(function(){
	$("#userid").change(function(){
		$.ajax({
			url : "/user/idCheck",
			type : "post",
			dataType : "json",
			data : {"userid" : $("#userid").val()},
			success : function(data){
				if(data == 1){
					$("#checkID").html("동일한 아이디가 이미 존재합니다. 새로운 아이디를 입력하세요.");
					$("#userid").val("").focus();					
				} else $("#checkID").html("사용 가능한 아이디입니다.");
			}
		});
	});
});
*/
const searchAddr = () => {
	if(addrSearch.value =='') {
		alert("검색할 주소를 입력하세요.");
		addrSearch.focus();
			
		return false;
	}
	
	window.open(
			"/user/addrSearch?page=1&addrSearch=" + addrSearch.value,
		    "주소검색",
		    "width=850, height=540, top=50, left=50"
		    ); //주소, 창 이름, 창의 크기
}
</script>
</head>

<body>
<div>
	<img id="topBanner" src="/resources/images/logo.jpg">
</div>

<div class="main" align="center">
	<h1>회원 정보 수정</h1><br>
	
	<div class="registerForm">
		<form id="registerForm" name="registerForm" method="POST" enctype="multipart/form-data"><br>
			<input type="file" name="fileUpload" id="imageFile" style="display:none;" />
    		<span style="color:red;">※ 사진 편집을 원하시면 이미지를 클릭해 주세요</span>
    		<div id="imageZone"><img src='/profile/${user.stored_filename}' style='width:300px; height:auto;'></div>
    	
		    <input type="hidden" name="org_filename" value="${user.org_filename}">
	   		<input type="hidden" name="stored_filename" value="${user.stored_filename}">
	    	<input type="hidden" name="filesize" value="${user.filesize}">
	    	<input type="hidden" name="userid" value="${userid}">
	    	<input type="text" id="username" name="username" class="username" value="${user.username}">
		
			<div style="width:80%; text-align:left; position:relative; left:70px; border-bottom:2px solid #adadad; margin:10px; padding:10px">
				성별 : 
					<label><input type="radio" id="man" name="gender" value="남성">남성</label><!-- label: 옆에 글자를 클릭해도 체크 표시됨 -->
					<label><input type="radio" id="girl" name="gender" value="여성">여성</label><br>
				취미 :
					<label><input type="checkbox" id="all" name="all" onclick="selectAll(this)">전체선택</label>
					<label><input type="checkbox" id="music" name="hobby" value="음악감상">음악감상</label>
					<label><input type="checkbox" id="movie" name="hobby" value="영화보기">영화보기</label>
					<label><input type="checkbox" id="sport" name="hobby" value="스포츠">스포츠</label><br>
				직업 :
					<select name="job" id="job">
						<option disabled selected>-- 아래의 내용 중에서 선택</option>
						<option value="회사원">회사원</option>
						<option value="공무원">공무원</option>
						<option value="자영업">자영업</option>
					</select><br>
			</div>
		
			<input type="text" id="old_addr" class="old_addr" name="old_addr" value="주소 : ${user.address}" readonly>
			<input type="text" id="addrSearch" name="addrSearch" class="addrSearch" placeholder="주소를 검색합니다.">
        	<input type="button" id="btn_addrSearch" class="btn_addrSearch" value="주소검색" onclick="searchAddr()">
        	<input type="text" id="zipcode" class="zipcode" name="zipcode" placeholder="우편번호가 검색되어 입력됩니다." readonly>
        	<input type="text" id="addr1" class="addr1" name="addr1" value="${user.address}" disabled>
        	<input type="text" id="addr2" class="addr2" name="addr2" placeholder="상세주소를 입력하세요" >
        	<input type="hidden" id="address" name="address">
        	<input type="text" id="telno" name="telno" class="telno" value="${user.telno}">
        	<input type="text" id="email" name="email" class="email" value="${user.email}">
        	
			<textarea class="input_content" id="description" name="description" palceholder="자기소개를 입력해주세요.">${user.description }</textarea><br>
			
			<input type="button" id="btn_modify" class="btn_modify" value="사용자 정보 수정">
        <input type="button" id="btn_cancel" class="btn_cancel" value="취소" onclick="history.back()">
		</form>		
	</div>
</div>
</body>
</html>