package com.es.handler;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.es.education.EduHistoryDto;
import com.es.employees.DepartmentDto;
import com.es.employees.PositionDto;
import com.es.manager.EduListDto;
import com.es.manager.EmpListDto;
import com.es.manager.InstListDto;
import com.es.manager.ManagerDao;
import com.es.manager.PagingDto;

@Controller
public class ManagerHandler {
	
	@Resource
	ManagerDao managerDao;
	
	@RequestMapping("manage/empList")
	public ModelAndView empList(HttpServletRequest request, HttpServletResponse response) {
		int pageNum;
		String srchDept = null, srchPos = null, srchCat = null, srchWord = null;
		if(null != request.getParameter("srchDept")
				|| null != request.getParameter("srchPos")
				|| null != request.getParameter("srchCat")) {
			srchDept = request.getParameter("srchDept");
			srchPos = request.getParameter("srchPos");
			srchCat = request.getParameter("srchCat");
			srchWord = request.getParameter("srchWord");
			request.setAttribute("srchDept", srchDept);
			request.setAttribute("srchPos", srchPos);
			request.setAttribute("srchCat", srchCat);
			request.setAttribute("srchWord", srchWord);
		}
		if(null == request.getParameter("pageNum")) {
			pageNum = 1;
		} else {
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		}
		int start = (pageNum - 1) * 10;
		int count = 0;
		HashMap<String, Object> srchMap = new HashMap<String, Object>();
		if(null != srchDept && null != srchPos && null != srchCat && null != srchWord) {
			srchMap.put("dept", srchDept);
			srchMap.put("pos", srchPos);
			srchMap.put("cat", srchCat);
			srchMap.put("word", srchWord);
			count = managerDao.getEmpCount(srchMap);
		} else {
			count = managerDao.getEmpCount();			
		}
		if(start > count) {
			start = (count / 10) * 10;
		}
		List<EmpListDto> empList;
		if(null != srchDept && null != srchPos && null != srchCat && null != srchWord) {
			srchMap.put("start", start);
			empList = managerDao.getEmpList(srchMap);
			System.out.println(empList.size());
		} else {
			empList = managerDao.getEmpList(start);
		}
		int pageStart = (((start / 10) / 5) * 5) + 1;
		int pageEnd, next;
		if((pageStart + 4) * 10 >= count) {
			if(count%10 != 0) {
				pageEnd = (count / 10) + 1;
				next = 0;
			} else {
				pageEnd = count / 10;
				next = 0;
			}
		} else {
			pageEnd = pageStart + 4;
			next = 1;
		}
		
		List<DepartmentDto> deptList = managerDao.getDepartmentList();
		List<PositionDto> posList = managerDao.getPositionList();
		
		
		request.setAttribute("empList", empList);
		request.setAttribute("pageStart", pageStart);
		request.setAttribute("pageEnd", pageEnd);
		request.setAttribute("next", next);
		request.setAttribute("deptList", deptList);
		request.setAttribute("posList", posList);
		return new ModelAndView("manage/empList");
	}
	
	@RequestMapping("manage/empDetail")
	public ModelAndView empDetail(HttpServletRequest request, HttpServletResponse response) {
		String emp_no = request.getParameter("emp_no");
		Map<String, String> emp = managerDao.getEmpDetail(emp_no);
		request.setAttribute("emp", emp);
		return new ModelAndView("manage/empDetail");
	}
	
	@RequestMapping("manage/instList")
	public ModelAndView instList(HttpServletRequest request, HttpServletResponse response) {
		int pageNum;
		String srchType = null, srchCat = null, srchWord = null;
		if(null != request.getParameter("srchType")
				|| null != request.getParameter("srchCat")) {
			srchType = request.getParameter("srchType");
			srchCat = request.getParameter("srchCat");
			srchWord = request.getParameter("srchWord");
			request.setAttribute("srchType", srchType);
			request.setAttribute("srchCat", srchCat);
			request.setAttribute("srchWord", srchWord);
		}
		if(request.getParameter("pageNum") == null) {
			pageNum = 1;
		} else {
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		}
		int start = (pageNum - 1) * 10;
		int count = 0;
		HashMap<String, Object> srchMap = new HashMap<String, Object>();
		if(null != srchType && null != srchCat && null != srchWord) {
			srchMap.put("type", srchType);
			srchMap.put("cat", srchCat);
			srchMap.put("word", srchWord);
			count = managerDao.getInstCount(srchMap);
		} else {
			count = managerDao.getInstCount();
		}
		if(start > count) {
			start = (count / 10) * 10;
		}
		List<InstListDto> instList;
		if(null != srchType && null != srchCat && null != srchWord) {
			srchMap.put("start", start);
			instList = managerDao.getInstList(srchMap);
			System.out.println(instList.size());
		} else {
			instList = managerDao.getInstList(start);
		}
		int pageStart = (((start / 10) / 5) * 5) + 1;
		int pageEnd, next;
		if((pageStart + 4) * 10 >= count) {
			if(count%10 != 0) {
				pageEnd = (count / 10) + 1;
				next = 0;
			} else {
				pageEnd = count / 10;
				next = 0;
			}
		} else {
			pageEnd = pageStart + 4;
			next = 1;
		}
		
		request.setAttribute("instList", instList);
		request.setAttribute("pageStart", pageStart);
		request.setAttribute("pageEnd", pageEnd);
		request.setAttribute("next", next);
		return new ModelAndView("manage/instList");
	}
	
