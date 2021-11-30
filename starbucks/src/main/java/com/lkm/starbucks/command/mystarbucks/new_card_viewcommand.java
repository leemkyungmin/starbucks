package com.lkm.starbucks.command.mystarbucks;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.lkm.starbucks.command.command;
import com.lkm.starbucks.dao.mystarbucksdao;
import com.lkm.starbucks.dto.card_listdto;

public class new_card_viewcommand implements command {

	@Override
	public void execute(SqlSession sqlsession, Model model) {
		
		Map<String,Object> map = model.asMap();
		HttpServletRequest req = (HttpServletRequest) map.get("req");
		
		int clidx=  Integer.parseInt(req.getParameter("clidx"));
		
		mystarbucksdao mdao  = sqlsession.getMapper(mystarbucksdao.class);
		
		card_listdto cdto = mdao.getCardinfo(clidx);
		
		model.addAttribute("cdto",cdto);
		
	}

	
}
