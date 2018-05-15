package com.es.handler;

import java.sql.Timestamp;
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
public class NoticeHandler {

	@Resource
	private NoticeDao noticedao;
		
	@RequestMapping("/notice")
	public ModelAndView noitce(HttpServletRequest request, HttpServletResponse response, NoticeDataBean noticedto) throws Throwable {
				
		List<NoticeDataBean> list = noticedao.sellectAll(noticedto);
		
		request.setAttribute("list", list);
		
		return new ModelAndView("notice/main");
	}

	@RequestMapping("/writePro")
	public ModelAndView writepro(HttpServletRequest request, HttpServletResponse response, NoticeDataBean noticedto) throws Throwable {

		request.setCharacterEncoding("utf-8");
	
		noticedto.setWriter("test");
		
		noticedto.setWrite_time( new Timestamp( System.currentTimeMillis() ) );
		
		int result = noticedao.insertNotice(noticedto);
		
		request.setAttribute("result", result);
		
		return new ModelAndView("notice/writePro");
	}
	
	@RequestMapping("/writeForm")

	public ModelAndView writeform(HttpServletRequest request, HttpServletResponse response, NoticeDataBean noticedto) throws Throwable {

		return new ModelAndView("notice/writeForm");
	}
	
	@RequestMapping("/search")
	public ModelAndView search(HttpServletRequest request, HttpServletResponse response, NoticeDataBean noticedto) throws Throwable {
		System.out.println("검색 실행");
		
		String searchName = request.getParameter("searchName");
		String searchValue= request.getParameter("searchValue");
		
		List<NoticeDataBean> list = noticedao.search(noticedto);
		
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("notice/main");
		mav.addObject("list", list);
		return mav;
	}
	
	@RequestMapping("/modifyPro")
	public ModelAndView modifypro(HttpServletRequest request, HttpServletResponse response, NoticeDataBean noticedto) throws Throwable {
		
		request.setCharacterEncoding("utf-8");
		
		int result = noticedao.updateNotice(noticedto);
		
		request.setAttribute("result", result);
		
		return new ModelAndView("notice/modifyPro");
	}	
	
	@RequestMapping("/modifyForm")
	public ModelAndView modifyform(HttpServletRequest request, HttpServletResponse response, NoticeDataBean noticedto) throws Throwable {
		
		String noitce_no = request.getParameter("noitce_no");
		
		int result = noticedao.check(noitce_no);
		
		request.setAttribute("result", result);
		
		if(result == 1) {
			noticedto = noticedao.selectOne(noitce_no);
			request.setAttribute("boardDto", noticedto);
		}
		
		return new ModelAndView("notice/modifyForm");
	}
	
	@RequestMapping("/detailView")
	
	public ModelAndView detailview(HttpServletRequest request, HttpServletResponse response, NoticeDataBean noticedto) throws Throwable {

		String noitce_no =(String)request.getParameter("noitce_no");
		
		int result = noticedao.check(noitce_no);
		
		request.setAttribute("result", result);
		
		if(result == 1) {
			noticedto = noticedao.selectOne(noitce_no);
			request.setAttribute("boardDto", noticedto);
		}
		
		return new ModelAndView("notice/detailView");
	}
	
	@RequestMapping("/deletePro")
	
	public ModelAndView deletepro(HttpServletRequest request, HttpServletResponse response, NoticeDataBean noticedto)
			throws Throwable {
		
		System.out.println(noticedto.getNotice_no());
		
		int result = noticedao.deleteNotice(noticedto);
		System.out.println(result);
		return new ModelAndView("notice/deletePro", "result", result);
	}
	
	@RequestMapping("/deleteForm")
	
	public ModelAndView deleteform(HttpServletRequest request, HttpServletResponse response, NoticeDataBean noticedto)
			throws Throwable {

		return new ModelAndView( "notice/deleteForm");
	}
	
}
