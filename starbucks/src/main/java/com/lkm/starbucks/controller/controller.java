package com.lkm.starbucks.controller;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Controller
public class controller {

	@RequestMapping(value="/",method=RequestMethod.GET)
	public String getIndex() {
		return "index";
	}
	
	@RequestMapping(value="404", method=RequestMethod.GET)
	public String error404(HttpServletResponse res) {
		res.setStatus(HttpServletResponse.SC_OK);
		return "commom/404";
	}
	
}
