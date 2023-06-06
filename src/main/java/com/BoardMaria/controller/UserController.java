package com.BoardMaria.controller;

import java.io.File;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.BoardMaira.util.Page;
import com.BoardMaria.dto.AddressVO;
import com.BoardMaria.dto.BoardVO;
import com.BoardMaria.dto.User;
import com.BoardMaria.mapper.SFTestMapper;
import com.BoardMaria.service.UserService;


@Controller
public class UserController {
	
	@Autowired //비밀번호 암호화 의존성 주입
	private BCryptPasswordEncoder pwdEncoder;
	
	@Autowired //mapper 인터페이스 의존성 주입
	SFTestMapper mapper;
	
	@Autowired //service 인터페이스 의존성 주입
	UserService service;
	
	@GetMapping("/user/signup")
	public void getSignup() throws Exception {}
	
	@ResponseBody
	@PostMapping("/user/signup")
	/*
	public void postSignup(@RequestParam("userid") String userid, @RequestParam("username") String username,
		@RequestParam("gender") String gender, @RequestParam("hobby") List<String> hobby,
		@RequestParam("job") String job) throws Exception { }//name으로 정해준 값을 넣음
	*/	
	public String postSignup(User user, @RequestParam("fileUpload") MultipartFile mpr) throws Exception {
		String path = "c:\\Repository\\profile\\"; 
		String org_filename = "";
		long filesize = 0L;
		
		//파일 첨부가 있을 경우
		if(!mpr.isEmpty()) {
			File targetFile = null;	
				
			org_filename = mpr.getOriginalFilename();	
			String org_fileExtension = org_filename.substring(org_filename.lastIndexOf(".")); //파일 kkk.txt일 경우 .txt를 가져오라는 의미
			String stored_filename = UUID.randomUUID().toString().replaceAll("-", "") + org_fileExtension;	
			filesize = mpr.getSize(); //파일 사이즈
					
			targetFile = new File(path + stored_filename); //File file = new File("c:\\Repository\\test\\"); //파일 생성에 필요한 경로 및 파일 정보를 입력
			mpr.transferTo(targetFile); //row data를 targetFile에서 가진 정보대로 변환
					
			user.setOrg_filename(org_filename);
			user.setStored_filename(stored_filename);
			user.setFilesize(filesize);
		}
		/*String hobby = "";
		for(String h:hobbies) {
			hobby += h + ",";
		}
		
		user.setHobby(hobby);*/
		//System.out.println("hobby = " + user.getHobby());
		
		//mapper.signup(user);
		//return "redirect:/user/userinfo";
		String inputPassword = user.getPassword();
		String pwd = pwdEncoder.encode(inputPassword); 
		
		user.setPassword(pwd);
		
		//mapper.signup(user);
		service.signup(user);
		
		return "{\"username\":\"" + URLEncoder.encode(user.getUsername(), "UTF-8")+ "\",\"status\":\"good\"}"; //{"username": "김철수", "status": "good"}
	}
	
	//사용자 등록 시 아이디 중복 확인
	@ResponseBody
	@RequestMapping("/user/idCheck")
	public int idCheck(@RequestBody String userid) throws Exception{
		//int result = mapper.idCheck(userid);
		int result = service.idCheck(userid);
			
		return result;
	}
	
	//로그인 화면 보기
	@GetMapping("/user/login")
	public void getLogIn(Model model) { }
		
