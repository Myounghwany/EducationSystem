package com.es.handler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class DefaultHandler {
	
	@RequestMapping("*")
	public ModelAndView process(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		request.setAttribute( "result", "~" );
		return new ModelAndView("default");
	}
	
	@RequestMapping("main")
	public ModelAndView moveMain(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		System.out.println("main");
		return new ModelAndView("index");
	}

}
