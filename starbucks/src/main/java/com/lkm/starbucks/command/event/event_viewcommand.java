package com.lkm.starbucks.command.event;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.lkm.starbucks.command.command;
import com.lkm.starbucks.dao.eventdao;
import com.lkm.starbucks.dto.eventdto;

public class event_viewcommand implements command {

	@Override
	public void execute(SqlSession sqlsession, Model model) {
		
		Map<String,Object> map = model.asMap();
		HttpServletRequest req = (HttpServletRequest) map.get("req");
		
		String eidx = req.getParameter("eidx");
		eventdao edao =sqlsession.getMapper(eventdao.class);
		eventdto event = edao.geteventinfo(eidx);
		
		ArrayList<eventdto> defaultEventList =edao.getProgressEvent();
		model.addAttribute("eventlist", defaultEventList);
		model.addAttribute("event", event);
		

	}

}
