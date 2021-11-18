package com.lkm.starbucks.command.menu;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.lkm.starbucks.command.command;
import com.lkm.starbucks.dao.fooddao;
import com.lkm.starbucks.dto.fooddto;
import com.lkm.starbucks.dto.menu_typedto;

public class food_listcommand implements command {

	@Override
	public void execute(SqlSession sqlsession, Model model) {
		
		Map<String,Object> map = model.asMap();
		
		HttpServletRequest req = (HttpServletRequest) map.get("req");
		fooddao fdao = sqlsession.getMapper(fooddao.class);
		
		ArrayList<fooddto> foodlist = fdao.getfoodlist();
		ArrayList<menu_typedto> menulist = fdao.getmenulist();
		
		model.addAttribute("flist", foodlist);
		model.addAttribute("mtlist", menulist);
		String type = req.getParameter("type");
		
		if(type !=null) {
			model.addAttribute("type",type); 
		}
	}

}
