package com.lkm.starbucks.dao;

import java.util.ArrayList;

import com.lkm.starbucks.dto.card_listdto;
import com.lkm.starbucks.dto.user_card_listdto;

public interface mystarbucksdao {

	public ArrayList<user_card_listdto> getCardList(int uidx);

	public card_listdto getCardinfo(int clidx);
	
}