	/* 나현 - 교육목록 - 교육리스트 */
	@RequestMapping(value="manage/eduList")
	public String eduList(Model model, HttpServletRequest request, HttpServletRequest response) {
		
		PagingDto pageDao = new PagingDto();
		int totalCount = managerDao.count();
		int page = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));
		pageDao.setPageNo(page); //1
		pageDao.setPageSize(7); //7
		pageDao.setTotalCount(totalCount); 
		page = (page-1) * pageDao.getPageSize() + 1;
		
		List<EduListDto> eduList = managerDao.eduList(page, pageDao.getPageSize());
		model.addAttribute("eduList", eduList);
		model.addAttribute("paging", pageDao);
		
		return "manage/eduList";
	}
	/* 나현 - 교육목록 - 교육디테일*/
	@RequestMapping(value="manage/edu_detail", method = RequestMethod.GET, produces="application/json")
	@ResponseBody
	public Map<String, Object> eduDetail(Model model, HttpSession session, @RequestParam("edu_no") int edu_no) throws ParseException, UnsupportedEncodingException {
		System.out.println("해당 edu_no : " + edu_no);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		EduListDto eduListDetail = managerDao.eduListDetail(edu_no);
		
		System.out.println(" 교육명 : " + eduListDetail.getEdu_name());
		System.out.println(" 교육일정 : " + eduListDetail.getEdu_schedule());
		System.out.println(" 소속번호 : " + eduListDetail.getBelong_no());
//		System.out.println(" 소속명 : " + eduListDetail.getBelong_name());
		System.out.println(" 소요예산 : " + eduListDetail.getBudget());
		System.out.println(" 신청마감일 : " + eduListDetail.getClosing_date());
		System.out.println(" 교육코드 : " + eduListDetail.getEdu_code());
//		System.out.println(" 교육코드명 : " + eduListDetail.getEdu_code_name());
		System.out.println(" 교육일시 : " + eduListDetail.getEdu_date());
		System.out.println(" 교육뷴야 : " + eduListDetail.getEdu_field());
		System.out.println(" 교육장소 : " + eduListDetail.getEdu_location());
		System.out.println(" 교육대상 : " + eduListDetail.getEdu_target());
		System.out.println(" 교육방법 : " + eduListDetail.getEdu_way());
		System.out.println(" 강사이름 : " + eduListDetail.getInstructor_name());
		System.out.println(" 강사번호 : " + eduListDetail.getInstructor_no());
		System.out.println(" 담당자 : " + eduListDetail.getManager());
		System.out.println(" 비고 : " + eduListDetail.getNote());

		//---json data (교육대상)
		String target = new String(eduListDetail.getEdu_target().getBytes("ISO-8859-1"), "UTF-8"); //한글 인코딩

		// String을 JSON으로 파싱
		JSONParser jsonParser = new JSONParser();

		JSONArray arr = (JSONArray) jsonParser.parse(target);

		String aaa = "";
		for(int i=0; i<arr.size(); i++) {
			JSONObject tmp = (JSONObject)arr.get(i);

			String dept_name = (String)tmp.get("dept_name");
			String belong_name  = (String)tmp.get("belong_name");
			String position_name = (String)tmp.get("position_name");

			aaa += belong_name + "사업부 - " + dept_name + "   직급: " + position_name + "<br>";

		}
		System.out.println("강의 대상(target) : " + aaa);
		
		resultMap.put("edu_target", aaa);
		resultMap.put("edu_no", eduListDetail.getEdu_no());
		resultMap.put("belong_no", eduListDetail.getBelong_no());
		resultMap.put("edu_name", eduListDetail.getEdu_name());
		resultMap.put("edu_schedule", eduListDetail.getEdu_schedule());
		resultMap.put("budget", eduListDetail.getBudget());
		resultMap.put("closing_date", eduListDetail.getClosing_date());
		resultMap.put("edu_code", eduListDetail.getEdu_code());
		resultMap.put("edu_date", eduListDetail.getEdu_date());
		resultMap.put("edu_feild", eduListDetail.getEdu_field());
		resultMap.put("edu_location", eduListDetail.getEdu_location());
//		resultMap.put("edu_target", eduListDetail.getEdu_target());
		resultMap.put("edu_way", eduListDetail.getEdu_way());
		resultMap.put("instructor_name", eduListDetail.getInstructor_name());
		resultMap.put("instructor_no", eduListDetail.getInstructor_no());
		resultMap.put("manager", eduListDetail.getManager());
		resultMap.put("note", eduListDetail.getNote());
		return resultMap;
	}
	
}















