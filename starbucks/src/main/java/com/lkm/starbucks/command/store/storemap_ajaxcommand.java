package com.lkm.starbucks.command.store;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.lkm.starbucks.command.command;
import com.lkm.starbucks.dao.storedao;
import com.lkm.starbucks.dto.branch_infodto;

public class storemap_ajaxcommand implements command {

	@Override
	public void execute(SqlSession sqlsession, Model model) {
		
		Map<String,Object> map =model.asMap();
		HttpServletRequest req = (HttpServletRequest) map.get("req");
		
		String location = req.getParameter("location");
		
		storedao sdao = sqlsession.getMapper(storedao.class);
		
		ArrayList<branch_infodto> bilist = sdao.getbranch_info(location);
		System.out.println(bilist.size());
		model.addAttribute("bilist",bilist);
		

	}

}
