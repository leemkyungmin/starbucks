package com.lkm.starbucks.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.lkm.starbucks.command.command;
import com.lkm.starbucks.command.event.eventlistcommand;

@Controller
public class eventcontroller  {
	@Autowired
	SqlSession sqlsession;
	command command;
	
	@RequestMapping(value="event/eventList",method=RequestMethod.GET)
	public String getEventList(HttpServletRequest req ,Model model) {
		
		model.addAttribute("req",req);
		
		command=new eventlistcommand();
		command.execute(sqlsession, model);
		
		return "event/eventPage";
	}
}
