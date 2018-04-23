package com.es.handler;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.es.education.EduListDao;
import com.es.education.EduListDto;

@Controller
public class EducationHandler {
	/* 수강목록  */
	@Resource
	private EduListDao edulistDao;
	
	@RequestMapping("/edulist")
	public String edulist(Model model) {
		List<EduListDto> edu_list = edulistDao.eduList();
		model.addAttribute("edu_list", edu_list);
		
		return "edu_list/main";
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

		return "edu_list/detail";
	}
	
}
