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
import com.lkm.starbucks.command.coffee.*;

@Controller
public class coffeecontroller {

	@Autowired
	private SqlSession sqlsession;
	private command command;
	
	//커피 리스트 
	@RequestMapping(value="coffee/coffee_list",method=RequestMethod.GET)
	public String coffeeList(HttpServletRequest req,Model model) {
		
		String Category = req.getParameter("Category") ==null ? "1" : req.getParameter("Category");
		
		model.addAttribute("Category",Category);
		
		command = new coffeecommand();
		command.execute(sqlsession, model);
		
		return "product/coffee_list";
	}
	
	@RequestMapping(value="coffee/coffee_list_ajax",method=RequestMethod.GET)

	public String coffeelist_ajax(HttpServletRequest req,Model model) {
		String Category = req.getParameter("Category") ==null ? "1" : req.getParameter("Category");
		System.out.println("Category:"+Category);
		model.addAttribute("Category",Category);
		
		command = new coffeecommand();
		command.execute(sqlsession, model);
		
		return "product/coffee_list_ajax";
	}
	
	
}
