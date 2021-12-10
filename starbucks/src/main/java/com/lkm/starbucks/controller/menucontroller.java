package com.lkm.starbucks.controller;

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
import com.lkm.starbucks.command.menu.drink_product_viewcommand;
import com.lkm.starbucks.command.menu.drinklistcommand;
import com.lkm.starbucks.command.menu.food_listcommand;
import com.lkm.starbucks.command.menu.food_product_viewcommand;
import com.lkm.starbucks.dao.coffeedao;
import com.lkm.starbucks.dao.drinkdao;
import com.lkm.starbucks.dto.usersdto;

@Controller
public class menucontroller {

	@Autowired
	private SqlSession sqlsession;
	private command command;
	
	////// 음료  
	
	@RequestMapping(value="menu/drink_list",method=RequestMethod.GET)
	public String get_drink_list(HttpServletRequest req,Model model) {
		
		model.addAttribute("req", req);
		
		command = new drinklistcommand();
		command.execute(sqlsession, model);
		
		return "product/drink_list";
	}
	
	@RequestMapping(value="menu/drink/product_view",method=RequestMethod.POST)
	public String drink_product_view(HttpServletRequest req,Model model) {
		
		model.addAttribute("req",req);
		command = new drink_product_viewcommand();
		command.execute(sqlsession, model);
		
		return "product/drink_product_view";
	}
	
	//음식
	
	@RequestMapping(value="menu/food_list",method=RequestMethod.GET)
	public String foodlist(HttpServletRequest req,Model model) {
		
		model.addAttribute("req", req);
		
		command = new food_listcommand();
		command.execute(sqlsession, model);
		
		
		return "product/food_list";
	}
	
	@RequestMapping( value="menu/food/product_view", method=RequestMethod.POST)
	public String food_product_list(HttpServletRequest req,Model model) {
		
		model.addAttribute("fidx", req.getParameter("fidx"));
		
		command = new food_product_viewcommand();
		command.execute(sqlsession, model);
		
		
		return "product/food_product_view";
	}
	
	@RequestMapping( value="menu/InsertMyMenu",method=RequestMethod.POST)
	@ResponseBody
	public String insertMyMenu(HttpServletRequest req,Model model) {
		
		usersdto udto = (usersdto) req.getSession().getAttribute("udto");
		
		if(udto !=null) {
			
			String jsonData = req.getParameter("data");

			JSONObject obj = new JSONObject(jsonData);

			int uidx = udto.getUIdx();
			String name = obj.getString("name");
			String type = obj.getString("type");
			String price = obj.getString("price");
			String idx =obj.getString("idx");
			int count =1;
			
			
			
			Map<String,Object> param = new HashMap<String, Object>();
			param.put("uidx", uidx);
			param.put("name", name);
			param.put("type", type);
			param.put("price", price);
			param.put("idx", idx);
			param.put("count", count);
			coffeedao cdao = sqlsession.getMapper(coffeedao.class);
			
			int result =cdao.insert_menu(param);
			
			return "success";
			
		} else {
			
			return "login_check";
		}
		
		
		
		
	}
	
}
