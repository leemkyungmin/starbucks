package com.lkm.starbucks.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lkm.starbucks.command.command;
import com.lkm.starbucks.command.notice.notice_viewcommand;
import com.lkm.starbucks.command.notice.noticecommand;

@Controller

public class noticecontroller {
	
	@Autowired
	SqlSession sqlsession;
	command command;
	
	@RequestMapping(value="notice/noticeList",method=RequestMethod.GET)
	public String notice(HttpServletRequest req,Model model) {
		
		model.addAttribute("req",req);
		command = new noticecommand();
		command.execute(sqlsession, model);
		
		return "notice/notice_list";
	}
	
	@RequestMapping(value="notice/notice_view", method=RequestMethod.POST)
	public String notice_view(HttpServletRequest req ,Model model) {
		
		model.addAttribute("req", req);
		
		command = new notice_viewcommand();
		command.execute(sqlsession, model);
		
		
		
		return "";
	}
	
}
