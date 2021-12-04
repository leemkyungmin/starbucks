package com.lkm.starbucks.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class user_card_depositdto {

	public int ucdIdx,uIdx,uclIdx,ucdDeposit;
	public String ucdType,ucdDate;
	
	public user_card_depositdto() {}

	public user_card_depositdto(int ucdIdx, int uIdx, int uclIdx, int ucdDeposit, String ucdType,
			String ucdDate) {
		super();
		this.ucdIdx = ucdIdx;
		this.uIdx = uIdx;
		this.uclIdx = uclIdx;
		this.ucdDeposit = ucdDeposit;
		this.ucdType = ucdType;
		this.ucdDate = ucdDate;
	}
	
	
}
