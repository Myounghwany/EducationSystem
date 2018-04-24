package com.es.handler;

import java.util.List;
import java.util.Locale;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.es.instructor.InstructorDao;
import com.es.instructor.InstructorDataBean;

@Controller
@RequestMapping("/instructor")
public class InstructorHandler {

	@Resource
	private InstructorDao instructorDao;
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String home(Locale locale, Model model) throws Exception {
		System.out.println("instructor/main");
		String id = "test1234";
		String account_no = instructorDao.selectAccountNo(id);
		System.out.println("account_no : " + account_no);
		System.out.println(account_no.substring(0, 1));
		
		//직원일 경우
		if(account_no.substring(0, 1).equals("E")) {
			System.out.println("직원계정");
			String instructor_check = instructorDao.selectInstructorCheck(account_no);
			System.out.println("instructor_check : " + instructor_check);
			//강사신청 안함
			if(instructor_check.equals("0")) {
				System.out.println( "instructor_no X ");
				model.addAttribute("result", "강사만 이용가능한 페이지 입니다.");
				model.addAttribute("instructor_no", "null");
				model.addAttribute("account_no", account_no);
			//강사신청 함
			}else {
				List<InstructorDataBean> instructorDataBean = instructorDao.selectInstructorNo(account_no);
				String instructor_no = instructorDataBean.get(0).getInstructor_no();
				String inproval_state = String.valueOf(instructorDataBean.get(0).getApproval_state());
				//강사승인 O
				if(inproval_state.equals("3")) {
					model.addAttribute("account_no", account_no);
					model.addAttribute("instructor_no", instructor_no);
					model.addAttribute("inproval_state", inproval_state);
					System.out.println("instructor_no : " + instructor_no + "강사권한 O");
					System.out.println("inproval_state : " + inproval_state);
					EduList(instructor_no, model);
				//강사승인 X
				}else {
					model.addAttribute("instructor_no", instructor_no);
					model.addAttribute("inproval_state", inproval_state);
				}
			}
		//외부강사일 경우	
		}else {
			model.addAttribute("inproval_state", "3");
			model.addAttribute("instructor_no", account_no);
			System.out.println("강사계정");
			EduList(account_no, model);
			
			/*for(int i = 0; i<instructorDataBean.size(); i++) {
				InstructorDataBean instructor= instructorDataBean.get(i);
				System.out.println(instructor.getEdu_no() + " / " + instructor.getEdu_field() + " / " + instructor.getEdu_name());
			}*/
		}
		
		return "inst_req/main";
	}
	
	private void EduList(String account_no, Model model) {
		List<InstructorDataBean> instructorDataBean1 = instructorDao.selectEduReq(account_no);
		List<InstructorDataBean> instructorDataBean2 = instructorDao.selectEduList(account_no);
		model.addAttribute("result1", instructorDataBean1);
		model.addAttribute("result2", instructorDataBean2);
		
	}

	@RequestMapping(value = "/inst_req", method = RequestMethod.GET)
	public String InstReq(@RequestParam("account_no") String account_no, Locale locale, Model model) throws Exception{
		System.out.println("InstReq Account_no : " + account_no);
		String empName = instructorDao.selectEmployeesName(account_no);
		System.out.println("empName : " + empName);
		InstructorDataBean instructorDataBean = new InstructorDataBean();
		instructorDataBean.setEmp_no(account_no);
		instructorDataBean.setName(empName);
		int result = instructorDao.insertInstReq(instructorDataBean);
		model.addAttribute("result", result);
		System.out.println("강사신청결과  : " + result );
		return "inst_req/instReqPro";
	}
	
	@RequestMapping(value = "/edu_req", method = RequestMethod.GET)
	public String EduReq(@RequestParam("instructor_no") String instructor_no, Locale locale, Model model) throws Exception{
		model.addAttribute("instructor_no", instructor_no);
		List<InstructorDataBean> edu_code = instructorDao.selectEduCode();
		List<InstructorDataBean> belong_no = instructorDao.selectBelongNo();
		List<InstructorDataBean> instructor = instructorDao.selectInstructor();
		
		model.addAttribute("edu_code", edu_code);
		model.addAttribute("belong_no", belong_no);
		model.addAttribute("instructor", instructor);
		
		return "inst_req/eduReqFrom";
	}
	
	@ResponseBody
	@RequestMapping(value = "/belong", method = RequestMethod.GET)
	public List<InstructorDataBean> Belong(@RequestParam("belong_no") String belong_no, Locale locale, Model model) throws Exception{
		System.out.println("instructor/belong");
		List<InstructorDataBean> department = instructorDao.selectDepartment(belong_no);  
		for(int i = 0; i<department.size(); i++) {
			InstructorDataBean dept= department.get(i);
			System.out.println(dept.getDept_no() + " / " + dept.getDept_name() + " / " + dept.getBelong_no());
		}
		System.out.println(department);
		model.addAttribute("department", department);
		return department;
	}
}
