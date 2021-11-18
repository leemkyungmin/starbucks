package com.lkm.starbucks.command.menu;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.lkm.starbucks.command.command;
import com.lkm.starbucks.dao.fooddao;
import com.lkm.starbucks.dto.fooddto;
import com.lkm.starbucks.dto.menu_typedto;

public class food_product_viewcommand implements command {

	@Override
	public void execute(SqlSession sqlsession, Model model) {
	
		Map<String,Object> map = model.asMap();
		String fidx = (String) map.get("fidx");
		fooddao fdao = sqlsession.getMapper(fooddao.class);
		
		fooddto fdto = fdao.food_product(fidx);
		menu_typedto mtdto  = fdao.food_proudct_type(fidx);
		
		System.out.println(fdto.getFNotice());
		
		model.addAttribute("fdto", fdto);
		model.addAttribute("mtdto", mtdto);

	}

}
