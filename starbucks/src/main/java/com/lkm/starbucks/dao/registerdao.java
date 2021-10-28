package com.lkm.starbucks.dao;

public interface registerdao {

	//전화번호 중복 확인
	public int phonecheck(String phone);
	
	//아이디 중복체크
	public int idcheck(String uids);
	
	//닉네임 중복체크
	public int nicknamecheck(String nick);
}
