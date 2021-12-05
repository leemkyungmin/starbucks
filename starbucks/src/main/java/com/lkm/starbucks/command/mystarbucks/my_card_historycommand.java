package com.lkm.starbucks.command.mystarbucks;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.json.JSONObject;
import org.springframework.ui.Model;

import com.lkm.starbucks.command.command;
import com.lkm.starbucks.commom.PageMaker;
import com.lkm.starbucks.dao.mystarbucksdao;
import com.lkm.starbucks.dto.user_card_depositdto;

public class my_card_historycommand implements command {

	@Override
	public void execute(SqlSession sqlsession, Model model) {

		Map<String,Object> map =model.asMap();
		HttpServletRequest req = (HttpServletRequest) map.get("req");
		
		String data = req.getParameter("data");
		JSONObject obj =new JSONObject(data);
		
		int uclidx = obj.getInt("uclidx");
		int page = obj.getInt("page");
		
		int pageCount =10;  //한페이지에 보여줄 게시물 갯수 
		int beginRecord = (page - 1) * pageCount + 1;
		int endRecord = pageCount * page;
		
		Map<String,Object> param = new HashMap<String, Object>();
		param.put("beginRecord",beginRecord);
		param.put("endRecord", endRecord);
		param.put("uclidx", uclidx);
		
		int totalPage =0;
		
		mystarbucksdao mdao = sqlsession.getMapper(mystarbucksdao.class);
		
		totalPage = mdao.deposit_totalcount(param);
		
		ArrayList<user_card_depositdto> ucdlist = mdao.getDepositList(param);
		
		model.addAttribute("ucdlist", ucdlist);
		
		String pager =PageMaker.getPageView(uclidx,page, pageCount, totalPage);
		
		model.addAttribute("pager",pager);
	}

}
