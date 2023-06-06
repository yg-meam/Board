<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 등록</title>

<link rel="stylesheet" href="/resources/css/board.css?after">

<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script><!-- jQuery 사용 -->

<script>
window.onload = () => {
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

	btnRegister.addEventListener('click', async () => {
		if(imgcheck == "N") {
			alert("사진을 넣어주세요.");
		
			return false;
		}
		if(userid.value == '') {
			alert("아이디를 입력하세요.");
			userid.focus();
		
			return false;
		}
		if(username.value == '') {
			alert("이름을 입력하세요.");
			username.focus();
		
			return false;
		}
	
		const Pass = password.value;
		const Pass1 = password1.value;
	
		if(Pass == '') {
			alert("암호를 입력하세요.");
			password.focus();
		
			return false;
		}
		if(Pass1 == '') {
			alert("암호를 입력하세요.");
			password1.focus();
		
			return false;
		}
		if(Pass != Pass1) {
			alert("입력된 비밀번호를 확인하세요");
			password1.focus();
		
			return false;
		}
	
		// 암호유효성 검사
		//자바스크립트의 정규식
		let num = Pass.search(/[0-9]/g); // [0~9] : 0~9까지의 숫자가 들어 있는지 검색 -> 검색되지 않으면 -1 반환, g : 글로벌 검색
		let eng = Pass.search(/[a-z]/ig); //i : 알파벳 대소문자 구분 없이 검색 -> 검색되지 않으면 -1 반환
		let spe = Pass.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi); //특수문자가 포함되어 있는지 검색
	
		if(Pass.length < 8 || Pass.length > 20) {
			alert("암호는 8자리 ~ 20자리 이내로 입력해주세요.");
		
			return false;
		} else if(Pass.search(/\s/) != -1) {
			alert("암호는 공백 없이 입력해주세요.");
		
			return false;
		} else if(num < 0 || eng < 0 || spe < 0 ){
			alert("암호는 영문,숫자,특수문자를 혼합하여 입력해주세요.");
		
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
		if(zipcode.value == '') {
			alert("우편번호를 입력하세요.");
			zipcode.focus();
		
			return false;
		}
		if(addr2.value == '') {
			alert("상세 주소를 입력하세요.");
			addr2.focus();
		
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
	 
		let formData = new FormData(RegistryForm); //비동기 방식으로 값을 보냄
		//document.RegistryForm.action = "";
		//document.RegistryForm.submit();
	
		/*
		const data = {
			userid: userid.value,
	 		username: username.value,
	 		password: password.value,
	 		gender: gender.value,
	 		hobby: hobbyArray.toString(),
	 		job: job.value,
	 		description: description.value,
	 		zipcode: zipcode.value,
	 		address: address.value,
	 		telno: telno.value,
	 		email: email.value
		}
		*/
		await fetch('/user/signup', {
	 		//headers: {
	 		//	"content-type": "application/json"
	 		//},
			method: 'POST',
			body: formData, //JSON.stringify(data)
		}).then((response) => response.json())
 		.then((data) => {
 			if(data.status === 'good') {
 				alert(decodeURIComponent(data.username) + "님 회원가입을 축하 드립니다.");
	 			
 				document.location.href="/board/list?page=1";
	 		} else {
	 			alert("서버 장애로 회원가입 실패");
	 		}
 		})
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
const idCheck = async () => {
	const userid = document.querySelector("#userid");
		
	await fetch('/user/idCheck',{
		method: "POST",
		body: userid.value,		
	}).then((response) => response.text())
	.then((data) => {
		const idCheckNotice = document.querySelector('#idCheckNotice');
				
		if(data == 0) {
			idCheckNotice.innerHTML = "사용 가능한 아이디입니다.";
		} else {
			idCheckNotice.innerHTML = "이미 사용중인 아이디입니다.";
			
			userid.focus();
		}
	});
}
	
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
	<h1>회원 등록</h1><br>
	
	<div class="WriteForm">
		<form id="RegistryForm" name="RegistryForm" method="POST"><br>
			<input type="file" name="fileUpload" id="imageFile" style="display:none;" />
    		<div class="imageZone" id="imageZone">클릭 후 탐색창에서 사진을 <br>선택해 주세요.</div><br>
    	
			<input type="text" class="input_field" id="userid" name="userid" placeholder="여기에 아이디를 입력해 주세요." onchange="idCheck()"><br>
			<p id="idCheckNotice" style="color:red;text-align:center;"></p>
			<input type="text" class="input_field" id="username" name="username" placeholder="여기에 이름을 입력해 주세요.">
			<input type="password" class="input_field" id="password" name="password" placeholder="여기에 비밀번호를 입력해 주세요.">
			<input type="password" class="input_field" id="password1" name="password1" placeholder="다시 한 번 비밀번호를 입력해 주세요.">
		
			<div style="width:90%; text-align:left; position:relative; left:35px; border-bottom:2px solid #adadad; margin:10px; padding:10px">
				성별 : 
					<label><input type="radio" name="gender" value="남성">남성</label><!-- label: 옆에 글자를 클릭해도 체크 표시됨 -->
					<label><input type="radio" name="gender" value="여성">여성</label><br>
				취미 :
					<label><input type="checkbox" id="all" name="all" onclick="selectAll(this)">전체선택</label>
					<label><input type="checkbox" name="hobby" value="음악감상">음악감상</label>
					<label><input type="checkbox" name="hobby" value="영화보기">영화보기</label>
					<label><input type="checkbox" name="hobby" value="스포츠">스포츠</label><br>
				직업 :
					<select name="job">
						<option disabled selected>-- 아래의 내용 중에서 선택</option>
						<option value="회사원">회사원</option>
						<option value="공무원">공무원</option>
						<option value="자영업">자영업</option>
					</select><br>
			</div>
		
			<input type="text" id="addrSearch" name="addrSearch" class="addrSearch" placeholder="주소를 검색합니다.">
        	<input type="button" id="btn_addrSearch" class="btn_addrSearch" value="주소검색" onclick="searchAddr()">
        	<input type="text" id="zipcode" class="input_field" name="zipcode" placeholder="우편번호가 검색되어 입력됩니다." readonly>
        	<input type="text" id="addr1" class="input_field" name="addr1" placeholder="주소가 검색되어 입력됩니다." readonly>
        	<input type="text" id="addr2" class="input_field" name="addr2" placeholder="상세주소를 입력하세요" >
        	<input type="hidden" id="address" name="address">
        	<input type="text" id="telno" name="telno" class="input_field" placeholder="전화번호를 입력하세요.">
        	<input type="text" id="email" name="email" class="input_field" placeholder="이메일주소를 입력하세요.">
        	<p style="color:red;">일반 사용자 권한으로 등록됩니다.</p><br>
			
			<textarea class="input_content" id="description" cols="100" rows="500" name="description" palceholder="자기소개를 입력해주세요."></textarea><br>
			
			<input type="button" class="btn_write" value="회원가입" id="btnRegister">
		</form>		
	</div>
</div>
</body>
</html>