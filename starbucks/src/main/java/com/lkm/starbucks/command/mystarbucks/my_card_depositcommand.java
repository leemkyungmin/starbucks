package com.lkm.starbucks.command.mystarbucks;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.lkm.starbucks.command.command;
import com.lkm.starbucks.dao.mystarbucksdao;


public class my_card_depositcommand implements command {

	@Override
	public void execute(SqlSession sqlsession, Model model) {
		
		Map<String,Object> map =model.asMap();
		HttpServletRequest req = (HttpServletRequest) map.get("req");
		
		String amount =req.getParameter("amount");
		String uclidx = req.getParameter("uclidx");
		String uidx = req.getParameter("uidx");
		
		Map<String,Object> params =new HashMap<String, Object>();
		
		params.put("amount", amount);
		params.put("uclidx", uclidx);
		params.put("uidx", uidx);
		
		mystarbucksdao mdao = sqlsession.getMapper(mystarbucksdao.class);
		
		//카드 금액 업데이트
		mdao.update_my_card_deposit(params);
		//카드 충전 내역 추가 
		params.put("type", "충전");
		mdao.insert_my_card_deposit(params);
		
		

	}

}
