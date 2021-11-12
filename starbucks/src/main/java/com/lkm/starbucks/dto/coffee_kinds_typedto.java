package com.lkm.starbucks.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter

public class coffee_kinds_typedto {

	public int cktIdx;
	public String cktName,cktTitle,cktInfo,cktImg;
	
	public coffee_kinds_typedto() {}

	public coffee_kinds_typedto(int cktIdx, String cktName, String cktTitle, String cktInfo, String cktImg) {
		super();
		this.cktIdx = cktIdx;
		this.cktName = cktName;
		this.cktTitle = cktTitle;
		this.cktInfo = cktInfo;
		this.cktImg = cktImg;
	}	
}
