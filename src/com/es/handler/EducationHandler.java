package com.es.handler;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.es.education.EduListDao;
import com.es.education.EduListDto;

@Controller
public class EducationHandler {
	/* 나현 - 수강목록  */
	@Resource
	private EduListDao edulistDao;
	
	@RequestMapping("/eduhistory")
	public String eduHistory(Model model) {
		List<EduListDto> edu_list = edulistDao.eduList();
		model.addAttribute("edu_list", edu_list);
		
		return "edu_history/main";
	}
	/* 나현 - 수강목록 끝 */
	
	/* 나현 - 수강목록 中 한 강의 선택 */
	@RequestMapping("/eduhistory/detail")
	public String eduHistoryDetail(Model model, @RequestParam("edu_no") int no){
		//select box로 보여줄 직원의 수강목록
		List<EduListDto> edu_list = edulistDao.eduList();
		model.addAttribute("edu_list", edu_list);
		
		//해당 edu_no에 관한 커리큘럼 등 상세정보
		EduListDto edu_detail = edulistDao.eduDetail(no);
		model.addAttribute("edu_detail", edu_detail);

		return "edu_history/detail";
	}
	
	/* 나현 - 강의평가 페이지*/
	@RequestMapping("/eduhistory/emp_eval")
	public String empEval(Model model, @RequestParam("edu_no") int no) {
		EduListDto edu_detail = edulistDao.eduDetail(no);
		model.addAttribute("edu_detail", edu_detail);
		
		return "edu_history/emp_eval";
	}
	
	/* 나현 - 강의평가 제출 */
	@RequestMapping(value="/eduhistory/write_emp_eval", method=RequestMethod.POST)
	public @ResponseBody String WriteEmpEval(Model model, @RequestParam("edu_no") int no, 
								@RequestParam("emp_eval") String emp_eval,
								HttpServletResponse response) throws Exception {
		System.out.println(no);
		System.out.println("emp_eval : " + emp_eval);
		
		// 비지니스 로직

		
		
		String command = "<script>";
		command += "window.close();";
		command += "window.opener.location.reload();";
		command += "</script>";
		
		return command;
	}
}
