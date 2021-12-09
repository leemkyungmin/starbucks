package com.lkm.starbucks.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class fooddto {

	int fIdx,fKcal,fSaturate,fProtein,fSalt,fSugar,ftIdx,fPrice;
	String fName,fNotice,fImg,fLargeimg,fInfo,fSize;
	
	public fooddto() {}

	public fooddto(int fIdx, int fKcal, int fSaturate, int fProtein, int fSalt, int fSugar, int ftIdx,int fPrice, String fName,
			String fNotice, String fImg, String fLargeimg, String fInfo, String fSize) {
		super();
		this.fIdx = fIdx;
		this.fKcal = fKcal;
		this.fSaturate = fSaturate;
		this.fProtein = fProtein;
		this.fSalt = fSalt;
		this.fSugar = fSugar;
		this.ftIdx = ftIdx;
		this.fName = fName;
		this.fNotice = fNotice;
		this.fImg = fImg;
		this.fLargeimg = fLargeimg;
		this.fInfo = fInfo;
		this.fSize = fSize;
		this.fPrice=fPrice;
	}
	
	
	
}
