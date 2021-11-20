package com.lkm.starbucks.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class branch_infodto {

	int bIdx;
	String bName,bNumber,bLocation;
	
	public branch_infodto() {}

	public branch_infodto(int bIdx, String bName, String bNumber, String bLocation) {
		super();
		this.bIdx = bIdx;
		this.bName = bName;
		this.bNumber = bNumber;
		this.bLocation = bLocation;
	}
	
	
	
}
