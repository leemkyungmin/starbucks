package com.lkm.starbucks.controller;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.lkm.starbucks.command.command;
import com.lkm.starbucks.command.mystarbucks.my_card_deposit_resultcommand;
import com.lkm.starbucks.command.mystarbucks.my_card_depositcommand;
import com.lkm.starbucks.command.mystarbucks.my_card_historycommand;
import com.lkm.starbucks.command.mystarbucks.my_cardlistcommand;
import com.lkm.starbucks.command.mystarbucks.mystarbucks_indexcommand;
import com.lkm.starbucks.command.mystarbucks.new_card_viewcommand;
import com.lkm.starbucks.command.mystarbucks.new_cardcommand;
import com.lkm.starbucks.dao.mystarbucksdao;
import com.lkm.starbucks.dto.usersdto;

@Controller
public class mycardcontroller {

	@Autowired
	private SqlSession sqlsession;
	private command command;

	@RequestMapping(value = "my/card/new_card", method = RequestMethod.GET)
	public String new_card(HttpServletRequest req, Model model) {

		if (req.getSession().getAttribute("udto") == null) {

			String redirect_url = "my/card/new_card";

			return "redirect:/login/loginPage?redirect_url=" + redirect_url;

		} else {
			command = new new_cardcommand();
			command.execute(sqlsession, model);

			return "mystarbucks/card/new_card";
		}
	}

	@RequestMapping(value = "my/card/new_card_view", method = RequestMethod.POST)
	public String new_card_view(HttpServletRequest req, Model model) {

		if (req.getSession().getAttribute("udto") == null) {

			String redirect_url = "my/card/new_card";

			return "redirect:/login/loginPage?redirect_url=" + redirect_url;

		} else {

			model.addAttribute("req", req);
			command = new new_card_viewcommand();
			command.execute(sqlsession, model);

			return "mystarbucks/card/new_card_view";
		}
	}

	@RequestMapping(value = "my/card/insert_newcard", method = RequestMethod.POST)
	@ResponseBody
	public String insertcard(HttpServletRequest req, Model model) {
		
		if(req.getSession().getAttribute("udto") !=null) {
			usersdto udto = (usersdto) req.getSession().getAttribute("udto");
			mystarbucksdao mdao = sqlsession.getMapper(mystarbucksdao.class);
			String jsonData = req.getParameter("data");

			JSONObject obj = new JSONObject(jsonData);

			int uidx = udto.getUIdx();
			String cardname = obj.getString("cardname");
			String cardnum = obj.getString("cardnum");
			String percard = obj.getString("percard");
			String clidx = obj.getString("clidx");
			String pin_num = obj.getString("pin_num");
			
			if(percard.equals("1")) {
				mdao.update_per_card(uidx);
			}
			
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("uidx", uidx);
			params.put("cardname", cardname);
			params.put("cardnum", cardnum);
			params.put("percard", percard);
			params.put("clidx", clidx);
			params.put("pin_num", pin_num);
			
			int result = mdao.insert_card(params);
			

			return result+"";
		} else {
			return "sign_in";
		}
		
		
	}
	
	@RequestMapping(value="my/card/my_card_list",method=RequestMethod.GET)
	public String my_card_list(HttpServletRequest req ,Model model) {
		
		if (req.getSession().getAttribute("udto") == null) {

			String redirect_url = "my/card/my_card_list";

			return "redirect:/login/loginPage?redirect_url=" + redirect_url;

		} else {

			model.addAttribute("req", req);
			command=  new my_cardlistcommand();
			command.execute(sqlsession, model);
			

			return "mystarbucks/card/my_card_list";
		}
		
	}
	/*
	 * 페이지 새로고침시
	 * 중복으로 카드 금액 올라가지 않도록
	 * 업데이트후 redirect
	 * 
	 */
	@RequestMapping(value="my/card/paysuccess",method=RequestMethod.GET)
	public String paysuccess(HttpServletRequest req ,Model model,RedirectAttributes ra) {
		
		model.addAttribute("req",req);
		ra.addAttribute("uclidx",req.getParameter("uclidx"));
		ra.addAttribute("amount",req.getParameter("amount"));
		
		command = new my_card_depositcommand();
		command.execute(sqlsession, model);
		
		return "redirect:/my/card/payresult";
	}
	@RequestMapping(value="my/card/payresult",method=RequestMethod.GET)
	public String payresult(HttpServletRequest req ,Model model) {
		
		model.addAttribute("req",req);
		command=new my_card_deposit_resultcommand();
		command.execute(sqlsession, model);
		
		
		return "mystarbucks/card/paysuccess";
	}
	
	/*
	 * 카드 충전 및 사용 내역 
	 * 
	 */
	@RequestMapping(value="my/card/card_history",method=RequestMethod.POST)
	public String card_history(HttpServletRequest req,Model model) {
		model.addAttribute("req",req);
		
		command =new my_card_historycommand();
		command.execute(sqlsession, model);
		
		return "mystarbucks/card/my_card_history_ajax";
	}
	
	/*
	 * 카드삭제
	 * 
	 * 
	 */
	@RequestMapping(value="my/card/drop_card",method=RequestMethod.POST)
	@ResponseBody
	public String drop_card(HttpServletRequest req,Model model) {
		
		usersdto udto = (usersdto) req.getSession().getAttribute("udto");
		
		if(udto ==null) {
			return "login_check";
		} else {
			
			String jsonData = req.getParameter("data");
			JSONObject obj = new JSONObject(jsonData);
			String uclidx =obj.getString("uclidx");
			String pinNum =obj.getString("pinNum");
			
			
			
			Map<String,Object> param = new HashMap<String, Object>();
			param.put("uclidx",uclidx);
			param.put("pinNum", pinNum);
			param.put("uidx",udto.getUIdx());
			
			mystarbucksdao mdao =sqlsession.getMapper(mystarbucksdao.class);
			int a=mdao.drop_card_deposit(param);
			int result =mdao.drop_card(param);
			
			
			
			if(result>0) {
				return "sucess";
			} else {
				return "false";
			}
		}
		
	}
	
	
	

}
