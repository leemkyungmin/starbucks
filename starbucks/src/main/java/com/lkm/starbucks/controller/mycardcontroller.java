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

import com.lkm.starbucks.command.command;
import com.lkm.starbucks.command.mystarbucks.my_card_deposit;
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
	
	@RequestMapping(value="my/card/paysuccess",method=RequestMethod.GET)
	public String paysuccess(HttpServletRequest req ,Model model) {
		
		Enumeration<String> attributes = req.getSession().getAttributeNames();
		while (attributes.hasMoreElements()) {
		    String attribute = (String) attributes.nextElement();
		    System.out.println(attribute+" : "+req.getSession().getAttribute(attribute));
		}
		
		model.addAttribute("req",req);
		
		command = new my_card_deposit();
		command.execute(sqlsession, model);
		
		return "mystarbucks/card/paysuccess";
	}
	

}
