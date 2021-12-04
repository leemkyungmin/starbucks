package com.lkm.starbucks.command.mystarbucks;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.lkm.starbucks.command.command;
import com.lkm.starbucks.dao.mystarbucksdao;
import com.lkm.starbucks.dto.user_card_listdto;

public class my_card_deposit_resultcommand implements command {

	@Override
	public void execute(SqlSession sqlsession, Model model) {
		
		Map<String,Object> map =model.asMap();
		HttpServletRequest req = (HttpServletRequest) map.get("req");
		
		String uclidx = req.getParameter("uclidx");
		String amount =req.getParameter("amount");
		
		mystarbucksdao mdao = sqlsession.getMapper(mystarbucksdao.class);
		
		user_card_listdto ucldto =mdao.user_card_info(uclidx);
		
		model.addAttribute("ucldto", ucldto);
		
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd");
		
		model.addAttribute("success_date", sdf.format(cal.getTime()));
		model.addAttribute("amount", amount);

	}

}
