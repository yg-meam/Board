package com.BoardMaria.controller;

import java.io.File;
import java.net.URLEncoder;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
import com.BoardMaria.dto.BoardVO;
import com.BoardMaria.dto.FileVO;
import com.BoardMaria.dto.LikeVO;
import com.BoardMaria.dto.ReplyVO;
import com.BoardMaria.dto.User;
import com.BoardMaria.mapper.SFTestMapper;
import com.BoardMaria.service.BoardService;

@Controller
public class BoardController {
	
	@Autowired //비밀번호 암호화 의존성 주입
	private BCryptPasswordEncoder pwdEncoder;
	
	@Autowired //mapper 인터페이스 의존성 주입
	SFTestMapper mapper;
	
	@Autowired //service 인터페이스 의존성 주입
	BoardService service;
	
	//홈페이지
	@GetMapping("/")
	public String getHome() {
		return "home";
	}
	
	//게시물 목록(화면 -GET)
	@GetMapping("/board/list")
	public void getList(@RequestParam("page") int pageNum, @RequestParam(name="keyword",defaultValue="",required=false) String keyword, Model model) throws Exception {
		//model.addAttribute("list",mapper.list());
		int postNum = 10; //한 화면에 보여지는 게시물 행의 갯수
		int pageListCount = 5; //화면 하단에 보여지는 페이지리스트 내의 페이지 갯수
		int startPoint = (pageNum - 1) * postNum;

		Page page = new Page();
		
		model.addAttribute("list",service.list(startPoint, postNum, keyword));
		model.addAttribute("page", pageNum);
		model.addAttribute("keyword", keyword);
		model.addAttribute("pageList", page.getPageList(pageNum, postNum, pageListCount, service.getTotalCount(keyword), keyword));
	}
	
	//게시물 등록(화면)
	@GetMapping("/board/write")
	public void getWrite() throws Exception {}
	
	//첨부 파일 없는 게시물 등록
	@ResponseBody
	@PostMapping("/board/write")
	public String PostWrite(BoardVO board) throws Exception{
			service.write(board);
			
			return "{\"message\":\"good\"}";
	}
		
	//파일 업로드
	@ResponseBody //비동기
	@PostMapping("/board/fileUpload")
	public String postFileUpload(BoardVO board,@RequestParam("SendToFileList") List<MultipartFile> multipartFile, 
			@RequestParam("kind") String kind,@RequestParam(name="deleteFileList", required=false) int[] deleteFileList) throws Exception{ //deleteFileList : 게시물 수정할 때 파일
		
		String path = "c:\\Repository\\file\\";
		
		int seqno =0;
			
		if(kind.equals("U")) { //게시물 수정 시
			seqno = board.getSeqno();
			service.modify(board);
				
			if(deleteFileList != null) {
				for(int i=0; i<deleteFileList.length; i++) {
					//파일 삭제
					FileVO fileInfo = new FileVO();
					fileInfo = service.fileInfo(deleteFileList[i]);
					//File file = new File(path + fileInfo.getStored_filename());
					//file.delete();
						
					//파일 테이블에서 파일 정보 삭제
					Map<String,Object> data = new HashMap<>();
					data.put("kind", "F"); //게시물 수정에서 삭제할 파일 목록이 전송되면 이 값을 받아서 파일을 하나씩 삭제
					data.put("fileseqno", deleteFileList[i]);
					service.deleteFileList(data); //delete
					//service.deleteFileList(deleteFileList[i]);
						
				}
			}	
		}
			
		if(!multipartFile.isEmpty()) { //게시물 등록 및 게시물 수정 시 파일 업로드
			File targetFile = null; 
			Map<String,Object> fileInfo = null;		
				
			for(MultipartFile mpr:multipartFile) {
					
				String org_filename = mpr.getOriginalFilename();	
				String org_fileExtension = org_filename.substring(org_filename.lastIndexOf("."));	
				String stored_filename = UUID.randomUUID().toString().replaceAll("-", "") + org_fileExtension;	
				long filesize = mpr.getSize() ;
					
				targetFile = new File(path + stored_filename);
				mpr.transferTo(targetFile);
					
				fileInfo = new HashMap<>();
				fileInfo.put("org_filename",org_filename);
				fileInfo.put("stored_filename", stored_filename);
				fileInfo.put("filesize", filesize);
				fileInfo.put("seqno", seqno);
				fileInfo.put("userid", board.getUserid());
				fileInfo.put("kind", kind);
			
				service.fileInfoRegistry(fileInfo);
			}
		}	
			
		if(kind.equals("I")) { //게시물 등록
			service.write(board);
		}
		
		return "{\"message\":\"good\"}";
	}
	
