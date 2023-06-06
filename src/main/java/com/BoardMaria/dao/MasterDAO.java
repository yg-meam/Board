package com.BoardMaria.dao;

import java.util.List;

import com.BoardMaria.dto.FileVO;

public interface MasterDAO {

	//삭제 파일 목록 갯수
	public int filedeleteCount();
	
	//삭제 파일 목록 정보
	public List<FileVO> filedeleteList();
	
	//파일 삭제
	public void deleteFile(int fileseqno);
}
