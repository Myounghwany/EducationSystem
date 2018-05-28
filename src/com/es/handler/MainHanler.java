package com.es.handler;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.es.main.MainDao;
import com.es.main.MainDto;
import com.es.notice.NoticeDataBean;

@Controller
public class MainHanler {

	@Resource
	private MainDao maindao;

		@RequestMapping("main")
		public ModelAndView noitce(HttpServletRequest request, HttpServletResponse response, MainDto maindto) throws Throwable {
					
			List<MainDto> noticelist = maindao.noticeFive(maindto);
			List<MainDto> historyFive = maindao.historyFive(maindto);
			List<MainDto> instructorFive = maindao.instructorFive(maindto);
			List<MainDto> petitionFive = maindao.petitionFive(maindto);
			
			request.setAttribute("noticelist", noticelist);
			request.setAttribute("historyFive", historyFive);
			request.setAttribute("instructorFive", instructorFive);
			request.setAttribute("petitionFive", petitionFive);
			
			return new ModelAndView("index");
		}

}
