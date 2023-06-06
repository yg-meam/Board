package com.BoardMaria.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.BoardMaria.dto.BoardVO;
import com.BoardMaria.mapper.SFTestMapper;

@RestController
public class BoardRestController {
	@Autowired //mapper 인터페이스 의존성 주입
	SFTestMapper mapper;
	
	//게시물 목록
	@GetMapping("/rest/list")
	public List<BoardVO> getList() throws Exception {
		return mapper.list();
	}
	
	//게시물 내용
	@GetMapping("/rest/view")
	public BoardVO getView(@RequestParam("seqno") int seqno) throws Exception {
		return mapper.view(seqno);
	}
	
	//게시물 등록
	@GetMapping("/rest/write/{userid}/{title}/{writer}/{content}")
	public void postWrite(@PathVariable("userid") String userid,@PathVariable("title") String title,
			@PathVariable("writer") String writer,@PathVariable("content") String content) throws Exception {
		BoardVO board = new BoardVO();
		
		board.setUserid(userid);
		board.setTitle(title);
		board.setWriter(writer);
		board.setContent(content);
		
		mapper.write(board);
	}
}
