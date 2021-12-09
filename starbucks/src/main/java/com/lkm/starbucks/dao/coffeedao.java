package com.lkm.starbucks.dao;

import java.util.ArrayList;
import java.util.Map;

import com.lkm.starbucks.dto.*;

public interface coffeedao {

	public ArrayList<coffee_kindsdto> getCoffeeList(String Category);
	public ArrayList<coffee_kinds_typedto> getCoffeeType(String Category);
	
	public coffee_kindsdto coffee_product_info(String ckidx);
	public coffee_kinds_typedto coffee_product_type_info(String ckidx);
	
	public int insert_menu(Map<String,Object> param);
	
}
 