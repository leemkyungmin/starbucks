package com.lkm.starbucks.command.login;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.springframework.ui.Model;

import com.lkm.starbucks.command.command;
import com.lkm.starbucks.dao.logindao;
import com.lkm.starbucks.dto.usersdto;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

public class findidcommand implements command {

	@Override
	public void execute(SqlSession sqlsession, Model model) {
		
		Map< String,Object> map =model.asMap();
		String uphone =(String) map.get("uphone");
		
		logindao ldao = sqlsession.getMapper(logindao.class);
		usersdto udto =ldao.find_id(uphone);
		
		if(udto != null) {
		 	String api_key = "NCSULYJJSNVFZGXU";
		    String api_secret = "QCKXEVBDXYNAY3UWJQARN3J6BWX5HJYP";
		    Message coolsms = new Message(api_key, api_secret);

		    HashMap<String, String> params = new HashMap<String, String>();
		    params.put("to", uphone);	
		    params.put("from", "01029949529");	
		    params.put("type", "SMS");
		    params.put("text", "회원님 아이디는 [ "+ udto.getUIds() +" ]입니다.");
		    params.put("app_version", "test app 1.2"); 

		    try {
		      JSONObject obj = (JSONObject) coolsms.send(params);
		      System.out.println(obj.toString());
		    } catch (CoolsmsException e) {
		      System.out.println(e.getMessage());
		      System.out.println(e.getCode());
		    }
		    System.out.println(udto.getUIds());
		    model.addAttribute("result", true);
		   
		} else { 
			 model.addAttribute("result", false);
		}
		
	}

}
