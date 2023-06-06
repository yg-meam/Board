<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>게시물 등록</title>

<link rel="stylesheet" href="/resources/css/board.css?after">

<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<script>
/*
$(document).ready(function(){ 
	var objDragAndDrop = $("#fileClick");
	//input type=file에 onchange 발생 이벤트
	$("#input_file").on("change", function(e) {
		//본 이벤트는 file 타입으로 파일을 받는게 아니라 드래그앤드랍 같이 다른 이벤트 형식을 통해 file을 받는 것으로 이런 경우는 OriginalEvent를 이용하여 파일 정보를 받아야 함.
		var files = e.originalEvent.target.files; 
    	fileCheck(files);
	});

	//fileClick 영역 클릭 시 이벤트 --> file 이벤트의 파일탐색창 열기가 실행 
	objDragAndDrop.on('click',function (e){
        $('#input_file').trigger('click');
    });
	
	//dragenter(마우스가 대상 객체의 위로 처음 진입할 때 발생하는 이벤트)가 발생하면 
	//e.stopPropagation(), e.preventDefault()를 사용하여 웹브라우저의 기본 동작을 중지시키고 이벤트 전파를 중단
	//e.preventDefault는 고유 동작을 중단시키고, e.stopPropagation 는 상위 엘리먼트들로의 이벤트 전파를 중단
	$(document).on("dragenter","#fileClick",function(e){
    	e.stopPropagation(); 
    	e.preventDefault();
    	$(this).css('border', '2px solid #0B85A1');
    });

	//dragover(드래그하면서 마우스가 대상 객체의 위에 자리 잡고 있을 때 발생하는 이벤트)가 발생하면 
	//e.stopPropagation(), e.preventDefault()를 사용하여 웹브라우저의 기본 동작을 중지시키고 이벤트 전파를 중단
	//e.preventDefault는 고유 동작을 중단시키고, e.stopPropagation 는 상위 엘리먼트들로의 이벤트 전파를 중단
	$(document).on("dragover","#fileClick",function(e){
    	e.stopPropagation();
    	e.preventDefault();
	});
	
	//fileClick 영역에 파일 Drop시 e.preventDefault()를 사용하여 웹브라우저의 기본 동작을 중지시키고
	//e.originalEvent.dataTransfer.files를 실행 시켜 파일 정보를 var files에 입력
	$(document).on("drop","#fileClick",function(e){
        e.preventDefault();
    	var files = e.originalEvent.dataTransfer.files;
	    fileCheck(files);
	});

});
*/
window.onload = () => {
	const fileZone = document.querySelector("#fileZone");
	const inputFile = document.querySelector("#inputFile");
	
	//fileZone을 클릭하면 발생하는 이벤트
	fileZone.addEventListener("click", (e) => {
		inputFile.click(e);
	});
	
	//파일 탐색창을 열어 선택한 파일 정보를 files에 할당
	inputFile.addEventListener("change", (e) => {
		const files = e.target.files;
		
		fileCheck(files);
	});
	
	//마우스 이벤트
	//dragstart : 사용자가 객체를 드래그할려고 시작할 때 발생하는 이벤트
	//drag : 대상 객체를 드래그하면서 마우스를 움직일 때 발생하는 이벤트
	//dragenter : 마우스가 대상 객체의 안으로 처음 진입할 때 발생하는 이벤트
	//dragover : 드래그 하면서 마우스가 대상 객체의 영역 안에 자리 잡고 있을 때 발생하는 이벤트
	//drop : 드래그가 끝나서 드래그 하던 객체를 놓는 장소에 위치한 객체에서 발생하는 이벤트
	//dragleave : 드래그가 끝나서 마우스가 대상 객체의 안에서 벗어날 때 발생하는 이벤트
	//dragend : 대상 객체를 드래그하다가 마우스 버튼을 놓는 순간 발생하는 이벤트
	
	//fileZone으로 dragenter 이벤트 발생 시
	fileZone.addEventListener("dragenter", (e) => {
		e.stopPropagation(); //웹 브라우저의 고유 동작을 중단(세트)
		e.preventDefault(); //상위 엘레먼트들로의 이벤트 전파를 중단(세트)
		
		fileZone.style.border = "2px solid #0B85A1"; //dragenter발생할 때 생기는 효과
	});
	
	//fileZone으로 dragover 이벤트 발생 시
	fileZone.addEventListener("dragover", (e) => {
		e.stopPropagation(); //웹 브라우저의 고유 동작을 중단(세트)
		e.preventDefault(); //상위 엘레먼트들로의 이벤트 전파를 중단(세트)
	});
	
	//fileZone으로 drop 이벤트 발생 시
	fileZone.addEventListener("drop", (e) => {
		e.stopPropagation(); //웹 브라우저의 고유 동작을 중단(세트)
		e.preventDefault(); //상위 엘레먼트들로의 이벤트 전파를 중단(세트)
		
		const files = e.dataTransfer.files;
		
		fileCheck(files);
	});
}

