package com.BoardMaria.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.BoardMaria.dao.MasterDAO;
import com.BoardMaria.dto.FileVO;

@Service
public class MasterServiceImpl implements MasterService{

	@Autowired
	MasterDAO dao;
	
	//삭제 파일 목록 갯수
	@Override
	public int filedeleteCount() {
		return dao.filedeleteCount();
	}
		
	//삭제 파일 목록 정보
	@Override
	public List<FileVO> filedeleteList() {
		return dao.filedeleteList();
	}
	
	//파일 삭제
	@Override
	public void deleteFile(int fileseqno) {
		dao.deleteFile(fileseqno);
	}
}
