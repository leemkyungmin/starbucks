package com.lkm.starbucks.dao;

import java.util.ArrayList;

import com.lkm.starbucks.dto.branch_infodto;

public interface storedao {

	public ArrayList<branch_infodto> getbranch_info(String location);
}
