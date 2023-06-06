package com.BoardMaria.controller;

import java.io.File;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class StudyController {

	@GetMapping("/study/imgView")
	public void getImgView() throws Exception {
		
	}
	
	@GetMapping("/study/imgViews") 
		public void getImgViews() throws Exception {
			
		}
	
	@GetMapping("/study/fileUpload")
	public void getFileUpload() {
		
	}
	
	//파일 업로드(동기식)
	@PostMapping("/study/fileUpload")
	public void postFileUpload(@RequestParam("painter") String painter,
			@RequestParam("fileUpload") List<MultipartFile> multipartFile) throws Exception {
		String path = "c:\\Repository\\test\\"; 
		String org_filename = "";
		long filesize = 0L;
		
		if(!multipartFile.isEmpty()) {
			File targetFile = null;	
			
			for(MultipartFile mpr:multipartFile) {
				org_filename = mpr.getOriginalFilename();	
				//String org_fileExtension = org_filename.substring(org_filename.lastIndexOf(".")); //파일 kkk.txt일 경우 .txt를 가져오라는 의미
				//String stored_filename = UUID.randomUUID().toString().replaceAll("-", "") + org_fileExtension;	
				filesize = mpr.getSize(); //파일 사이즈
				
				targetFile = new File(path + org_filename); //File file = new File("c:\\Repository\\test\\"); //파일 생성에 필요한 경로 및 파일 정보를 입력
				mpr.transferTo(targetFile); //row data를 targetFile에서 가진 정보대로 변환
				
				System.out.println("파일명 : " + org_filename);
				System.out.println("파일size : " + filesize);
			}

		}
	}
	
	@GetMapping("/study/fileUpload2")
	public void getFileUpload2() {}
	
	//파일 업로드(비동기식)
	@ResponseBody
	@PostMapping("/study/fileUpload2")
	public String postFileUpload2(@RequestParam("fileUpload") List<MultipartFile> multipartFile) throws Exception {
		String path = "c:\\Repository\\test\\"; 
		String org_filename = "";
		long filesize = 0L;
		
		if(!multipartFile.isEmpty()) {
			File targetFile = null;	
			
			for(MultipartFile mpr:multipartFile) {
				org_filename = mpr.getOriginalFilename();	
				//String org_fileExtension = org_filename.substring(org_filename.lastIndexOf(".")); //파일 kkk.txt일 경우 .txt를 가져오라는 의미
				//String stored_filename = UUID.randomUUID().toString().replaceAll("-", "") + org_fileExtension;	
				filesize = mpr.getSize(); //파일 사이즈
				
				targetFile = new File(path + org_filename); //File file = new File("c:\\Repository\\test\\"); //파일 생성에 필요한 경로 및 파일 정보를 입력
				mpr.transferTo(targetFile); //row data를 targetFile에서 가진 정보대로 변환
				

			}
		}
		System.out.println("filename : " + org_filename);
		return "good";
	}
	
	@GetMapping("/study/fileList")
	public void getFileList() {}
}
