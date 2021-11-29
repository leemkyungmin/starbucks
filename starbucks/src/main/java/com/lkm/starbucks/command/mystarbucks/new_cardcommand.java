package com.lkm.starbucks.command.mystarbucks;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.lkm.starbucks.command.command;
import com.lkm.starbucks.dao.mystarbucksdao;
import com.lkm.starbucks.dto.card_listdto;

public class new_cardcommand implements command {

	@Override
	public void execute(SqlSession sqlsession, Model model) {
		
		mystarbucksdao mdao = sqlsession.getMapper(mystarbucksdao.class);
		ArrayList<card_listdto> clist = mdao.getcardlist();
		
		model.addAttribute("clist",clist);
	}

}
