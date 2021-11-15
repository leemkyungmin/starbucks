package com.lkm.starbucks.command.menu;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.lkm.starbucks.command.command;
import com.lkm.starbucks.dao.drinkdao;
import com.lkm.starbucks.dto.drinkdto;
import com.lkm.starbucks.dto.menu_typedto;

public class drinklistcommand implements command {

	@Override
	public void execute(SqlSession sqlsession, Model model) {
		
		Map<String,Object> map =model.asMap();
		
		HttpServletRequest req = (HttpServletRequest) map.get("req");
		
		String type =req.getParameter("type");
		
		ArrayList<drinkdto> dlist = new ArrayList<drinkdto>();
		ArrayList<menu_typedto> mtlist = new ArrayList<menu_typedto>();
		drinkdao drinkdao = sqlsession.getMapper(drinkdao.class);
		
		dlist = drinkdao.all_drink_list();
		mtlist = drinkdao.getmenutypelist("1");	
		model.addAttribute("dlist", dlist);
		model.addAttribute("mtlist",mtlist);
		if(type !=null) {
			model.addAttribute("type",type);
		}
		

	}

}
