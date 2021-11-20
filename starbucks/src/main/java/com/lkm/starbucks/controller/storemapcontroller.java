package com.lkm.starbucks.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lkm.starbucks.command.command;
import com.lkm.starbucks.command.store.storemap_ajaxcommand;

@Controller
public class storemapcontroller {

	@Autowired
	private SqlSession sqlsession;
	private command command;
	
	@RequestMapping(value="store/storeMap",method=RequestMethod.GET)
	public String getstorelist(HttpServletRequest req,Model model) {
		
		return "storemap/storemap";
	}
	
	@RequestMapping(value="store/storeMap_ajax",method=RequestMethod.POST)
	public String storeMap_ajax(HttpServletRequest req,Model model) {
		
		model.addAttribute("req", req);
		command = new storemap_ajaxcommand();
		command.execute(sqlsession, model);
		
		return "storemap/storemap_ajax";
	}
	
}
