package com.lkm.starbucks.command.mystarbucks;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.lkm.starbucks.command.command;
import com.lkm.starbucks.dao.mystarbucksdao;
import com.lkm.starbucks.dto.user_card_listdto;
import com.lkm.starbucks.dto.usersdto;

public class my_cardlistcommand implements command{

	@Override
	public void execute(SqlSession sqlsession, Model model) {
		
		Map<String,Object> map = model.asMap();
		HttpServletRequest req = (HttpServletRequest) map.get("req");
		usersdto udto = (usersdto) req.getSession().getAttribute("udto");
		int uidx =udto.getUIdx();
		mystarbucksdao mdao  = sqlsession.getMapper(mystarbucksdao.class);
		
		ArrayList<user_card_listdto> ucllist = mdao.getCardList(uidx);
		
		model.addAttribute("ucllist", ucllist);
		
	}

	
	
}
