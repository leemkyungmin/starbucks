package com.lkm.starbucks.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.apache.maven.model.Model;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lkm.starbucks.command.command;

@Controller
public class admincontroller {

	@Autowired
	command command;
	SqlSession sqlsession;
	
	@RequestMapping("admin/login")
	public String adminpage(HttpServletRequest req,Model model) {
		
		//일별 매출 
		//매장별 매출
		//커피,음식,음료 베스트 상품 
		//
		
		return "";
	}
	
}
