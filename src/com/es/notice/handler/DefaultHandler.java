package com.es.notice.handler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.es.notice.NoticeDataBean;

@Controller
public class DefaultHandler implements CommandHandler {
	
	@RequestMapping("*")
	@Override
	public ModelAndView process(HttpServletRequest request, HttpServletResponse response, NoticeDataBean noticeDto) throws Throwable {
		
		request.setAttribute("result", "점검");
		
		return new ModelAndView("notice/default");
	}

}
