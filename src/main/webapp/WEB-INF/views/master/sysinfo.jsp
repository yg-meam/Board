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
 	<div class="devInfo" align="center">
 		<table class="InfoTable">
 			<tr><th>항목</th><th>내용</th></tr>
	   		<tr><td>웹애플리케이션 서버 버전</td><td><%=application.getServerInfo() %></td>
	   		<tr><td>서블릿 버전</td><td><%= application.getMajorVersion() %>.<%= application.getMinorVersion() %></td>
	   		<tr><td>JSP 버전</td><td><%= JspFactory.getDefaultFactory().getEngineInfo().getSpecificationVersion() %></td>
	   		<tr><td>스프링프레임워크 버전</td><td><%=org.springframework.core.SpringVersion.getVersion() %></td>
	   	</table>
	</div>	
</div>
</body>
</html>