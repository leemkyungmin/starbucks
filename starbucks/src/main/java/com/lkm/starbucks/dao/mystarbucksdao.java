package com.lkm.starbucks.dao;

import java.util.ArrayList;
import java.util.Map;

import com.lkm.starbucks.dto.card_listdto;
import com.lkm.starbucks.dto.mycartdto;
import com.lkm.starbucks.dto.myrewarddto;
import com.lkm.starbucks.dto.order_listdto;
import com.lkm.starbucks.dto.user_card_depositdto;
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
	
	public ArrayList<order_listdto> get_order_info(Map<String,Object> params);
	
	/* 
	 * 	my/card/...
	 * */
	
	public ArrayList<card_listdto> getcardlist();
	
	public int update_per_card(int uidx);
	public int insert_card(Map<String,Object> params);
	
	//카드 충전
	public void update_my_card_deposit(Map<String,Object> params);
	public void insert_my_card_deposit(Map<String,Object> params);
	public user_card_listdto user_card_info(String uclidx);
	
	
	/*
	 * 카드 충전 /사용 내역 
	 * 
	 */
	
	public ArrayList<user_card_depositdto> getDepositList(Map<String,Object> param);
	
	public int deposit_totalcount(Map<String,Object> param);
	
	/*
	 * 카드 삭제
	 */
	
	public int drop_card_deposit(Map<String,Object> param);
	public int drop_card(Map<String,Object> param);
	
	/*
	 * MyMenu
	 * 
	 */
	
	public ArrayList<mycartdto> getmycart(Map<String,Object> param);
	
	public int getCardMoney(int uclidx);
	
	public int card_pinNumcheck(Map<String,Object> params);	
	public int first_buy_insert(order_listdto odto);
	public int buy_insert(order_listdto odto);
	
	public void delete_cart(int mcidx);
	
	public int update_cardMoney(Map<String,Object> cardMap);
	public void update_card_deposit(Map<String,Object> cardMap);
}
