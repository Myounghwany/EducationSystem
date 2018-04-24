package com.es.handler;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.es.education.EduListDao;
import com.es.education.EduListDto;
import com.es.education.EducationListDto;

@Controller
public class EducationHandler {
	/* 수강목록  */
	@Resource
	private EduListDao edulistDao;
	
	@RequestMapping("/edulist")
	public String edulist(Model model) {
		List<EduListDto> edu_list = edulistDao.eduList();
		model.addAttribute("edu_list", edu_list);
		
		return "edu_history/main";
	}
	/* 수강목록 끝 */
	
	
	/* 수강목록 中 한 강의 선택 */
	@RequestMapping("/edulist/detail")
	public String edulistDetail(Model model, @RequestParam("edu_no") int no){
		//select box로 보여줄 직원의 수강목록
		List<EduListDto> edu_list = edulistDao.eduList();
		model.addAttribute("edu_list", edu_list);
		
		//해당 edu_no에 관한 커리큘럼 등 상세정보
		EduListDto edu_detail = edulistDao.eduDetail(no);
		model.addAttribute("edu_detail", edu_detail);

		return "edu_history/detail";
	}
	
	/*주현- 교육목록*/
	@RequestMapping("/EducationList")
	public ModelAndView eduList(HttpServletRequest request, HttpServletResponse response) {
		List<EducationListDto> edu_list = edulistDao.EducationList();
		System.out.println(edu_list);
		request.setAttribute("list", edu_list);
		return new ModelAndView("edu_list/list");
	}

	/*주현- 교육목록*/
	@RequestMapping("/EducationList/detail")
	public ModelAndView EducationDetail(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("handler educationDetail ");
		int edu_no = Integer.parseInt(request.getParameter("edu_no"));
		System.out.println(edu_no);
		
		EducationListDto edu_detail = edulistDao.EducationListDetail(edu_no);
		System.out.println(edu_detail);
		request.setAttribute("detail", edu_detail);
		return new ModelAndView("edu_list/detail");
	}
	
	
}
