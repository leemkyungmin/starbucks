package com.lkm.starbucks.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class menu_typedto {

	int ftIdx;
	String ftName,ftType,ftName2;
	
	public menu_typedto() {}

	public menu_typedto(int ftIdx, String ftName, String ftType, String ftName2) {
		super();
		this.ftIdx = ftIdx;
		this.ftName = ftName;
		this.ftType = ftType;
		this.ftName2 = ftName2;
	}
	
	
	
}
