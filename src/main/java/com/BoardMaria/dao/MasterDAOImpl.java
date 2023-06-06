package com.BoardMaria.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.BoardMaria.dto.FileVO;

@Repository
public class MasterDAOImpl implements MasterDAO {

	@Autowired
	SqlSession sql;
	private static String namespace = "com.BoardMaria.mappers.Master";
	
	//삭제 파일 목록 갯수
	@Override
	public int filedeleteCount() {
		return sql.selectOne(namespace + ".filedeleteCount");
	}
		
	//삭제 파일 목록 정보
	@Override
	public List<FileVO> filedeleteList() {
		return sql.selectList(namespace + ".filedeleteList");
	}
		
	//파일 삭제
	@Override
	public void deleteFile(int fileseqno) {
		sql.delete(namespace + ".deleteFile", fileseqno);
	}
}
