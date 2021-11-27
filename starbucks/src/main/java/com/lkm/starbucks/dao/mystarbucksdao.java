package com.lkm.starbucks.dao;

import java.util.ArrayList;
import java.util.Map;

import com.lkm.starbucks.dto.card_listdto;
import com.lkm.starbucks.dto.myrewarddto;
import com.lkm.starbucks.dto.user_card_listdto;

public interface mystarbucksdao {
	
	//my/index
	public ArrayList<user_card_listdto> getCardList(int uidx);
	public card_listdto getCardinfo(int clidx);
	
	//my/reward/my_reward_history
	
	public ArrayList<myrewarddto> reward_history(Map<String,Object> params);
	
	public int month_reward(Map<String,Object> params);
	public int total_reward(Map<String,Object> params);
	public int use_reward(Map<String,Object> params);
	
}
