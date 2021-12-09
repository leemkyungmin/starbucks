package com.lkm.starbucks.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class drinkdto {

	int dIdx,dKcal,dSaturate,dProtein,dSalt,dSugar,dCaffeine,ftIdx,dPrice;
	String dName,dSumnail,dLargeimg,dInfo,dAllergy,dSize;
	
	public drinkdto() {}

	public drinkdto(int dIdx, int dKcal, int dSaturate, int dProtein, int dSalt, int dSugar, int dCaffeine, int ftIdx,int dPrice,
			String dName, String dSumnail, String dLargeimg, String dInfo, String dAllergy, String dSize) {
		super();
		this.dIdx = dIdx;
		this.dKcal = dKcal;
		this.dSaturate = dSaturate;
		this.dProtein = dProtein;
		this.dSalt = dSalt;
		this.dSugar = dSugar;
		this.dCaffeine = dCaffeine;
		this.ftIdx = ftIdx;
		this.dName = dName;
		this.dSumnail = dSumnail;
		this.dLargeimg = dLargeimg;
		this.dInfo = dInfo;
		this.dAllergy = dAllergy;
		this.dSize = dSize;
		this.dPrice=dPrice;
	}

	
}