	/*
	//게시물 등록
	@PostMapping("/board/write")
	public String postWrite(BoardVO board, @RequestParam("fileUpload") MultipartFile mpr) throws Exception {
		String path = "c:\\Repository\\test\\"; 
		String org_filename = "";
		long filesize = 0L;
		
	//파일 첨부가 있을 경우
	if(!mpr.isEmpty()) {
		File targetFile = null;	
			
		org_filename = mpr.getOriginalFilename();	
		String org_fileExtension = org_filename.substring(org_filename.lastIndexOf(".")); //파일 kkk.txt일 경우 .txt를 가져오라는 의미
		String stored_filename = UUID.randomUUID().toString().replaceAll("-", "") + org_fileExtension;	
		filesize = mpr.getSize(); //파일 사이즈
				
		targetFile = new File(path + org_filename); //File file = new File("c:\\Repository\\test\\"); //파일 생성에 필요한 경로 및 파일 정보를 입력
		mpr.transferTo(targetFile); //row data를 targetFile에서 가진 정보대로 변환
				
		board.setOrg_filename(org_filename);
		board.setStored_filename(stored_filename);
		board.setFilesize(filesize);
				
		System.out.println("파일명 : " + board.getOrg_filename());
		System.out.println("변경된 파일명 : " + stored_filename);
		System.out.println("파일size : " + filesize);	
	}
	//mapper.write(board);
	service.write(board);
		
	return "redirect:/board/list?page=1";
	}
	*/
	
	//게시물 내용
	@GetMapping("/board/view")
	public void getView(@RequestParam("seqno") int seqno, @RequestParam("page") int pageNum, 
			@RequestParam(name="keyword",defaultValue="",required=false) String keyword,  Model model, HttpSession session) throws Exception {
		
		String SessionUserid = (String)session.getAttribute("userid"); //지금의 세션값 가져오기
		
		//BoardVO board = new BoardVO();
		//board.setSeqno(seqno);
		BoardVO view = service.view(seqno);
		
		// 조회수 증가 처리
		if(!SessionUserid.equals(view.getUserid())) {
			service.hitno(view);
		}
		
		//좋아요, 싫어요 처리
		LikeVO likeCheckView = service.likeCheckView(seqno, SessionUserid);
		
		//초기에 좋아요/싫어요 등록이 안되어져 있을 경우 "N"으로 초기화 
		
		if(likeCheckView == null) {
			model.addAttribute("myLikeCheck", "N");
			model.addAttribute("myDislikeCheck", "N");
		} else if(likeCheckView != null) {
			model.addAttribute("myLikeCheck", likeCheckView.getMylikecheck());
			model.addAttribute("myDislikeCheck", likeCheckView.getMydislikecheck());
		}
		
		//mapper.hitno(board);		
		//model.addAttribute("view", mapper.view(seqno));
		//service.hitno(board);
		model.addAttribute("view", view);
		model.addAttribute("page", pageNum);
		model.addAttribute("keyword", keyword); //게시글을 수정하고 목록 버튼을 눌렀을 때 기존 페이지로 넘어감(전체 페이지로 넘어가지 않음)
		model.addAttribute("pre_seq",service.pre_seq(seqno, keyword));
		model.addAttribute("next_seqno",service.next_seqno(seqno,keyword));
		model.addAttribute("likeCheckView", likeCheckView);
		model.addAttribute("fileListView", service.fileListView(seqno));
	}
	
	//좋아요/싫어요 관리
	@ResponseBody
	@PostMapping(value = "/board/likeCheck")
	public Map<String, Object> postLikeCheck(@RequestBody Map<String, Object> likeCheckData) throws Exception {
		int seqno = (int)likeCheckData.get("seqno");
		String userid = (String)likeCheckData.get("userid");
		int checkCnt = (int)likeCheckData.get("checkCnt");

		//현재 날짜, 시간 구해서 좋아요/싫어요 한 날짜/시간 입력 및 수정
		String likeDate = "";
		String dislikeDate = "";
		if(likeCheckData.get("mylikecheck").equals("Y")) {
			likeDate = LocalDateTime.now().toString();
		} else if(likeCheckData.get("mydislikecheck").equals("Y")) {
			dislikeDate = LocalDateTime.now().toString();
		}
	
		likeCheckData.put("likedate", likeDate);
		likeCheckData.put("dislikedate", dislikeDate);

		//TBL_LIKE 테이블 입력/수정
		LikeVO likeCheckView = service.likeCheckView(seqno,userid);
		
		if(likeCheckView == null) {
			service.likeCheckRegistry(likeCheckData);
		} else {
			service.likeCheckUpdate(likeCheckData);
		}

		//TBL_BOARD 내의 likecnt,dislikecnt 입력/수정 
		BoardVO board = service.view(seqno);
			
		int likeCnt = board.getLikecnt();
		int dislikeCnt = board.getDislikecnt();
				
		switch(checkCnt){
		    case 1 : likeCnt --; break;
		   	case 2 : likeCnt ++; dislikeCnt --; break;
		    case 3 : likeCnt ++; break;
		    case 4 : dislikeCnt --; break;
		   	case 5 : likeCnt --; dislikeCnt ++; break;
		   	case 6 : dislikeCnt ++; break;
		}
			
		service.boardLikeUpdate(seqno,likeCnt,dislikeCnt);
			
		//AJAX에 전달할 map JSON 데이터 만들기
			
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("seqno", seqno);
		map.put("likeCnt", likeCnt);
		map.put("dislikeCnt", dislikeCnt);
						
		return map;
		//return "{\"likeCnt\":\"" + likeCnt + "\",\"dislikeCnt\":\"" + dislikeCnt + "\")";
	}
	