var uploadCountLimit = 5; // 업로드 가능한 파일 갯수
var fileCount = 0; // 파일 현재 필드 숫자 totalCount랑 비교값
var fileNum = 0; // 파일 고유넘버 -> 삭제할 때 사용
var content_files = new Array(); // 첨부파일 배열
var rowCount=0; //홀짝으로 바뀜

const fileCheck = (files) => {
	//배열로 변환
	//prototype : 자바스크립트에서는 사용자가 새로운 객체 또는 함수를 만들때 자동으로 prototype이 만들어지고 여기에 Object 객체를 상속하게 함.
	//			  기존 내장 객체(Array, FormData,...)도 본인 객체 외에 prototype을 가지고 있음
	
	//유사배열 형태를 띄고 있는 객체를 배열로 전환
	//var filesArr = Array.prototype.slice.call(files); 
	let filesArr = Object.values(files); //ECMAScript 2017년 버전부터 적용
	
    // 파일 개수 확인 및 제한
    if (fileCount + filesArr.length > uploadCountLimit) {
      	alert('파일은 최대 '+uploadCountLimit+'개까지 업로드 할 수 있습니다.');
      	
      	return;
    } else {
    	 fileCount = fileCount + filesArr.length;
    }

	filesArr.forEach((file) => {
		//FileReader() : 웹 애플리케이션이 비동기적으로 웹 브라우저에서 파일을 읽을 때 사용하며 <input type=file>태그를 이용하여 사용자가 선택한 파일들의 결과로 변환된 FileList 객체나 Drag&Drop 이벤트로 변환된 DataTransfer 객체로부터 데이터를 얻음
	      var reader = new FileReader();
		
	      reader.readAsDataURL(file); //파일 읽기
	      
	      //reader.readAsDataURL(file) 실행으로 파일 읽기가 성공적으로 수행되고 난 후 reader.onload 이벤트 핸들러 내의 콜백 함수가 비동기적으로 실행
	      reader.onload = (e) => { //추가로 파일을 추가할 때 배열로 파일 읽어오기
	        content_files.push(file);
			
	        if(file.size > 1073741824) { alert('파일 사이즈는 1GB를 초과할수 없습니다.'); return; }
		
	    	rowCount++;
	    	
	        var row="odd"; //홀수
	        
	        if(rowCount %2 ==0) {
	        	row ="even"; //짝수
	        }
	        
	        let statusbar = document.createElement("div"); //<div> 만들기
	        
	        statusbar.setAttribute("class", "statusbar " + row); //<div class="statusbar odd"></div>
	        statusbar.setAttribute("id", "file" + fileNum); //<div clas="statucsbar odd" id="file0"></div>
	        //var statusbar = $("<div class='statusbar "+row+"' id='file" + fileNum +"'></div>");
	        
	        //statusbar 내의 파일명
	        let filename = "<div class='filename'>" + file.name + "</div>";
	        //var filename = $("<div class='filename'>" + filesArr[i].name + "</div>").appendTo(statusbar);
	        
	        //statusbar 내의 파일 사이즈
	        let sizeStr="";
	        let sizeKB = file.size/1024;
	        
	        if(parseInt(sizeKB) > 1024) {
	        	var sizeMB = sizeKB/1024;
	            sizeStr = sizeMB.toFixed(2)+" MB";
	        } else {
	        	sizeStr = sizeKB.toFixed(2)+" KB";
	        }
	        
	        let size = "<div class='filesize'>" + sizeStr + "</div>";
	        
	        //statusbar의 삭제 버튼
	        var btn_delete = "<div class='btn_delete'><input type='button' value='삭제' onclick=fileDelete('file" + fileNum + "')></div>";
	        
	        statusbar.innerHTML = filename + size + btn_delete;
	        
	        fileUploadList.appendChild(statusbar);
			
	        fileNum ++;
       
	        console.log(file);
	      };
    });
	//$("#input_file").val("");	
	inputFile.value ="";
}

