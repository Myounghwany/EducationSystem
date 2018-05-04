package com.es.notice.handler;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.es.notice.NoticeDao;
import com.es.notice.NoticeDataBean;

@Controller
public class MainHandler implements CommandHandler {

	@Resource
	private NoticeDao noticeDao;
	
	@RequestMapping("/main")
	@Override
	public ModelAndView process(HttpServletRequest request, HttpServletResponse response, NoticeDataBean noticeDto) throws Throwable {
				
		List<NoticeDataBean> list = noticeDao.sellectAll(noticeDto);
		
		request.setAttribute("list", list);
		
		return new ModelAndView("notice/main");
	}

}
