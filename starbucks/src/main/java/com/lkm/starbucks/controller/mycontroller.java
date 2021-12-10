package com.lkm.starbucks.controller;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.json.JSONArray;
import org.json.JSONObject;
import org.json.simple.JSONAware;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lkm.starbucks.command.command;
import com.lkm.starbucks.command.mystarbucks.my_reward_historycommand;
import com.lkm.starbucks.command.mystarbucks.mymenucommand;
import com.lkm.starbucks.command.mystarbucks.mystarbucks_indexcommand;
import com.lkm.starbucks.command.mystarbucks.new_cardcommand;
import com.lkm.starbucks.dao.mystarbucksdao;
import com.lkm.starbucks.dao.storedao;
import com.lkm.starbucks.dto.branch_infodto;
import com.lkm.starbucks.dto.mycartdto;
import com.lkm.starbucks.dto.myrewarddto;
import com.lkm.starbucks.dto.order_listdto;
import com.lkm.starbucks.dto.user_card_depositdto;
import com.lkm.starbucks.dto.user_card_listdto;
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

	// 리워드 정보
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
			model.addAttribute("req", req);
			command = new my_reward_historycommand();
			command.execute(sqlsession, model);
			return "mystarbucks/reward/myreward_history";
		}
	}

	@RequestMapping(value = "my/reward/myreward_history_ajax", method = RequestMethod.POST)
	@ResponseBody
	public ArrayList<myrewarddto> reward_history_ajax(HttpServletRequest req, Model model) {

		usersdto udto = (usersdto) req.getSession().getAttribute("udto");

		String jsonData = req.getParameter("json");

		JSONObject obj = new JSONObject(jsonData);

		String begin_day = obj.getString("begin");
		String today = obj.getString("end");

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("uidx", udto.getUIdx());
		params.put("today", today);
		params.put("begin_day", begin_day);

		mystarbucksdao mdao = sqlsession.getMapper(mystarbucksdao.class);
		ArrayList<myrewarddto> mylist_ajax = mdao.reward_history(params);

		return mylist_ajax;
	}

	@RequestMapping(value = "my/reeward/oder_list_ajax", method = RequestMethod.POST)
	@ResponseBody
	public ArrayList<order_listdto> getOrder_info(HttpServletRequest req, Model model) {

		ArrayList<order_listdto> olist = new ArrayList<order_listdto>();

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("oNum", req.getParameter("oNum"));

		mystarbucksdao mdao = sqlsession.getMapper(mystarbucksdao.class);

		olist = mdao.get_order_info(params);

		return olist;

	}

	/*
	 * MYCART
	 * 
	 */

	@RequestMapping(value = "my/menu/mymenu", method = RequestMethod.GET)
	public String mymenu(HttpServletRequest req, Model model) {

		if (req.getSession().getAttribute("udto") == null) {

			String redirect_url = "my/menu/mymenu";

			return "redirect:/login/loginPage?redirect_url=" + redirect_url;

		} else {
			model.addAttribute("req", req);
			command = new mymenucommand();
			command.execute(sqlsession, model);

			return "mystarbucks/menu/mymenu";
		}
	}

	@RequestMapping(value = "my/menu/myMenu_ajax", method = RequestMethod.POST)
	@ResponseBody
	public ArrayList<mycartdto> getMenu_ajax(HttpServletRequest req, Model model) {

		mystarbucksdao mdao = sqlsession.getMapper(mystarbucksdao.class);
		usersdto udto = (usersdto) req.getSession().getAttribute("udto");
		String type = req.getParameter("type");

		Map<String, Object> param = new HashMap<String, Object>();
		param.put("uidx", udto.getUIdx());
		param.put("type", type);

		ArrayList<mycartdto> mclist = mdao.getmycart(param);

		return mclist;

	}

	@RequestMapping(value = "my/menu/mycard_list", method = RequestMethod.POST, produces = "text/json; charset=UTF-8")
	@ResponseBody
	public String getMyCard(HttpServletRequest req, Model model) {

		JSONArray jrr = new JSONArray();

		usersdto udto = (usersdto) req.getSession().getAttribute("udto");
		mystarbucksdao mdao = sqlsession.getMapper(mystarbucksdao.class);
		if (udto == null) {
			return "login_check";
		} else {
			ArrayList<user_card_listdto> ucllist = mdao.getCardList(udto.getUIdx());

			if (ucllist.size() == 0) {
				return "register_card";
			} else {
				for (int i = 0; i < ucllist.size(); i++) {
					org.json.simple.JSONObject obj = new org.json.simple.JSONObject();
					obj.put("uclidx", ucllist.get(i).getUclIdx());
					obj.put("uclname", ucllist.get(i).getUclName());
					obj.put("uclMoney", ucllist.get(i).getUclMoney());
					obj.put("climg", ucllist.get(i).getClImg());
					jrr.put(obj);
				}
			}

			return jrr.toString();
		}

	}

	@RequestMapping(value = "my/menu/branch_list", method = RequestMethod.POST)
	@ResponseBody
	public ArrayList<branch_infodto> branch_list(HttpServletRequest req, Model model) {

		String location = req.getParameter("item");

		ArrayList<branch_infodto> blist = new ArrayList<branch_infodto>();
		storedao sdao = sqlsession.getMapper(storedao.class);

		blist = sdao.getbranch_info(location);

		System.out.println(blist.size());

		return blist;
	}

	@RequestMapping(value = "menu/buyproduct", method = RequestMethod.POST,produces = "application/text; charset=UTF-8")
	@ResponseBody
	public String buyproduct(HttpServletRequest req, Model model) {

		usersdto udto = (usersdto) req.getSession().getAttribute("udto");

		if (udto == null) {
			return "로그인";
		}else {
			
			mystarbucksdao mdao = sqlsession.getMapper(mystarbucksdao.class);
			
			// 주문번호 생성
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String oDate = sdf.format(cal.getTime());

			String data = req.getParameter("data");
			JSONObject obj = new JSONObject(data);

			int uclIdx = Integer.parseInt(obj.getString("uclidx"));
			int bIdx = Integer.parseInt(obj.getString("bidx"));
			int pinNum =obj.getInt("pinNum");
			System.out.println(pinNum);
			
			Map<String, Object> params =new HashMap<String, Object>();
			params.put("pinNum", pinNum);
			params.put("uclIdx", uclIdx);
			
			if(mdao.card_pinNumcheck(params) >0) {
				JSONObject tot = obj.getJSONObject("tot");
				
				int totalPrice = Integer.parseInt(tot.getString("total").replaceAll("\\,", "")); // 카드 잔액 확인용
				
			
				if (totalPrice > mdao.getCardMoney(uclIdx)) {

					return "잔액부족";
				} else {
					Map<String,Object> cardMap =new HashMap<String, Object>();
					cardMap.put("uclIdx", uclIdx);
					cardMap.put("totalPrice", totalPrice);
					cardMap.put("uIdx", udto.getUIdx());
					mdao.update_cardMoney(cardMap);
					mdao.update_card_deposit(cardMap);
					String oNum="";
					JSONArray orderlist = obj.getJSONArray("orderlist");
					for (int i = 0; i < orderlist.length(); i++) {

						JSONObject order = orderlist.getJSONObject(i);  
						int oPrice = Integer.parseInt(order.getString("mctotal").replaceAll("\\,", ""));
						String oName = order.getString("mcname");
						int oCount = Integer.parseInt(order.getString("mccount"));
						int mcidx = Integer.parseInt(order.getString("mcidx"));

						totalPrice += oPrice;

						order_listdto odto = new order_listdto();
						odto.setBIdx(bIdx);
						odto.setOName(oName);
						odto.setOCount(oCount);
						odto.setOPrice(oPrice);
						odto.setUIdx(udto.getUIdx());
						odto.setODate(oDate);
						odto.setONum(oNum);
						
						

						if(i ==0) {
							int result =mdao.first_buy_insert(odto);
							oNum =odto.getONum();
						} else {
							int result =mdao.buy_insert(odto);
						}
						mdao.delete_cart(mcidx);

					}

				
					return "success";
				}
			} else {
				return "핀번호";
			}
			
			

			
		}
 
	}
	
	
	

}
