package com.lkm.starbucks.dto;

import lombok.*;

@Getter
@Setter
public class coffee_kindsdto {

	int ckIdx,cktIdx,ckPrice;
	String ckName,ckImg,ckInfo;
	Character ckCategory;
	
	public coffee_kindsdto() {}

	public coffee_kindsdto(int ckIdx, int cktIdx, int ckPrice, String ckName, String ckImg, String ckInfo,
			Character ckCategory) {
		super();
		this.ckIdx = ckIdx;
		this.cktIdx = cktIdx;
		this.ckPrice = ckPrice;
		this.ckName = ckName;
		this.ckImg = ckImg;
		this.ckInfo = ckInfo;
		this.ckCategory = ckCategory;
	}

	
	
	
}
