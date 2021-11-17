package com.lkm.starbucks.command.menu;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.lkm.starbucks.command.command;
import com.lkm.starbucks.dao.drinkdao;
import com.lkm.starbucks.dto.drinkdto;

public class drink_product_viewcommand implements command {

	@Override
	public void execute(SqlSession sqlsession, Model model) {

		Map<String,Object> map = model.asMap();
		
		HttpServletRequest req = (HttpServletRequest) map.get("req");
		
		
		drinkdao drinkdao = sqlsession.getMapper(drinkdao.class);
		
		String didx = req.getParameter("didx");
		
		
		drinkdto drinkdto =  drinkdao.getdrink(didx);
		
		
		model.addAttribute("drink", drinkdto);
		model.addAttribute("title", drinkdao.getdrinktype(didx));

	}

}