	//게시물 수정(화면)
	@GetMapping("board/modify")
	public void getModify(@RequestParam("seqno") int seqno, @RequestParam("page") int pageNum, 
			@RequestParam(name="keyword",defaultValue="",required=false) String keyword, Model model) throws Exception {
		
		//model.addAttribute("view",mapper.view(seqno));
		model.addAttribute("view",service.view(seqno));
		model.addAttribute("page", pageNum);
		model.addAttribute("keyword", keyword);
		model.addAttribute("fileListView", service.fileListView(seqno));
	}
	
	//게시물 수정
	@ResponseBody
	@PostMapping("/board/modify")
	public String postModify(BoardVO board, @RequestParam("page") int pageNum, @RequestParam(name="keyword",defaultValue="",required=false) String keyword,
			@RequestParam(name="deleteFileList", required=false) int[] deleteFileList) throws Exception {
		
		//mapper.modify(board);
		service.modify(board);
		
		if(deleteFileList != null) {
			for(int i = 0; i < deleteFileList.length; i++) {
				//파일 정보 삭제
				FileVO fileInfo = new FileVO();
				
				fileInfo = service.fileInfo(deleteFileList[i]);
				
				//파일 테이블에서 파일 정보 삭제
				Map<String,Object> data = new HashMap<>();
				
				data.put("kind", "F");
				data.put("fileseqno", deleteFileList[i]);
				
				service.deleteFileList(data);
			}
		}
		return "{\"message\":\"good\"}";
	}
	
	//게시물 삭제
	@GetMapping("/board/delete")
	public String getDelete(@RequestParam("seqno") int seqno) throws Exception {
		
		//mapper.delete(seqno);
		//service.delete(seqno);
		
		Map<String,Object> data = new HashMap<>();
		
		data.put("kind", "B");
		data.put("seqno", seqno);
		
		service.deleteFileList(data);
		service.delete(seqno);
		
		return "redirect:/board/list?page=1";
	}
	
	//댓글 처리
	@ResponseBody
	@PostMapping("/board/reply")
	public List<ReplyVO> postReply(@RequestBody ReplyVO reply,@RequestParam("option") String option)throws Exception{
		switch(option) {
			case "I" : service.replyRegistry(reply); //댓글 등록
					   break;
			case "U" : service.replyUpdate(reply); //댓글 수정
					   break;
			case "D" : service.replyDelete(reply); //댓글 삭제
					   break;
		}
		return service.replyView(reply);
	}
	
	//파일 다운로드
	@GetMapping("/board/fileDownload")
	public void fileDownload(@RequestParam("fileseqno") int fileseqno, HttpServletResponse rs) throws Exception {
		String path = "c:\\Repository\\file\\";
		
		//BoardVO board = mapper.view(seqno);
		FileVO file = service.fileInfo(fileseqno);
		//String org_filename = board.getOrg_filename();
		//String stored_filename = board.getStored_filename();
		
		//byte fileByte[] = FileUtils.readFileToByteArray(new File(path + org_filename));
		byte fileByte[] = FileUtils.readFileToByteArray(new File(path + file.getStored_filename()));
		
		//헤드값을 Content-Disposition로 주게 되면 Response Body로 오는 값을 filename으로 다운받으라는 것임
		//예) Content-Disposition: attachment; filename="hello.jpg"
		rs.setContentType("application/octet-stream");
		rs.setContentLength(fileByte.length);
		//rs.setHeader("Content-Disposition",  "attachment; filename=\""+URLEncoder.encode(org_filename, "UTF-8")+"\";");
		rs.setHeader("Content-Disposition",  "attachment; filename=\""+URLEncoder.encode(file.getOrg_filename(), "UTF-8")+"\";");
		rs.getOutputStream().write(fileByte);
		rs.getOutputStream().flush();
		rs.getOutputStream().close();
	}
}