package com.lkm.starbucks.command.login;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.json.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.ui.Model;

import com.lkm.starbucks.command.command;
import com.lkm.starbucks.dao.logindao;
import com.lkm.starbucks.dto.usersdto;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

public class findpwcommand implements command {

	@Override
	public void execute(SqlSession sqlsession, Model model) {
		
		Map<String,Object> map =model.asMap();
		HttpServletRequest req = (HttpServletRequest) map.get("req");
		
		String list  =req.getParameter("list");
		JSONArray arr = new JSONArray(list);
		
		org.json.JSONObject obj = (org.json.JSONObject) arr.get(0);
		
		String uPhone =(String) obj.get("uPhone");
		String uIds = (String) obj.get("uIds");
		
		usersdto udto = new usersdto();
		udto.setUIds(uIds);
		udto.setUPhone(uPhone);
		
		logindao ldao = sqlsession.getMapper(logindao.class);
		
		udto =ldao.find_pw(udto);
		
		if(udto !=null) {
			String api_key = "NCSULYJJSNVFZGXU";
		    String api_secret = "QCKXEVBDXYNAY3UWJQARN3J6BWX5HJYP";
		    Message coolsms = new Message(api_key, api_secret);

		    HashMap<String, String> params = new HashMap<String, String>();
		    params.put("to", uPhone);	
		    params.put("from", "01029949529");	
		    params.put("type", "SMS");
		    params.put("text", udto.getUIds() +"회원님 비밀번호는 ["+udto.getUPw() +"]입니다.");
		    params.put("app_version", "test app 1.2"); 

		    try {
		      JSONObject objs = (JSONObject) coolsms.send(params);
		      System.out.println(objs.toString());
		    } catch (CoolsmsException e) {
		      System.out.println(e.getMessage());
		      System.out.println(e.getCode());
		    }		    
		}
		
		model.addAttribute("udto", udto);
		
	}

}
