package com.lkm.starbucks.dao;

import java.util.ArrayList;

import com.lkm.starbucks.dto.*;

public interface coffeedao {

	public ArrayList<coffee_kindsdto> getCoffeeList(String Category);
	public ArrayList<coffee_kinds_typedto> getCoffeeType(String Category);
	
}
 