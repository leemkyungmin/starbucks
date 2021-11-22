package com.lkm.starbucks.command.event;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.lkm.starbucks.command.command;
import com.lkm.starbucks.dao.eventdao;
import com.lkm.starbucks.dto.eventdto;

public class eventlistcommand implements command {

	@Override
	public void execute(SqlSession sqlsession, Model model) {
		
		Map<String,Object> map = model.asMap();
		HttpServletRequest req = (HttpServletRequest) map.get("req");
		String type = req.getParameter("type");
		
		eventdao edao = sqlsession.getMapper(eventdao.class);
		//진행중인 이벤트
		ArrayList<eventdto> progressEvent = edao.getProgressEvent();
		model.addAttribute("pEvent", progressEvent);
		//종료된 이벤트
		ArrayList<eventdto> endEvent =edao.getEndEvent();
		model.addAttribute("endEvent", endEvent);
		
		
		if(type !=null) {
			model.addAttribute("type",type);
		}

	}

}
