package com.lkm.starbucks.command.notice;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.google.inject.internal.util.Maps;
import com.lkm.starbucks.command.command;
import com.lkm.starbucks.dao.noticedao;
import com.lkm.starbucks.dto.noticedto;

public class notice_viewcommand implements command {

	@Override
	public void execute(SqlSession sqlsession, Model model) {
		// TODO Auto-generated method stub
		Map<String,Object> map = model.asMap();
		HttpServletRequest req  = (HttpServletRequest) map.get("req");
		
		String nidx = req.getParameter("nidx");
		
		noticedao ndao = sqlsession.getMapper(noticedao.class);
		
		ndao.update_hit(nidx);
		noticedto ndto = ndao.notice_view(nidx);
		
		model.addAttribute("ndto", ndto);
				
		
	}

}
