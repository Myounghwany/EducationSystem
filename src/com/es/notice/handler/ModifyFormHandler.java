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
public class ModifyFormHandler implements CommandHandler {

	@Resource
	private NoticeDao noticeDao;
	
	@RequestMapping("/modifyForm")
	@Override
	public ModelAndView process(HttpServletRequest request, HttpServletResponse response, NoticeDataBean noticeDto) throws Throwable {
		
		String no = request.getParameter("no");
		
		int result = noticeDao.check(no);
		
		request.setAttribute("result", result);
		
		if(result == 1) {
			noticeDto = noticeDao.selectOne(no);
			request.setAttribute("noticeDto", noticeDto);
		}
		
		return new ModelAndView("notice/modifyForm");
	}

}
