package com.lkm.starbucks.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lkm.starbucks.command.command;
import com.lkm.starbucks.command.mystarbucks.my_reward_historycommand;
import com.lkm.starbucks.command.mystarbucks.mystarbucks_indexcommand;
import com.lkm.starbucks.dao.mystarbucksdao;
import com.lkm.starbucks.dto.myrewarddto;
import com.lkm.starbucks.dto.order_listdto;
import com.lkm.starbucks.dto.usersdto;

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
	
	@RequestMapping(value="my/reward/myreward_history_ajax",method=RequestMethod.POST)
	@ResponseBody
	public ArrayList<myrewarddto> reward_history_ajax(HttpServletRequest req,Model model) {
		
		usersdto udto = (usersdto) req.getSession().getAttribute("udto");
		
		String jsonData = req.getParameter("json");
		
		JSONObject obj =new JSONObject(jsonData);
		
		String begin_day = obj.getString("begin");
		String today = obj.getString("end");
		
		Map<String,Object> params = new HashMap<String, Object>();
		params.put("uidx",udto.getUIdx());
		params.put("today",today);
		params.put("begin_day",begin_day);
		
		mystarbucksdao mdao =  sqlsession.getMapper(mystarbucksdao.class);
		ArrayList<myrewarddto> mylist_ajax = mdao.reward_history(params);
		
		
		
		return mylist_ajax;
	}
	
	@RequestMapping(value="my/reeward/oder_list_ajax",method=RequestMethod.POST)
	@ResponseBody
	public ArrayList<order_listdto> getOrder_info(HttpServletRequest req,Model model){
		
		
		ArrayList<order_listdto> olist = new ArrayList<order_listdto>();
		
		Map<String,Object> params = new HashMap<String, Object>();
		params.put("oNum",req.getParameter("oNum"));
		
		mystarbucksdao mdao = sqlsession.getMapper(mystarbucksdao.class);
		
		olist = mdao.get_order_info(params);
		
		return olist;
		
	}

}
