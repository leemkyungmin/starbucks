package com.lkm.starbucks.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class noticedto {

	int nIdx,nHit; 
	String nTitle,nContent,nDate;
	
	public noticedto() {}

	public noticedto(int nIdx, int nHit, String nTitle, String nContent, String nDate) {
		super();
		this.nIdx = nIdx;
		this.nHit = nHit;
		this.nTitle = nTitle;
		this.nContent = nContent;
		this.nDate = nDate;
	}
	
	
	
}
