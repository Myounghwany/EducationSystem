package com.es.handler;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.es.education.EduHistoryDao;
import com.es.education.EduHistoryDto;
import com.es.main.MainDao;
import com.es.main.MainDto;

@Controller
public class MainHanler {

	@Resource
	private MainDao maindao;
	
	@Resource
	private EduHistoryDao eduhistoryDao;

		@RequestMapping("main")
		public ModelAndView noitce(HttpServletRequest request, HttpServletResponse response, MainDto maindto, Model model, HttpSession session) throws Throwable {
			
			String emp_no = (String) session.getAttribute("no");
			if (emp_no != null) {
				List<EduHistoryDto> eduhistory_list = maindao.eduHistoryList(emp_no);
				for(EduHistoryDto dto : eduhistory_list) {
					Date tempDate = dto.getEnd_date();
					Calendar cal = Calendar.getInstance();
					cal.setTime(tempDate);
					cal.add(Calendar.DATE, 15);
					Date curDate = new Date();
					Calendar c = Calendar.getInstance();
					c.setTime(curDate);
					if( c.getTime().before(cal.getTime()) ) {
						dto.setButtonFlag(1); 
					} else {
						dto.setButtonFlag(0);
					}
				}
				Date date = new Date();
				model.addAttribute("date", date);
				model.addAttribute("eduhistory_list", eduhistory_list);
		}
			List<MainDto> noticelist = maindao.noticeFive(maindto);		
			List<MainDto> instructorFive = maindao.instructorFive(maindto);
			List<MainDto> eduFive = maindao.eduFive(maindto);
			
			request.setAttribute("noticelist", noticelist);
			request.setAttribute("instructorFive", instructorFive);
			request.setAttribute("eduFive", eduFive);
			
			return new ModelAndView("index");
		}
}

