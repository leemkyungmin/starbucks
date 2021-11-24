package com.lkm.starbucks.command.notice;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.lkm.starbucks.command.command;
import com.lkm.starbucks.commom.PageMaker;
import com.lkm.starbucks.dao.noticedao;
import com.lkm.starbucks.dto.noticedto;

public class noticecommand implements command {

	@Override
	public void execute(SqlSession sqlsession, Model model) {
		
		Map<String,Object> map = model.asMap();
		HttpServletRequest req = (HttpServletRequest) map.get("req");
		
		int page = (req.getParameter("page") ==null ? 1 : Integer.parseInt(req.getParameter("page"))  );
		
		int pageCount =5;  //한페이지에 보여줄 게시물 갯수 
		int beginRecord = (page - 1) * pageCount + 1;
		int endRecord = pageCount * page;
		
		int totalPage =0;
		
		Map<String,Object> pages = new HashMap<String, Object>();
		pages.put("beginRecord",beginRecord);
		pages.put("endRecord", endRecord);
		
		noticedao ndao = sqlsession.getMapper(noticedao.class);
		
		ArrayList<noticedto> nlist = ndao.notice_list(pages);
		totalPage = ndao.noticeCount();
		
		String path = "noticeList";
		
		String pagemaker = PageMaker.getPageView2(path, page, pageCount, totalPage);
		
		model.addAttribute("pagemaker", pagemaker);
		model.addAttribute("nlist", nlist); 
		
		
		
	}

}
