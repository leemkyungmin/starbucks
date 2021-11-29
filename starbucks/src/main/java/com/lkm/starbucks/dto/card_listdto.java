package com.lkm.starbucks.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class card_listdto {

	int clIdx;
	String clName, clInfo, clImg, clReg_date;

	public card_listdto() {
	}

	public card_listdto(int clIdx, String clName, String clInfo, String clImg, String clReg_date) {
		super();
		this.clIdx = clIdx;
		this.clName = clName;
		this.clInfo = clInfo;
		this.clImg = clImg;
		this.clReg_date = clReg_date;
	}

}
