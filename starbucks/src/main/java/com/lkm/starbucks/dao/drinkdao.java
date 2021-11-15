package com.lkm.starbucks.dao;

import java.util.ArrayList;

import com.lkm.starbucks.dto.drinkdto;
import com.lkm.starbucks.dto.menu_typedto;

public interface drinkdao {

	//전체 음료 가져오기 
	public ArrayList<drinkdto> all_drink_list();
	
	public ArrayList<menu_typedto> getmenutypelist(String ftType);
	
	//선택된 음료 자료 가져오기 
	
	public drinkdto getdrink(String didx);
	public String getdrinktype(String didx);
}
