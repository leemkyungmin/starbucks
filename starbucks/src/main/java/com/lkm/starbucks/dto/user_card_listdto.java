package com.lkm.starbucks.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class user_card_listdto {
	
	
	//uclPinnum 핀번호
	//uclRepcard 자주 사용 하는 카드 ( 0 > 아님  1 > 자주 사용하는 카드) 
	
	int uclIdx,uclMoney,uIdx,clIdx;
	String uclName,uclCardnum,uclPinnum,uclRepcard,uclCategory;
	
	
	public user_card_listdto() {}


	public user_card_listdto(int uclIdx, int uclMoney, int uIdx, int clIdx, String uclName, String uclCardnum,
			String uclPinnum, String uclRepcard, String uclCategory) {
		super();
		this.uclIdx = uclIdx;
		this.uclMoney = uclMoney;
		this.uIdx = uIdx;
		this.clIdx = clIdx;
		this.uclName = uclName;
		this.uclCardnum = uclCardnum;
		this.uclPinnum = uclPinnum;
		this.uclRepcard = uclRepcard;
		this.uclCategory = uclCategory;
	}
	
	
	
	
}