	//로그인 처리
	@ResponseBody
	@PostMapping("/user/login")
	public String postLogIn(User user,HttpSession session,@RequestParam("autologin") String autologin) {
		String authkey = "";
			
		//로그인 시 자동 로그인 체크할 경우 신규 authkey 등록
		if(autologin.equals("NEW")) {
			authkey = UUID.randomUUID().toString().replaceAll("-", "");
			user.setAuthkey(authkey);
			service.authkeyUpdate(user);
		}
			
		//authkey가 클라이언트에 쿠키로 존재할 경우 로그인 과정 없이 세션 생성 후 게시판 목록 페이지로 이동
		if(autologin.equals("PASS")) {
			User userinfo = service.userinfoByAuthkey(user.getAuthkey());
				
			if(userinfo != null) {
				//세션 생성
				session.setMaxInactiveInterval(3600*7);
				session.setAttribute("userid", userinfo.getUserid());
				session.setAttribute("username", userinfo.getUsername());
				session.setAttribute("role", userinfo.getRole());
					
				return "{\"message\":\"good\"}";
			}else {
				return "{\"message\":\"bad\"}";
			}
		}
			
		//아이디 존재 여부 확인
		//if(mapper.idCheck(user.getUserid()) == 0) {
		//	rttr.addFlashAttribute("message", "ID_NOT_FOUND");
		//	return "redirect:/user/login";
		//}
			
		if(service.idCheck(user.getUserid()) == 0) {
			/*
			rttr.addFlashAttribute("message", "ID_NOT_FOUND");
			return "redirect:/user/login";
			*/
			return "{\"message\":\"ID_NOT_FOUND\"}";
		}
			
		//아이디가 존재하면 읽어온 userid로 로그인 정보 가져오기
		//User member = mapper.login(user.getUserid());
		User member = service.userinfo(user.getUserid());
		
			
		//패스워드 확인
		if(!pwdEncoder.matches(user.getPassword(),member.getPassword())) {
			/*
			rttr.addFlashAttribute("message", "PASSWORD_NOT_FOUND");
			return "redirect:/user/login";
			*/
			return "{\"message\":\"PASSWORD_NOT_FOUND\"}";
		} else {
			//세션 생성
			session.setMaxInactiveInterval(3600*7);
			session.setAttribute("userid", member.getUserid());
			session.setAttribute("username", member.getUsername());
			session.setAttribute("role", member.getRole());
			
			//패스워드 변경 후 30일이 경과했는지 확인
			User pwcheck = new User();
			
			pwcheck = service.pwcheck(user.getUserid());
				
			if(pwcheck.getPwdiff() > (30*pwcheck.getPwcheck())) {
				System.out.println("pwdiff=" + pwcheck.getPwdiff());
				service.notPasswordUpdate(user.getUserid());
				
				return "{\"message\":\"CHANGE_PASSWORD\"}";
			} else {
				System.out.println("pwdiff=" + pwcheck.getPwdiff());
				//return "redirect:/board/list?page=1";
				return "{\"message\":\"good\",\"authkey\":\"" + member.getAuthkey() + "\"}";
			}
		}
	}
		
	//패스워드 변경 안내 공지
	@GetMapping("/user/pwCheckNotice")
	public void getPwCheckNotice() { }
		
	//패스워드 30일 이후에 변경 공지 나오도록 pwchek 값 변경
	@GetMapping("/user/userPasswordModifyAfter30")
	public String postUserPasswordAfter30(HttpSession session) {
		service.userPasswordModifyAfter30((String)session.getAttribute("userid"));
			
		return "redirect:/board/list?page=1";
	}
		
	//사용자 패스워드 변경 보기
	@GetMapping("/user/userPasswordModify")
	public void getUserPasswordModify() { }
		
	//사용자 패스워드 변경
	@PostMapping("/user/userPasswordModify")
	public String postMemberPasswordModify(@RequestParam("old_userpassword") String old_password,
			@RequestParam("new_userpassword") String new_password, HttpSession session, RedirectAttributes rttr) { 
			
		String userid = (String)session.getAttribute("userid");
			
		User member = service.userinfo(userid);
		if(pwdEncoder.matches(old_password, member.getPassword())) {
			rttr.addFlashAttribute("message", "PASSWORD_FOUND");
			member.setPassword(pwdEncoder.encode(new_password));
			
			service.passwordUpdate(member);
		} else {
			rttr.addFlashAttribute("message", "PASSWORD_NOT_FOUND");
			return "redirect:/user/userPasswordModify";
		}
		
		return "redirect:/user/login";
	}
	
	//로그아웃
	@GetMapping("/user/logout")
	public String getLogout(HttpSession session,Model model) {
		String userid = (String)session.getAttribute("userid");
		String username = (String)session.getAttribute("username");
			
		session.invalidate(); //모든 세션 종료--> 로그아웃...
			
		return "redirect:/user/login";
	}
	
	//우편번호 검색
	@GetMapping("/user/addrSearch")
	public void getSearchAddr(@RequestParam("addrSearch") String addrSearch,
			@RequestParam("page") int pageNum,Model model) throws Exception {
			
		int postNum = 5;
		int startPoint = (pageNum -1)*postNum; //테이블에서 읽어 올 행의 위치
		int listCount = 5;
			
		Page page = new Page();
			
		int totalCount = service.addrTotalCount(addrSearch);
		List<AddressVO> list = new ArrayList<>();
		list = service.addrSearch(startPoint, postNum, addrSearch);

		model.addAttribute("list", list);
		model.addAttribute("pageListView", page.getPageAddress(pageNum, postNum, listCount, totalCount, addrSearch));
	}
		