const fileDelete = (fileNum) => {
    var no = fileNum.replace(/[^0-9]/g, "");
    
    content_files[no].is_delete = true;
    
	document.querySelector("#" + fileNum).remove();
    //$('#' + fileNum).remove();
    
	fileCount --;
}

const registerForm = async() => {
	if(writer.value=='') {
		alert("이름을 입력하세요!!!");
		writer.focus();
		return false;
	}
	if(title.value=='') {
		alert("제목을 입력하세요!!!");
		title.focus();
		return false;
	}
	if(content.value=='') {
		alert("내용을 입력하세요!!!");
		content.focus();
		return false;
	}
	
	let uploadURL = '';
	
	//첨부된 파일이 있을 경우 
	if(content_files.length != 0) {
		uploadURL = '/board/fileUpload?kind=I';
	} else {
		uploadURL = '/board/write';
	}
	
	let wForm = document.getElementById('WriteForm');
 	let formData = new FormData(wForm);
 	
	for(let i = 0; i < content_files.length; i++) {
		if(!content_files[i].is_delete) { //배열 요소에 
			formData.append("SendToFileList", content_files[i]); //formData는 배열 자체를 보내지 못하고 하나씩 쪼개서 보내야함
		}
	}

	/*
	$.ajax({ //jQuery 방식으로 비동기식
        url: uploadURL,
        type: "POST",
        contentType:false,
        processData: false,
        cache: false,
        enctype: "multipart/form-data",
        data: formData,
        success: function(data){
        	alert("게시물이 등록되었습니다.\n게시물 목록 화면으로 이동합니다.");
			document.location.href='/board/list?page=1';	
        },
        error: function (error) {
       	    	alert("서버오류로 게시물 등록이 실패하였습니다. 잠시 후 다시 시도해주시기 바랍니다.");
       	     return false;
       	}   
       
    });
	*/
	await fetch(uploadURL, {
		method: "POST",
		body: formData
	}).then((response) => response.json())
	.then((data) => {
		if(data.message == "good") {
			alert("게시물이 등록되었습니다.");
			
			document.location.href="/board/list?page=1";
		}
	}).catch((error) => {
		alert("시스템 장애로 게시물 등록 실패");
		console.log("error= " + error);
	});
}
</script>

<style>
.fileUploadList {
	border: solid #adadad;
	width: 97%;
	height: auto;
	padding: 5px;
	font-size: 120%;
}

.btn_delete{
  -moz-border-radius:4px;
  -webkit-border-radius:4px;
  border-radius:4px;display:inline-block;
  color:#fff;
  font-family:arial;font-size:13px;font-weight:normal;
  padding:4px 15px;
  cursor:pointer;
  vertical-align:top
}
</style>
</head>

<body>
<%
	String userid = (String)session.getAttribute("userid");
	String username = (String)session.getAttribute("username");
	String role = (String)session.getAttribute("role");
	
	if(userid == null) response.sendRedirect("/");
%>

<div>
	<img id="topBanner" src ="/resources/images/logo.jpg" title="서울기술교육센터" >
</div>

<div class="main" align="center">
	<div class="WriteDiv">
		<h1>게시물 등록</h1><br>
	
		<form id="WriteForm" method="POST" >
			<input type="text" class="writer" value="작성자 : <%=username %> 님" disabled>
			<input type="text" class="title" id="title" name="title"  placeholder="여기에 제목을 입력하세요">
			<input type="hidden" id="writer" name="writer" value="<%=username %>">
			<input type="hidden" class="userid" id="userid" name="userid" value="<%=userid %>">
			<textarea class="content" id="content" cols="100" rows="500" name="content" placeholder="여기에 내용을 입력하세요"></textarea>		
		
			<div class="fileuploadForm">
				<input type="file" id="inputFile" name="uploadFile" style="display:none;" multiple />
				<div class="fileZone" id="fileZone">파일 첨부를 하기 위해서는 클릭하거나 여기로 파일을 드래그 하세요.<br>첨부파일은 최대 5개까지 등록이 가능합니다.</div>
	  			<div class="fileUploadList" id="fileUploadList"></div>
			</div>
			
			<input type="button" class="btn_write" value="등록" onclick="registerForm()" />
			<input type="button" class="btn_cancel" value="취소" onclick="history.back()" />
		</form>
	</div>
</div><br><br>
</body>
</html>