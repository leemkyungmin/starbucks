package com.lkm.starbucks.command.mystarbucks;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.lkm.starbucks.command.command;
import com.lkm.starbucks.dao.mystarbucksdao;
import com.lkm.starbucks.dto.mycartdto;
import com.lkm.starbucks.dto.usersdto;

public class mymenucommand implements command {

	@Override
	public void execute(SqlSession sqlsession, Model model) {
		
		Map<String,Object> map =model.asMap();
		HttpServletRequest req =(HttpServletRequest) map.get("req");
		
		usersdto udto = (usersdto) req.getSession().getAttribute("udto");
		int uidx =udto.getUIdx();
		
		Map<String,Object> param = new HashMap<String, Object>();
		param.put("uidx",udto.getUIdx());
		param.put("type","DRINK");
		
		
		mystarbucksdao mdao =sqlsession.getMapper(mystarbucksdao.class);
		ArrayList<mycartdto> mclist = mdao.getmycart(param);
		
		
		model.addAttribute("mclist", mclist);

		
		

	}

}
