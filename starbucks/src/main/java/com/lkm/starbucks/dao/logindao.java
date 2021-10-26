package com.lkm.starbucks.dao;

import com.lkm.starbucks.dto.usersdto;

public interface logindao {

	public usersdto logincheck(String id, String pw);
}
