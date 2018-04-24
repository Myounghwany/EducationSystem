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

import com.es.education.EduHistoryDao;
import com.es.education.EduHistoryDto;

@Controller
public class EducationHandler {
	/* 나현 - 수강목록  */
	@Resource
	private EduHistoryDao edulistDao;
	
	@RequestMapping("/eduhistory")
	public String eduHistory(Model model) {
		List<EduHistoryDto> edu_list = edulistDao.eduHistoryList();
		model.addAttribute("edu_list", edu_list);
		
		return "edu_history/main";
	}
	/* 나현 - 수강목록 끝 */
	
	/* 나현 - 수강목록 中 한 강의 선택 */
	@RequestMapping("/eduhistory/detail")
	public String eduHistoryDetail(Model model, @RequestParam("edu_no") int no){
		//select box로 보여줄 직원의 수강목록
		List<EduHistoryDto> edu_list = edulistDao.eduHistoryList();
		model.addAttribute("edu_list", edu_list);
		
		//해당 edu_no에 관한 커리큘럼 등 상세정보
		EduHistoryDto edu_detail = edulistDao.eduHistoryDetail(no);
		model.addAttribute("edu_detail", edu_detail);

		return "edu_history/detail";
	}
	
	/* 나현 - 강의평가 페이지*/
	@RequestMapping("/eduhistory/emp_eval")
	public String empEval(Model model, @RequestParam("edu_no") int no) {
		EduHistoryDto edu_detail = edulistDao.eduHistoryDetail(no);
		model.addAttribute("edu_detail", edu_detail);
		
		return "edu_history/emp_eval";
	}
	
	/* 나현 - 강의평가 제출 */
	@RequestMapping(value="/eduhistory/write_emp_eval", method=RequestMethod.POST)
	public @ResponseBody String WriteEmpEval(Model model, @RequestParam("edu_no") int no, 
								@RequestParam("emp_eval") String emp_eval,
								HttpServletResponse response) throws Exception {
		System.out.println("교육번호:" +no + ", 강의평가란 : " + emp_eval);
		
		// 비지니스 로직
		int result = edulistDao.insertEmpEval(no, emp_eval);
		System.out.println("result:" + result);
		
		String command = "<script>";
		command += "window.close();";
		command += "window.opener.location.reload();";
		command += "</script>";
		
		return command;
	}
}
