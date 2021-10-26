package com.lkm.starbucks.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;import org.springframework.web.servlet.mvc.ParameterizableViewController;

import com.lkm.starbucks.command.command;
import com.lkm.starbucks.dao.logindao;
import com.lkm.starbucks.dto.usersdto;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;



@Controller
public class logincontroller {

	@Autowired
	private SqlSession sqlsession;
	private command command;
	
	@RequestMapping("login/loginPage")
	public String goLogin(HttpServletRequest req,Model model) {
		
		return "login/login";
	}
	
	//ajax 로그인 처리
	@RequestMapping( value= "login/logincheck",method= RequestMethod.POST)
	@ResponseBody
	public String loginChk(HttpServletRequest req) {
		String id =req.getParameter("id");
		String pw =req.getParameter("pw");
		
		logindao idao = sqlsession.getMapper(logindao.class);
		usersdto udto = new usersdto();
		
		udto =idao.logincheck(id,pw);
		if(udto !=null) {
			req.getSession().setAttribute("login", "login");
			req.getSession().setAttribute("uIdx", udto.getUIdx());
			req.getSession().setAttribute("uNickname",udto.getUNickName());
			req.getSession().setAttribute("uPower",udto.getUPower());
			req.getSession().setAttribute("uIds",udto.getUIds());
			System.out.println(req.getSession().getAttribute("login"));
			return udto.getUNickName();
		} else {
			return "fail";
		}
	}
	
	@RequestMapping(value="login/logout" ,method =RequestMethod.GET)
	@ResponseBody
	public String logout(HttpServletRequest req) {
		
		req.getSession().invalidate();
		
		return "success";
	}
	
	/*restful  
	 * 회원 가입 페이지 -get
	 * 회원 처리 페이지 -post
	 */
	@RequestMapping( value="login/register",method=RequestMethod.GET)
	public String registerForm() {
		
		return "login/register"; 
	} 
	@RequestMapping(value="login/sendsms",method=RequestMethod.POST)
	@ResponseBody
	public String sendMessage(HttpServletRequest req) throws IOException {
			
			  
		
			Random ra = new Random(System.currentTimeMillis());
			String phone_num = req.getParameter("phone");
			String auth_num = Integer.toString(ra.nextInt(888888)+11111);
		 	String api_key = "NCSULYJJSNVFZGXU";
		    String api_secret = "QCKXEVBDXYNAY3UWJQARN3J6BWX5HJYP";
		    Message coolsms = new Message(api_key, api_secret);

		   /* HashMap<String, String> params = new HashMap<String, String>();
		    params.put("to", phone_num);	// 수신전화번호
		    params.put("from", "01029949529");	// 발신전화번호. 테스트시에는 발신,수신 둘다 본인 번호로 하면 됨
		    params.put("type", "SMS");
		    params.put("text", "인증번호 ["+auth_num+"]입니다.");
		    params.put("app_version", "test app 1.2"); // application name and version

		    try {
		      JSONObject obj = (JSONObject) coolsms.send(params);
		      System.out.println(obj.toString());
		    } catch (CoolsmsException e) {
		      System.out.println(e.getMessage());
		      System.out.println(e.getCode());
		    }*/
		    
		    req.getSession().setAttribute(phone_num,auth_num);
		    System.out.println(req.getSession().getAttribute(phone_num));
		
		return "";
	}
	
	@RequestMapping(value="login/auth_check",method = RequestMethod.POST)
	@ResponseBody
	public String auth_check(HttpServletRequest req) {
		
		String auth = req.getParameter("auth");
		String phone = req.getParameter("phone");
		
		String sessionauth = (String) req.getSession().getAttribute(phone);
		
		if(sessionauth.equals(auth)) {
			return "success";
		} else {
			return "fail";
		}
		
	}
	
	
}
