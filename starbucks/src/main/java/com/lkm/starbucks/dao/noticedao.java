package com.lkm.starbucks.dao;

import java.util.ArrayList;
import java.util.Map;

import com.lkm.starbucks.dto.noticedto;

public interface noticedao {

	public ArrayList<noticedto> notice_list(Map<String,Object> pages);
	
	public int noticeCount();
	
	public void update_hit(String nidx);
	
	public noticedto notice_view(String nidx);
}
