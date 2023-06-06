<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일 업로드(동기식)</title>

<script>
	function FileUpload() {
		document.FileForm.action = '/board/fileUpload';
		document.FileForm.submit();
	}
</script>
</head>
<body>
<form name="FileForm" method="post" enctype="multipart/form-data"><!-- Form으로 데이터 전송 시 기본 enctype="Application/x-www-form-urlencoded" -->
	화가 : <input type="text" name="painter">
	<input type="file" id="fileUpload" name="fileUpload" multiple><br> <!-- 파일 전송시 enctype="multipart/form-data" -->
	<input type="button" onclick="FileUpload()" value="파일 전송">
</form>
</body>
</html>