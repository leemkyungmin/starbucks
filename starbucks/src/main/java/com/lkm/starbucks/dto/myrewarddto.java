package com.lkm.starbucks.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class myrewarddto {

	public int mrIdx,mrMoney,mrStar;
	public String oNum,mrDate,bName;
	
	public myrewarddto() {}

	public myrewarddto(int mrIdx, int mrMoney, int mrStar, String oNum, String mrDate, String bName) {
		super();
		this.mrIdx = mrIdx;
		this.mrMoney = mrMoney;
		this.mrStar = mrStar;
		this.oNum = oNum;
		this.mrDate = mrDate;
		this.bName = bName;
	}

	
	
	
}
