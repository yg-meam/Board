<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일 업로드(비동기식)</title>

<script>
	const FileUpload = async () => {
		const formData = new FormData(FileForm);
		
		await fetch('/board/fileUpload2', {
			method: 'POST',
			body: formData
		}).then((response) => response.text()) //fetch('url', {보내줄 데이터})
		  .then((data) => {
			  if(data == 'good') {
				  alert("파일 전송이 성공했습니다.");
			  } else {
				  alert("서버 장애로 파일 전송이 실패했습니다.");
			  }
		  }).catch((error) => console.log("error = " + error));
	}
</script>
</head>
<body>
<form id="FileForm" method="post" enctype="multipart/form-data"><!-- Form으로 데이터 전송 시 기본 enctype="Application/x-www-form-urlencoded" -->
	화가 : <input type="text" name="painter">
	<input type="file" id="fileUpload" name="fileUpload" multiple><br> <!-- 파일 전송시 enctype="multipart/form-data" -->
	<input type="button" onclick="FileUpload()" value="파일 전송">
</form>
</body>
</html>