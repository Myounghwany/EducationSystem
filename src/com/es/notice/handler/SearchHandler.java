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
public class SearchHandler implements CommandHandler{

	@Resource
	private NoticeDao noticeDao;
	@RequestMapping("/search")
	@Override
	public ModelAndView process(HttpServletRequest request, HttpServletResponse response, NoticeDataBean noticeDto) throws Throwable {
		System.out.println("검색 실행");
		
		String searchName = request.getParameter("searchName");
		String searchValue= request.getParameter("searchValue");
		
		List<NoticeDataBean> list = noticeDao.search(noticeDto);
		
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("notice/main");
		mav.addObject("list", list);
		return mav;
	}
}
