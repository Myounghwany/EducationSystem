package com.es.handler;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.es.education.EduListDao;
import com.es.education.EduListDto;
import com.es.education.EducationListDto;

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
	
	/*주현- 교육목록*/
	@RequestMapping("/EducationList")
	public ModelAndView eduList(HttpServletRequest request, HttpServletResponse response) {
		List<EducationListDto> edu_list = edulistDao.EducationList();
		System.out.println(edu_list);
		request.setAttribute("list", edu_list);
		return new ModelAndView("edu_list/list");
	}

	/*주현- 교육목록 디테일*/
	@RequestMapping("/EducationList/detail")
	public ModelAndView EducationDetail(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("handler educationDetail ");
		int edu_no = Integer.parseInt(request.getParameter("edu_no"));
		System.out.println(edu_no);
		
		EducationListDto edu_detail = edulistDao.EducationListDetail(edu_no);
		int applicants = edulistDao.EducationApplicants(edu_no);
		
		request.setAttribute("applicants", applicants);
		request.setAttribute("detail", edu_detail);
		return new ModelAndView("edu_list/detail");
	}

	/*주현- 교육목록 디테일 Modal*/
	@RequestMapping(value="detailM", method=RequestMethod.GET, produces="application/json")
	@ResponseBody
	public Map<String, Object> EducationDetailM(@RequestParam("edu_no") int no) {
		System.out.println("handler educationDetailM ");
		int edu_no = no;

		Map<String, Object> resultMap = new HashMap<String, Object>();
		EducationListDto edu_detail = edulistDao.EducationListDetail(edu_no);
		
		resultMap.put("belong_name", edu_detail.getBelong_name());
		resultMap.put("edu_field", edu_detail.getEdu_field());
		resultMap.put("edu_name", edu_detail.getEdu_name());
		resultMap.put("edu_schedule", edu_detail.getEdu_schedule());
		resultMap.put("instructor_name", edu_detail.getInstructor_name());
		
		return resultMap;
	}
	
	
	/*주현- 교육신청*/
	@RequestMapping("/EducationList/application")
	@ResponseBody
	public int application(HttpServletRequest request, HttpServletResponse response) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		System.out.println("handler application ");
		int edu_no = Integer.parseInt(request.getParameter("edu_no"));

		EducationListDto edu_detail = edulistDao.EducationListDetail(edu_no);
		HttpSession httpSession = request.getSession();
		/*String writer = (String) httpSession.getAttribute("userId");*/
		
		String emp_no = "E2018040001";
		String instructor_no = edu_detail.getInstructor_no();

		System.out.println("emp_no : "+emp_no+" instructor_no : "+instructor_no+" edu_no : "+edu_no);
		
		map.put("edu_no", edu_no);
		map.put("emp_no", emp_no);
		map.put("instructor_no", instructor_no);
		
		int application = edulistDao.EducationApplication(map);
		
		
		return application;
		
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
