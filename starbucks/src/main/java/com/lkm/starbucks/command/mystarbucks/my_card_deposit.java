package com.lkm.starbucks.command.mystarbucks;

import java.util.Enumeration;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.lkm.starbucks.command.command;
import com.lkm.starbucks.dto.usersdto;

public class my_card_deposit implements command {

	@Override
	public void execute(SqlSession sqlsession, Model model) {
		
		Map<String,Object> map =model.asMap();
		HttpServletRequest req = (HttpServletRequest) map.get("req");
		
		String amount =req.getParameter("amount");
		//String uclidx= (String) req.getSession().getAttribute("uclidx");
		
		usersdto udto =(usersdto) req.getSession().getAttribute("udto");
		



		

	}

}
