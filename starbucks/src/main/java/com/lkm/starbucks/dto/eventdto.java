package com.lkm.starbucks.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class eventdto {

	public int eIdx,eHit;
	public String eTitle,eType,eContent,eDate,eStartday,eEndday,eSumnail;
	
	public eventdto() {}

	public eventdto(int eIdx, int eHit, String eTitle, String eType, String eContent, String eDate, String eStartday,
			String eEndday, String eSumnail) {
		super();
		this.eIdx = eIdx;
		this.eHit = eHit;
		this.eTitle = eTitle;
		this.eType = eType;
		this.eContent = eContent;
		this.eDate = eDate;
		this.eStartday = eStartday;
		this.eEndday = eEndday;
		this.eSumnail = eSumnail;
	}

	
	
	
	
	
}
