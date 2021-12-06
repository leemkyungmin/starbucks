package com.lkm.starbucks.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class mycartdto {

	public int mcIdx,mcPrice,mcCount,uIdx,Targetidx;
	public String mcType,mcName,mcDate;
	
	
	public mycartdto() {}


	public mycartdto(int mcIdx, int mcPrice, int mcCount, int uIdx, int targetidx, String mcType, String mcName,
			String mcDate) {
		super();
		this.mcIdx = mcIdx;
		this.mcPrice = mcPrice;
		this.mcCount = mcCount;
		this.uIdx = uIdx;
		Targetidx = targetidx;
		this.mcType = mcType;
		this.mcName = mcName;
		this.mcDate = mcDate;
	}
	
	
}
