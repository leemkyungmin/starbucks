package com.lkm.starbucks.command.mystarbucks;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.lkm.starbucks.command.command;
import com.lkm.starbucks.dao.mystarbucksdao;
import com.lkm.starbucks.dto.card_listdto;
import com.lkm.starbucks.dto.user_card_listdto;
import com.lkm.starbucks.dto.usersdto;

public class mystarbucks_indexcommand implements command {

	@Override
	public void execute(SqlSession sqlsession, Model model) {

		Map<String, Object> map = model.asMap();
		HttpServletRequest req = (HttpServletRequest) map.get("req");
		
		//세션에서 udto 가져오기
		usersdto udto = (usersdto) req.getSession().getAttribute("udto");
		int uidx = udto.getUIdx();
		
		mystarbucksdao mydao =sqlsession.getMapper(mystarbucksdao.class);
		
		
		ArrayList<user_card_listdto> user_cardlist = mydao.getCardList(uidx);
		
		if(user_cardlist.size() >0) { 
			int clidx = user_cardlist.get(0).getClIdx();
			
			card_listdto cldto  = mydao.getCardinfo(clidx);
			System.out.println(cldto);
			model.addAttribute("cldto", cldto);
		}
		
		model.addAttribute("cardlist", user_cardlist);
		model.addAttribute("udto",udto);
		model.addAttribute("cardcount",user_cardlist.size());
		// 회원 등급 / 등록 카드정보 / 별 갯수
		// 구매내역
		// 상담내역
		// 나만의 커피 / 나만의 음료 / 나만의 푸드
	}

}
