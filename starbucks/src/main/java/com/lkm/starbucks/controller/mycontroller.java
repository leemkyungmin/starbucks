package com.lkm.starbucks.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.lkm.starbucks.command.command;
import com.lkm.starbucks.command.mystarbucks.my_reward_historycommand;
import com.lkm.starbucks.command.mystarbucks.mystarbucks_indexcommand;

@Controller
public class mycontroller {

	@Autowired
	private SqlSession sqlsession;
	private command command;

	@RequestMapping(value = "my/index", method = RequestMethod.GET)
	public String mystarbucks(HttpServletRequest req, Model model) {

		if (req.getSession().getAttribute("udto") == null) {

			String redirect_url = "my/index";

			return "redirect:../login/loginPage?redirect_url=" + redirect_url;

		} else {
			model.addAttribute("req", req);
			command = new mystarbucks_indexcommand();
			command.execute(sqlsession, model);

			return "mystarbucks/myindex";
		}

	}
	
	//리워드 정보
	@RequestMapping(value = "my/reward/reward_info", method = RequestMethod.GET)
	public String reward_info(HttpServletRequest req, Model model) {
		if (req.getSession().getAttribute("udto") == null) {

			String redirect_url = "my/reward/reward_info";

			return "redirect:/login/loginPage?redirect_url=" + redirect_url;

		} else {

			return "mystarbucks/reward/reward_info";
		}
	}
	
	// 내 리워드 내역
	@RequestMapping(value = "my/reward/my_reward_history", method = RequestMethod.GET)
	public String reward_history(HttpServletRequest req, Model model) {
		if (req.getSession().getAttribute("udto") == null) {

			String redirect_url = "my/reward/my_reward_history";

			return "redirect:/login/loginPage?redirect_url=" + redirect_url;

		} else {
			model.addAttribute("req",req);
			command =  new my_reward_historycommand();
			command.execute(sqlsession, model);
			return "mystarbucks/reward/myreward_history";
		}
	}

}
