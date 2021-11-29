package com.lkm.starbucks.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter

public class order_listdto {

	public int uIdx,oCount,oPrice,bIdx;
	public String oNum,oName,oDate,oStatus,bName;
	
	public order_listdto() {}

	public order_listdto(int uIdx, int oCount, int oPrice, int bIdx, String oNum, String oName, String oDate,
			String oStatus, String bName) {
		super();
		this.uIdx = uIdx;
		this.oCount = oCount;
		this.oPrice = oPrice;
		this.bIdx = bIdx;
		this.oNum = oNum;
		this.oName = oName;
		this.oDate = oDate;
		this.oStatus = oStatus;
		this.bName = bName;
	}

	
	
	
}
