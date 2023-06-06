<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>여러 이미지 보기</title>
</head>
<body>
<script>
	const previewFiles = () => {
		const preview = document.querySelector('#preview');
		const files = document.querySelector('input[type=file]').files;
		
		const readAndPreview = (file) => {
			if(/\.(jpe?g|png|gif)$/i.test(file.name)) {
				const reader = new FileReader();
				
				reader.addEventListener('load', function() {
					let image = new Image(); //<img>가 만들어짐
					image.height = 100;
					image.title = file.name;
					image.src = this.result; //this : reader
					
					preview.appendChild(image); //append : <div id="preview">여기에 넣기 위함</div>
				});
				reader.readAsDataURL(file); //바이너리 파일 읽기 위함
			}
		}
		if(files) {
			[].forEach.call(files, readAndPreview); //유사배열
		}
	}
</script>

<input type="file" id="browse" onchange="previewFiles()" multiple><!-- multiple : 파일 여러개 선택 -->
<div id="preview"></div>
</body>
</html>