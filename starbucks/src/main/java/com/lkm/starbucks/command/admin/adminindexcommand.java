package com.lkm.starbucks.command.admin;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.lkm.starbucks.command.command;

public class adminindexcommand implements command {

	@Override
	public void execute(SqlSession sqlsession, Model model) {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date today = new Date();
		
		int year = today.getYear();
		int month = today.getMonth();
		int date =today.getDate();
		
		Calendar cal = Calendar.getInstance();
		
		
		
		String month_cal =Integer.toString(year)+"-"+Integer.toString(month);
		
		cal.set(year, month, date);
		String date_cal =sdf.format(cal);
		

	}

}
