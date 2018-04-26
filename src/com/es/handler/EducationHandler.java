package com.es.handler;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.sql.Array;
import java.util.ArrayList;
import java.util.Date;
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
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.es.education.EduListDao;
import com.es.education.EducationListDto;


import com.es.education.EduHistoryDao;
import com.es.education.EduHistoryDto;

@Controller
public class EducationHandler {
	
	@Resource
	private EduListDao edDao;
	private EduHistoryDao edulistDao;
	
	/*주현- 교육목록*/
	@RequestMapping("/EducationList")
	public ModelAndView eduList(HttpServletRequest request, HttpServletResponse response) {
		List<EducationListDto> edu_list = edDao.EducationList();
		List eduTargetList = new ArrayList();
		
		
		for(int i=0; edu_list.size() > i ;i++) {
			String eduTarget = null; 
	        try {
	        	eduTarget = new String(edu_list.get(i).getEdu_target().getBytes("ISO-8859-1"), "UTF-8");
	        	eduTargetList.add(i, eduTarget);
	        	
	        } catch (UnsupportedEncodingException e) {
	           e.printStackTrace();
	        }
			
		}
		
		request.setAttribute("targetList", eduTargetList);
		request.setAttribute("list", edu_list);
		return new ModelAndView("edu_list/list");
	}

	/*주현- 교육목록 디테일*/
	@RequestMapping("/EducationList/detail")
	public ModelAndView EducationDetail(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("handler educationDetail ");
		int edu_no = Integer.parseInt(request.getParameter("edu_no"));
		System.out.println(edu_no);
		
		//해당 edu_no에 관한 커리큘럼 등 상세정보
		
		EducationListDto edu_detail = edDao.EducationListDetail(edu_no);
		int applicants = edDao.EducationApplicants(edu_no);
		
		String eduTarget = null; 
        try {
        	eduTarget = new String(edu_detail.getEdu_target().getBytes("ISO-8859-1"), "UTF-8");
        } catch (UnsupportedEncodingException e) {
           e.printStackTrace();
        }
      	/*request.setAttribute("file", file);*/
        request.setAttribute("eduTarget", eduTarget);
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
		EducationListDto edu_detail = edDao.EducationListDetail(edu_no);
		
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

		
		EducationListDto edu_detail = edDao.EducationListDetail(edu_no);
		HttpSession httpSession = request.getSession();
		/*String writer = (String) httpSession.getAttribute("userId");*/
		
		
		String emp_no = "E2018040001";
		String instructor_no = edu_detail.getInstructor_no();

		System.out.println("emp_no : "+emp_no+" instructor_no : "+instructor_no+" edu_no : "+edu_no);
		
		map.put("edu_no", edu_no);
		map.put("emp_no", emp_no);
		map.put("instructor_no", instructor_no);
		
		int application = edDao.EducationApplication(map);
		return application;
		
	}

	
	/*나현 - 수강목록*/
	@RequestMapping("/eduhistory")
	public String eduHistory(Model model, HttpSession session) throws IOException {
		//세션 테스트
		session.setAttribute("account", "E2018040001");
		String account = (String) session.getAttribute("account");

		//직원의 전체 수강내역 리스트
		List<EduHistoryDto> edu_list = edulistDao.eduHistoryList(account);
		model.addAttribute("edu_list", edu_list);
		Date date = new Date();
		model.addAttribute("date", date); //현재 날짜
		 
		return "edu_history/main";
	}
	/* 나현 - 수강목록 끝 */
	
	/* 나현 - 수강목록 中 한 강의 선택 (상세정보) */
	@RequestMapping(value = "/eduhistory/detail")
	public String eduHistoryDetail(Model model, HttpSession session, @RequestParam("edu_no") int no ) 
			throws ParseException, UnsupportedEncodingException{
		//select box로 보여줄 직원의 수강목록
		String account = (String) session.getAttribute("account");
		List<EduHistoryDto> edu_list = edulistDao.eduHistoryList(account);
		model.addAttribute("edu_list", edu_list);
		
		//해당 edu_no에 관한 커리큘럼 등 상세정보
		EduHistoryDto edu_detail = edulistDao.eduHistoryDetail(no);
		model.addAttribute("edu_detail", edu_detail);
		
		//---json data (교육대상)
		String target = new String(edu_detail.getEdu_target().getBytes("ISO-8859-1"), "UTF-8");
		System.out.println(target); //한글 인코딩 확인
        
		// String을 JSON으로 파싱
		JSONParser jsonParser = new JSONParser();
		
        JSONArray arr = (JSONArray) jsonParser.parse(target);
		System.out.println(arr);
       //---- 형변환 잘 되었는지 확인  ------
       if( arr instanceof JSONArray) {
    	   System.out.println("arr은 JSONArray 입니다.");
       } else {
    	   System.out.println("arr은 문자열");
       }
       //-----------------------------
       
       HashMap<String, String> map1 = new HashMap<String, String>();
       
       for(int i=0; i<arr.size(); i++) {
    	   JSONObject tmp = (JSONObject)arr.get(i);
    	   String dept_name = (String)tmp.get("dept_name");
    	   String belong_name  = (String)tmp.get("belong_name");
    	   String position_name = (String)tmp.get("position_name");
    	   
    	   /*
    	   model.addAttribute("belong_name", belong_name); //소속 WEB
    	   model.addAttribute("dept_name", dept_name); //부서 WEB A팀
    	   model.addAttribute("position_name", position_name); // 직급 전체
    	   */
    	   map1.put("belong_name", belong_name);
    	   map1.put("dept_name", dept_name);
    	   map1.put("position_name", position_name);
    	   
    	   for(String key : map1.keySet()) {
    		   System.out.println("key : " + key + "/ value : " + map1.get(key));
    	   }
       }
		return "edu_history/detail";
	}
	
	/* 나현 - 수강목록 */
	@RequestMapping("/eduhistory/eduHistoryFile")
	public void eduHistoryFileDownload(Model model, @RequestParam("edu_no") int no,
				HttpServletRequest req, HttpServletResponse res) throws IOException {
		EduHistoryDto edu_detail = edulistDao.eduHistoryDetail(no);
		
		//파일 : 주현언니 community의  ProjectFileDownload 서블릿 참고
		String path = edu_detail.getFile_path();
		String file_ori_name = new String(edu_detail.getFile_ori_name().getBytes("UTF-8"), "ISO-8859-1");
		
		/*String path = request.getParameter("path");*/
		File file = new File(path);
		
		/*response.setContentType(getContentType()); */
		res.setContentLength((int)file.length());
		
		System.out.println("file_path : " + edu_detail.getFile_path());
		System.out.println("file_save_name : " + edu_detail.getFile_save_name());
		System.out.println("file.getName() : " + file.getName());
		
		res.setHeader("Content-Disposition", "attachment; filename=\""+file_ori_name+"\";");
		res.setHeader("Content-Transfer-Encoding", "binary");
		
		OutputStream out = res.getOutputStream();
		FileInputStream fis = null;
		
		
		fis = new FileInputStream(file);
		FileCopyUtils.copy(fis, out);
		
		if(fis != null) {
			fis.close();
		}
		
		out.flush();
	
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
