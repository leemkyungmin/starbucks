package com.lkm.starbucks.command.coffee;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.lkm.starbucks.command.command;
import com.lkm.starbucks.dao.coffeedao;
import com.lkm.starbucks.dto.coffee_kinds_typedto;
import com.lkm.starbucks.dto.coffee_kindsdto;

public class coffee_product_viewcommand implements command {

	@Override
	public void execute(SqlSession sqlsession, Model model) {
		// TODO Auto-generated method stub
		
		Map<String,Object> map =model.asMap();
		HttpServletRequest req = (HttpServletRequest) map.get("req");
		
		String ckidx = req.getParameter("ckidx");
		System.out.println("ckidx : "+ckidx);
		coffeedao cdao =sqlsession.getMapper(coffeedao.class);
		
		coffee_kindsdto ck = cdao.coffee_product_info(ckidx);
		coffee_kinds_typedto ckt = cdao.coffee_product_type_info(ckidx);
		
		model.addAttribute("ck",ck);
		model.addAttribute("ckt",ckt);

	}

}
