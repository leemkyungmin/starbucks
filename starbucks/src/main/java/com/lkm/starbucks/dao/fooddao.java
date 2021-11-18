package com.lkm.starbucks.dao;

import java.util.ArrayList;

import com.lkm.starbucks.dto.fooddto;
import com.lkm.starbucks.dto.menu_typedto;

public interface fooddao {

	public ArrayList<fooddto> getfoodlist();
	public ArrayList<menu_typedto> getmenulist();
	
	public fooddto food_product(String fidx);
	public menu_typedto food_proudct_type(String fidx);
}
