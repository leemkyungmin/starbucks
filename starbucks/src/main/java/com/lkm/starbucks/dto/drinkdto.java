package com.lkm.starbucks.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class drinkdto {

	int dIdx,dKal,dSaturate,dProtein,dSalt,dSugar,dCaffeine,ftIdx;
	String dName,dSumnail,dLargeimg,dInfo;
	
	public drinkdto() {}

	public drinkdto(int dIdx, int dKal, int dSaturate, int dProtein, int dSalt, int dSugar, int dCaffeine, int ftIdx,
			String dName, String dSumnail, String dLargeimg, String dInfo) {
		super();
		this.dIdx = dIdx;
		this.dKal = dKal;
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
	}
	
	
	
}
