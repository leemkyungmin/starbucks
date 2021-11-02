package com.lkm.starbucks.dao;

import com.lkm.starbucks.dto.usersdto;

public interface logindao {

	public usersdto logincheck(String id, String pw);
	
	//아이디 찾기
	public usersdto find_id(String uphone);
	
	//비밀번호 찾기
	
	public usersdto find_pw(usersdto udto);
}
