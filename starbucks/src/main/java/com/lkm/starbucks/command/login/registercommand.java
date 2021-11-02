package com.lkm.starbucks.command.login;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.lkm.starbucks.command.command;
import com.lkm.starbucks.dao.registerdao;
import com.lkm.starbucks.dto.usersdto;

public class registercommand implements command {

	@Override
	public void execute(SqlSession sqlsession, Model model) {
		
		Map<String,Object> map =new HashMap<String, Object>();
		map = model.asMap();
		
		HttpServletRequest req = (HttpServletRequest) map.get("req");
		usersdto udto =new usersdto();
		
		udto.setUIds(req.getParameter("user_id"));
		udto.setUPw(req.getParameter("user_pw"));
		udto.setUNickName(req.getParameter("user_nickname"));
		udto.setUEmail(req.getParameter("user_email") +"@" +req.getParameter("email_addr"));
		udto.setUPhone(req.getParameter("user_phone"));
		
		registerdao rdao = sqlsession.getMapper(registerdao.class);
		
		int result =rdao.insertuser(udto);
		
		model.addAttribute("result",result);
		model.addAttribute("udto", udto);
		
		
	}

	
	
}
