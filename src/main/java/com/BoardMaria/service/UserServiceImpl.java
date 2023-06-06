package com.BoardMaria.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.BoardMaria.dao.UserDAO;
import com.BoardMaria.dto.AddressVO;
import com.BoardMaria.dto.User;


@Service //Service라는걸 알려주는 Spring Bean
public class UserServiceImpl implements UserService {

	@Autowired //의존성 주입을 통해 spring bean을 가져와서 사용
	UserDAO dao;
	
	//아이디 중복 체크
	@Override
	public int idCheck(String userid) {
		return dao.idCheck(userid);
	}

	//로그인
	@Override
	public User login(String userid) {
		return dao.login(userid);
	}

	//회원가입
	@Override
	public void signup(User user) {
		dao.signup(user);
	}
	
	//패스워드 변경 후 30일 경과 확인
	@Override
	public User pwcheck(String userid) {
		return dao.pwcheck(userid);
	}
	
	//30일 이후에 패스워드 변경하도록 pwcheck 값 변경
	@Override
	public void userPasswordModifyAfter30(String userid) {
		dao.userPasswordModifyAfter30(userid);
	}
	
	//사용자 패스워드 변경
	@Override
	public void passwordUpdate(User user) {
		dao.passwordUpdate(user);		
	}
	
	//패스워드 변경 안함
	@Override
	public void notPasswordUpdate(String userid) {
		dao.notPasswordUpdate(userid);
	}
	
	//사용자 자동 로그인을 위한 authkey 등록
	@Override
	public void authkeyUpdate(User user) {
		dao.authkeyUpdate(user);
	}
		
	//사용자 자동 로그인을 위한 authkey로 사용자 정보 가져오기
	@Override
	public User userinfoByAuthkey(String authkey) {
		return dao.userinfoByAuthkey(authkey);
	}
	
	@Override
	public User userinfo(String userid) {
		return dao.userinfo(userid);
	}
	
	//사용자 정보 수정
	@Override
	public void userInfoUpdate(User user) {
		dao.userInfoUpdate(user);		
	}
	
	//사용자 아이디 찾기
	@Override
	public String searchID(User user) {
		return dao.searchID(user);
	}
	
	//사용자 패스워드 신규 발급을 위한 확인
	@Override
	public int searchPassword(User user) {
		return dao.searchPassword(user);
	}
	
	//우편번호 전체 갯수 가져 오기
	@Override
	public int addrTotalCount(String addrSearch) {
		return dao.addrTotalCount(addrSearch);
	}

	//우편번호 검색
	@Override
	public List<AddressVO> addrSearch(int startPoint, int postNum, String addrSearch) {
		return dao.addrSearch(startPoint, postNum, addrSearch);
	}
		
}
