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
public class DeleteProHandler implements CommandHandler {

	@Resource
	private NoticeDao noticeDao;
	
	@RequestMapping("/deletePro")
	@Override
	public ModelAndView process(HttpServletRequest request, HttpServletResponse response, NoticeDataBean noticeDto)
			throws Throwable {
		
		System.out.println(noticeDto.getNotice_no());
		
		int result = noticeDao.deleteNotice(noticeDto);
		System.out.println(result);
		return new ModelAndView("notice/deletePro", "result", result);
	}

}
