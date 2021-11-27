package com.lkm.starbucks.command.mystarbucks;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.lkm.starbucks.command.command;
import com.lkm.starbucks.dao.mystarbucksdao;
import com.lkm.starbucks.dto.myrewarddto;
import com.lkm.starbucks.dto.usersdto;

public class my_reward_historycommand implements command {

	@Override
	public void execute(SqlSession sqlsession, Model model) {
		
		Map<String,Object> map = model.asMap();
		HttpServletRequest req  =(HttpServletRequest) map.get("req");
		SimpleDateFormat sdf = new SimpleDateFormat("yyy-MM-dd");
		usersdto udto = (usersdto) req.getSession().getAttribute("udto");
		
		// 현재 날짜 구하기 
		Calendar cal = Calendar.getInstance();
		String today = sdf.format(cal.getTime());
		model.addAttribute("today",today);
		cal.add(Calendar.DATE, 1);
		//오늘 날짜
		today = sdf.format(cal.getTime());
		
		// 한달전 날짜(오늘 기준) 
		cal.add(Calendar.MONTH,-1);
		cal.add(Calendar.DATE, -1);
		String begin_day = sdf.format(cal.getTime());
		model.addAttribute("begin_day", begin_day);
		cal.add(Calendar.DATE, -3);
		begin_day = sdf.format(cal.getTime());
		
		
		//Map 형식으로 통신
		Map<String,Object> params = new HashMap<String, Object>();
		params.put("uidx",udto.getUIdx());
		params.put("today",today);
		params.put("begin_day",begin_day);
		
		mystarbucksdao mdao = sqlsession.getMapper(mystarbucksdao.class);
		
		ArrayList<myrewarddto> rlist = mdao.reward_history(params);
		
		//리워드 내역
		model.addAttribute("rlist",rlist);
		model.addAttribute("month_reward", mdao.month_reward(params));
		model.addAttribute("total_reward", mdao.total_reward(params));
		model.addAttribute("use_reward", mdao.use_reward(params));
		model.addAttribute("udto", udto);
		
		
		
		
	}

}
