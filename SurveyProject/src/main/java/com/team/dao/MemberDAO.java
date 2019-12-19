package com.team.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.team.dto.MemberDTO;

@Repository
public class MemberDAO {

	private static final String namespace = "Member";
	
	@Autowired
	private SqlSession session;

	//[회원가입]
	public void singUp(MemberDTO dto) {
		session.insert(namespace+".singUp",dto);	
	}
	
	//[아이디 중복체크]
	public int checkOverId(String id) {	
		return session.selectOne(namespace+".checkOverId",id);
	}
	
	//[닉네임 중복체크]
	public int checkOverNick(String nick) {
		return session.selectOne(namespace+".checkOverNick",nick);
	}

	//[로그인]
	public MemberDTO signIn(String id,String pw) {
		return session.selectOne(namespace+".signIn", id);		 
	}
	
	//[비밀번호 변경]
	public void changePw(MemberDTO dto) {
		System.out.println(dto.getNick() +"nick");
		session.update(namespace + ".changePw", dto);
	}
	
	//[닉네임 변경]
	public void changeNick(MemberDTO dto) {
		session.update(namespace + ".changeNick", dto);
	}
	
}