	//사용자 아이디 찾기 보기
	@GetMapping("/user/searchID")
	public void getSearchID() { } 
		
	//사용자 아이디 찾기 
	@PostMapping("/user/searchID")
	public String postSearchID(User user, RedirectAttributes rttr) {
		String userid = service.searchID(user);
					
		//조건에 해당하는 사용자가 아닐 경우 
		if(userid == null ) { 
			rttr.addFlashAttribute("msg", "ID_NOT_FOUND");
				
			return "redirect:/user/searchID"; 
		}
			
		return "redirect:/user/IDView?userid=" + userid;		
	} 
		
	//찾은 아이디 보기
	@GetMapping("/user/IDView")
	public void postSearchID(@RequestParam("userid") String userid, Model model) {
		model.addAttribute("userid", userid);
	}
		
	//사용자 패스워드 임시 발급 보기
	@GetMapping("/user/searchPassword")
	public void getSearchPassword() { } 
		
	//사용자 패스워드 임시 발급
	@PostMapping("/user/searchPassword")
	public String postSearchPassword(User member, RedirectAttributes rttr) { 
		
		if(service.searchPassword(member) == 0) {
			rttr.addFlashAttribute("msg", "PASSWORD_NOT_FOUND");
			
			return "redirect:/user/searchPassword"; 	
		}
			
		//숫자 + 영문대소문자 7자리 임시패스워드 생성
		StringBuffer tempPW = new StringBuffer();
		Random rnd = new Random();
		for (int i = 0; i < 7; i++) {
			int rIndex = rnd.nextInt(3);
			
			switch (rIndex) {
			    case 0:
			    	// a-z : 아스키코드 97~122
			    	tempPW.append((char) ((int) (rnd.nextInt(26)) + 97));
			    	break;
			    case 1:
			        // A-Z : 아스키코드 65~122
			    	tempPW.append((char) ((int) (rnd.nextInt(26)) + 65));
			        break;
			    case 2:
			        // 0-9
			    	tempPW.append((rnd.nextInt(10)));
			        break;
			        }
			}
			
			member.setPassword(pwdEncoder.encode(tempPW));
			
			service.passwordUpdate(member);
				
			return "redirect:/user/tempPWView?password=" + tempPW;
	} 
		
	//발급한 임시패스워드 보기
	@GetMapping("/user/tempPWView")
	public void getTempPWView(Model model, @RequestParam("password") String password) {	
		model.addAttribute("password", password);
	}
		
		
	@GetMapping("/user/userinfo")
	public void getUserInfo(Model model, HttpSession session) throws Exception {
		String session_userid = (String)session.getAttribute("userid");
		
		model.addAttribute("user",service.userinfo(session_userid));
	}
	
	@PostMapping("/user/userinfo")
	public void postUserInfo(User user, Model model) {
		model.addAttribute("user", user);
	}
	
	@GetMapping("/user/userInfoModify")
	public void getUserInfoModify(Model model, HttpSession session) throws Exception {
		String session_userid = (String)session.getAttribute("userid");
		
		model.addAttribute("user", service.userinfo(session_userid));
	}
	
	//사용자 정보 수정
	@PostMapping("/user/userInfoModify")
	public String postUserInfoModify(User member,@RequestParam("fileUpload") MultipartFile multipartFile) {
		String path = "c:\\Repository\\profile\\";
		File targetFile;
	
		if(!multipartFile.isEmpty()) {
			//기존 프로파일 이미지 삭제
			User vo = new User();
		
			vo = service.userinfo(member.getUserid());
			
			File file = new File(path + vo.getStored_filename());
			
			file.delete();
		
			String org_filename = multipartFile.getOriginalFilename();	
			String org_fileExtension = org_filename.substring(org_filename.lastIndexOf("."));	
			String stored_filename =  UUID.randomUUID().toString().replaceAll("-", "") + org_fileExtension;	
						
			try {
				targetFile = new File(path + stored_filename);
			
				multipartFile.transferTo(targetFile);
			
				member.setOrg_filename(org_filename);
				member.setStored_filename(stored_filename);
				member.setFilesize(multipartFile.getSize());
				} catch(Exception e) {
					e.printStackTrace();
					}
			}
		
		service.userInfoUpdate(member);
	
		return "redirect:/user/userinfo";
	}
}