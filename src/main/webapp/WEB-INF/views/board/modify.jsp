<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>게시물 등록</title>

<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<link rel="stylesheet" href="/resources/css/board.css?after">
<script>
/*
$(document).ready(function(){ 
	var objDragAndDrop = $("#fileClick");
	//input type=file에 onchange 발생 이벤트
	$("#input_file").on("change", function(e) {
		var files = e.originalEvent.target.files;
    	fileCheck(files);
	});

	//fileClick 영역 클릭 시 이벤트
	objDragAndDrop.on('click',function (e){
        $('#input_file').trigger('click');
    });
	
	$(document).on("dragenter","#fileClick",function(e){
    	e.stopPropagation(); 
    	e.preventDefault();
    	$(this).css('border', '2px solid #0B85A1');
    });

	$(document).on("dragover","#fileClick",function(e){
    	e.stopPropagation();
    	e.preventDefault();
	});
	//fileClick 영역에 파일 Drop시 이벤트
	$(document).on("drop","#fileClick",function(e){
        e.preventDefault();
    	var files = e.originalEvent.dataTransfer.files;
	    fileCheck(files);
	});

	$(document).on('dragenter', function (e){
    	e.stopPropagation();
    	e.preventDefault();
	});

	$(document).on('dragover', function (e){
  		e.stopPropagation();
  		e.preventDefault();
  		objDragAndDrop.css('border', '2px dotted #0B85A1');
	});
	
	$(document).on('drop', function (e){
    	e.stopPropagation();
    	e.preventDefault();
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

var uploadCountLimit = 5; //업로드 가능한 파일 갯수
var fileCount = 0; // 파일 현재 필드 숫자 totalCount랑 비교값
var fileNum = 0; // 파일 고유넘버
var content_files = new Array(); // 첨부파일 배열
var rowCount=0;

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
			
	        if(file.size > 1073741824) {
	        	alert('파일 사이즈는 1GB를 초과할수 없습니다.');
	        	
	        	return;
	        }
		
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
	        
	        if(parseInt(sizeKB) > 1024){
	        	var sizeMB = sizeKB/1024;
	        	
	            sizeStr = sizeMB.toFixed(2)+" MB";
	        }else {
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

const ModifyForm = async() => {
	if(title.value == '') {
		alert("제목을 입력하세요!!!");
		title.focus();
		return false;
	}
	if(content.value =='') {
		alert("내용을 입력하세요!!!");
		content.focus();
		return false;
	}

	let mForm = document.getElementById('ModifyForm');	
 	let formData = new FormData(mForm);
 	
	for(var x = 0; x < content_files.length; x++) {
		if(!content_files[x].is_delete) {
			formData.append("SendToFileList", content_files[x]);
		}
	}
	let uploadURL = '';
	
	if(content_files.length != 0) {
		uploadURL = '/board/fileUpload?kind=U';
	} else {
		uploadURL = '/board/modify';
	}

	const seqno = "${view.seqno}";
	
	formData.append("seqno", parseInt(seqno));
     
	/*
	$.ajax({
        url: uploadURL,
        type: "POST",
        contentType:false,
        processData: false,
        cache: false,
        enctype: "multipart/form-data",
        data: formData,
        xhr:function(){
        	var xhr = $.ajaxSettings.xhr();
        	xhr.upload.onprogress = function(e){
        		var per = e.loaded * 100/e.total;
        		setProgress(per);
        	};
        	return xhr;        	
        },
        success: function(data){
        	alert("게시물이 수정되었습니다.\n게시물 내용 화면으로 이동합니다.");
			document.location.href='/board/view?seqno=${view.seqno}&page=${page}&searchType=${searchType}&keyword=${keyword}';
        },
        error: function (xhr, status, error) {
       	    	alert("서버오류로 파일 업로드가 안됩니다. 잠시 후 다시 시도해주시기 바랍니다.");
       	     return false;
       	}   
       
    }); 
	*/
	await fetch(uploadURL, {
		method: 'POST',
		body: formData			
	}).then((response)=> response.json())
	  .then((data) => {
		  if(data.message == 'good'){
			alert("게시물이 수정되었습니다.");
			
        	const seqno = '${view.seqno}';
        	const page = '${page}';
        	const searchType = '${searchType}';
        	const keyword = '${keyword}';
        	
        	document.location.href="/board/view?seqno=${view.seqno}&page=${page}&searchType=${searchType}&keyword=${keyword}";
		  }	
	}).catch((error)=> { 
		alert("시스템 장애로 게시물 수정이 실패했습니다.");
		console.log("error = " + error);
	});
}
</script>

<style>
#content{
  width: 850px;
  height: 300px;
  padding: 10px;
  box-sizing: border-box;
  border: solid #adadad;
  font-size: 16px;
  resize: both;
  }
</style>
</head>
   
<body>
<%
	String userid = (String)session.getAttribute("userid");
	String username = (String)session.getAttribute("username");
	if(userid == null) response.sendRedirect("/");
%>

<div>
   	<img id="topBanner" src ="/resources/images/logo.jpg" title="서울기술교육센터" >
</div>

<div class="main" align="center">
	<div class="FormDiv">
		<h1>게시물 수정</h1>
	
		<form id="ModifyForm" method="POST">
			<input type="text" class="writer" id="writer" value="작성자 : <%=username %> 님" diasabled>
			<input type="text" class="title" id="title" name="title"  value="${view.title}">
			
			<input type="hidden" name="seqno" value="${view.seqno}">
			<input type="hidden" name="writer" value="${view.writer}">
			<input type="hidden" name="userid" value="${view.userid}">
			<input type="hidden" name="page" value="${page}">
			<input type="hidden" name="searchType" value="${searchType}">
			<input type="hidden" name="keyword" value="${keyword}">
			
			<textarea class="content" id="content" cols="100" rows="500" name="content">${view.content}</textarea>
		
			<c:if test="${fileListView != null }">
         		<div id="fileList">	
         			<p style="text-align:left;">
         				<c:forEach items="${fileListView }" var="file">
         				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;삭제 : <input type="checkbox" name="deleteFileList" value="${file.fileseqno }">${file.org_filename }&nbsp;(${file.filesize } Byte)<br>
         				</c:forEach>
         			</p>
         		</div>       
        	</c:if>
		</form>	
		
		<div class="fileuploadForm">
			<input type="file" id="inputFile" name="uploadFile" style="display:none;" multiple />
			<div class="fileZone" id="fileZone">파일 첨부를 하기 위해서는 클릭하거나 여기로 파일을 드래그 하세요.<br>첨부파일은 최대 5개까지 등록이 가능합니다.</div>
  			<div class="fileUploadList" id="fileUploadList"></div>
		</div>
		
		<input type="button" class="btn_write" value="수정" onclick="ModifyForm()" />
		<input type="button" class="btn_cancel" value="취소" onclick="history.back()" />
	</div><br><br>
</div>
</body>
</html>