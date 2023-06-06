<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이미지 보기</title>
</head>

<body>
<script>
	const previewFile = () => {
		const preview = document.querySelector('img');
		const file = document.querySelector('input[type=file]').files[0];
		const reader = new FileReader();
		
		reader.addEventListener('load', () => {
			preview.src = reader.result;
			console.log("preview.src = " + preview.src);
		});
		
		if(file) {
			reader.readAsDataURL(file);
		}
	}
</script>

<input type="file" onchange="previewFile()"><br>
<img src="" style="width:400px; height:auto;">
</body>
</html>