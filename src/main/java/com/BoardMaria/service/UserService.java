package com.BoardMaria.service;

import java.util.List;

import com.BoardMaria.dto.AddressVO;
import com.BoardMaria.dto.User;


public interface UserService {
	
	//아이디 중복 체크
	public int idCheck(String userid);
	
	//로그인
	public User login(String userid);
	
	//회원가입
	public void signup(User user);
	
	//패스워드 변경 후 30일 경과 확인
	public User pwcheck(String userid);
	
	//30일 이후에 패스워드 변경하도록 pwcheck 값 변경
	public void userPasswordModifyAfter30(String userid);
	
	//패스워드 수정
	public void passwordUpdate(User user);
	
	//패스워드 수정하지 않음
	public void notPasswordUpdate(String userid);
	
	//사용자 자동 로그인을 위한 authkey 등록
	public void authkeyUpdate(User user);
		
	//사용자 자동 로그인을 위한 authkey로 사용자 정보 가져오기
	public User userinfoByAuthkey(String authkey);
	
	//사용자 정보
	public User userinfo(String userid);
	
	//사용자 정보 수정
	public void userInfoUpdate(User user);
	
	//사용자 아이디 찾기
	public String searchID(User user);
	
	//사용자 패스워드 신규 발급을 위한 확인
	public int searchPassword(User user);
	
	//주소 전체 갯수 계산
	public int addrTotalCount(String addrSearch);
		
	//주소 검색
	public List<AddressVO> addrSearch(int startPoint, int postNum, String addrSearch);
	
}
