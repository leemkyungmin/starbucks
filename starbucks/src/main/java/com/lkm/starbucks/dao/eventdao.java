package com.lkm.starbucks.dao;

import java.util.ArrayList;

import com.lkm.starbucks.dto.eventdto;

public interface eventdao {

	//진행중인 이벤트 리스트
	public ArrayList<eventdto> getProgressEvent();
	
	//종료된 이벤트
	public ArrayList<eventdto> getEndEvent();
	
	public eventdto geteventinfo(String edix);
	
}
