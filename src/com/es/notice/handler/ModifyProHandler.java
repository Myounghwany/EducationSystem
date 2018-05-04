package com.es.notice.handler;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.es.notice.NoticeDao;
import com.es.notice.NoticeDataBean;

@Controller
public class ModifyProHandler implements CommandHandler {

	@Resource
	private NoticeDao noticeDao;
	
	@RequestMapping("/modifyPro")
	@Override
	public ModelAndView process(HttpServletRequest request, HttpServletResponse response, NoticeDataBean noticeDto) throws Throwable {
		
		request.setCharacterEncoding("utf-8");
		
		int result = noticeDao.updateNotice(noticeDto);
		
		request.setAttribute("result", result);
		
		return new ModelAndView("notice/modifyPro");
	}

}
