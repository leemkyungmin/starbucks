package com.lkm.starbucks.dao;

import java.util.Map;

public interface admindao {

	
	//메인페이지 매출정보 가져오기 
	
	public Map<String,Object> getsales(String year, String monthcal, String datecal);
	
}
