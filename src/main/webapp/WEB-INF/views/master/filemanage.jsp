<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>시스템 관리</title>

<link rel="stylesheet" href="/resources/css/board.css?after">

<style>
.menubar {
    width: 100%;
    height:auto;
    background-color: #168; 
    position: fixed;
    top: 0;
    left:0;
    right:0;
    text-align: center;
}

.menubar a:link, a:visited, a:active { 
	color: white; 
	text-weight: bold;
}

.menubar a { 
    display:block; 
    text-decoration: none;
}

.menubar .main_menu > li {
    float:left;
    width:20%;
    height: 100%;
    line-height: 50px;
    list-style: none;
    font-weight: bold;
    position: relative;
    margin: 0px,0px,0px,0px;
}

.menubar .main_menu > li > a:hover {
    background-color: #f0f6f9;
    color: #168; 
	text-weight: bold;
}

.main {
	position: relative;
	top: 200px;
	width: 80%;
	height: auto;
	margin: auto;
}
</style>

<script>
const deleteFileList = async() => {
	await fetch('/master/fileDelete', {
		method: "GET"
	}).then((response) => response.json())
	.then((data) => {
		let result = "";
			
		for(const i in data) {
			result += data[i].org_filename + "...파일 삭제<br>";
		}
		
		result += "<br>" + ${count} + " 개 파일 삭제 완료";
		
		filedeleteList.innerHTML = result;
	})
}
</script>
</head>

<body>
<div class="menubar">
	<ul class="main_menu">
		<li><a href="/board/list?page=1">홈으로</a></li>
	    <li><a href="/master/sysinfo">시스템 정보</a></li>
	    <li><a href="/master/filemanage">첨부 파일 관리</a></li>
	    <li><a href="#">게시판 관리</a></li>
	    <li><a href="#">사용자 통계</a></li>
	</ul>
</div>

<div class="main" align="center">
 	<span style="font-size: 150%; font-weight: bold;">파일 삭제 갯수 : ${count } 개</span>
 	<input type="button" id="btn_delete" value="첨부파일 삭제" onclick="deleteFileList()"><br><br>
 	<div id="filedeleteList" style="width: 50%; height: auto; margin: auto;"></div>
</div>
</body>
</html>