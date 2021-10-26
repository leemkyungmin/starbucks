package com.lkm.starbucks.dto;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class usersdto {

	public int uIdx;
	public String uIds;
	public String uPw;
	public String uPhone;
	public String uEmail;
	public String uNickName;
	public String uGrade;
	public Date uDate;
	public int uStarcount;
	public String uPower;
	
	public usersdto (){}

	public usersdto(int uIdx, String uIds, String uPw, String uPhone, String uEmail, String uNickName, String uGrade,
			Date uDate, int uStarcount, String uPower) {
		super();
		this.uIdx = uIdx;
		this.uIds = uIds;
		this.uPw = uPw;
		this.uPhone = uPhone;
		this.uEmail = uEmail;
		this.uNickName = uNickName;
		this.uGrade = uGrade;
		this.uDate = uDate;
		this.uStarcount = uStarcount;
		this.uPower = uPower;
	}
	
	
	
}
