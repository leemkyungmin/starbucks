package com.lkm.starbucks.command.coffee;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.lkm.starbucks.command.command;
import com.lkm.starbucks.dao.coffeedao;
import com.lkm.starbucks.dto.*;

public class coffee_listcommand implements command {

	@Override
	public void execute(SqlSession sqlsession, Model model) {
		
		Map<String,Object> map = model.asMap();
		String Category = (String) map.get("Category");
		
		coffeedao cdao = sqlsession.getMapper(coffeedao.class);
		
		ArrayList<coffee_kindsdto> cklist = cdao.getCoffeeList(Category);
		ArrayList<coffee_kinds_typedto> cktlist = cdao.getCoffeeType(Category);
		System.out.println("size:  "+cktlist.size());
		model.addAttribute("cktlist",cktlist);
		model.addAttribute("cklist", cklist);
		model.addAttribute("Category", Category);
				
	}

}
