package com.es.handler;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Calendar;
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

import com.es.education.EduHistoryDao;
import com.es.education.EduHistoryDto;
import com.es.education.EduListDao;
import com.es.education.EducationListDto;

@Controller
public class EducationHandler {

	@Resource
	private EduListDao edDao;

	/* 나현 - 수강목록  */
	@Resource
	private EduHistoryDao eduhistoryDao;

	/*주현- 교육목록*/
	@RequestMapping("/EducationList")
	public ModelAndView eduList(HttpServletRequest request, HttpServletResponse response) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		List<EducationListDto> edu_list = null;
		List eduTargetList = new ArrayList();
		List applicantsList = new ArrayList();

		/*세션*/
		HttpSession httpSession = request.getSession();
		String emp_no =  (String) httpSession.getAttribute("no");

		if(emp_no != null) {

		List<EduHistoryDto> edu_history = eduhistoryDao.eduHistoryList(emp_no);
		System.out.println(" edu_history : "+edu_history);
		request.setAttribute("history", edu_history); // 수강한 교육을 찾기위해
		request.setAttribute("historySize", edu_history.size()); // 수강한 교육을 찾기위해
		
		System.out.println("emp_no : "+emp_no);
			
			
		/*페이징*/
		
		int totalList = 0;
		int spage = 1;
		if(request.getParameter("page") != null) 
			spage = Integer.parseInt(request.getParameter("page")); //현재페이지
		int start =spage*10-9; // 현재페이지 시작 페이징번호
		
		System.out.println("start : "+start);
		map.put("start",start-1);
		
		
		/*검색 O*/
		if(request.getParameter("opt") !=null) { 
			String opt = request.getParameter("opt");
			String condition = request.getParameter("condition");
			request.setAttribute("condition", condition);
			request.setAttribute("opt", opt);
			
			System.out.println("Handler opt : "+opt+" condition : "+condition);
			
			map.put("opt",opt);
			map.put("condition",condition);
			
		}
		
		edu_list = edDao.EducationList(map);
		totalList = edDao.EducationListCount(map);
		request.setAttribute("listCount", totalList); 
		
		
		
		
		/*페이징 처리*/
		int maxPage = (int)(totalList/10.0+0.9); //전체페이지수
		int startPage = (int)(spage/5.0+0.8)*5-4; //시작페이지 번호
		int endPage= startPage+4;			//마지막 페이지 번호
		if(endPage > maxPage) endPage = maxPage;

		
		System.out.println("spage : "+spage+" maxPage : "+maxPage+" startPage : "+startPage+" endPage : "+endPage);
		request.setAttribute("spage", spage);
		request.setAttribute("maxPage", maxPage);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		
		for(int i=0; edu_list.size() > i ;i++) {
			String eduTarget = null; 
			int tmp_edu_no = edu_list.get(i).getEdu_no();
			
	        try {
	        	if(edu_list.get(i).getEdu_target() != null) {
	        	eduTarget = new String(edu_list.get(i).getEdu_target().getBytes("ISO-8859-1"), "UTF-8");
	        	eduTargetList.add(i, eduTarget);
	        	
	        	}else {
	        		eduTargetList.add(i, -1);
	        	}
	        } catch (UnsupportedEncodingException e) {
	           e.printStackTrace();
	        }
	        
	        int applicants = edDao.EducationApplicants(tmp_edu_no);
	        
	        if(applicants >= edu_list.get(i).getApplicants_limit()) {
	        	applicantsList.add(i, tmp_edu_no);
	        }
			
		}
		
        
		request.setAttribute("applicantsList", applicantsList);
		
		
		request.setAttribute("targetList", eduTargetList);
		request.setAttribute("list", edu_list);
		
		}
		return new ModelAndView("edu_list/list");
	}

	/*주현- 교육목록 디테일*/
	@RequestMapping("/EducationList/detail")
	public ModelAndView EducationDetail(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("handler educationDetail ");
		int edu_no = Integer.parseInt(request.getParameter("edu_no"));
		//해당 edu_no에 관한 커리큘럼 등 상세정보

		EducationListDto edu_detail = edDao.EducationListDetail(edu_no);
		/*세션*/
		HttpSession httpSession = request.getSession();
		String emp_no =  (String) httpSession.getAttribute("no");

		/* 수강신청했는지 알려고*/
		List apCheck = new ArrayList();


		List<EduHistoryDto> edu_history = eduhistoryDao.eduHistoryList(emp_no);
		request.setAttribute("history", edu_history); // 수강한 교육을 찾기위해
		request.setAttribute("historySize", edu_history.size()); // 수강한 교육을 찾기위해

		for(int i=0; edu_history.size() > i ;i++) {
			apCheck.add(i, edu_history.get(i).getEdu_no());
		}

		request.setAttribute("apCheck", apCheck); // 수강한 교육을 찾기위해




		int applicants = edDao.EducationApplicants(edu_no);

		String eduTarget = null; 
        try {
        	if(edu_detail.getEdu_target() != null) {
        		eduTarget = new String(edu_detail.getEdu_target().getBytes("ISO-8859-1"), "UTF-8");
        	}else {
        		eduTarget = " '제한없음' ";
        	}
        } catch (UnsupportedEncodingException e) {
           e.printStackTrace();
        }
        
        
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
		int applicants = edDao.EducationApplicants(edu_no);

		resultMap.put("applicants", applicants);
		resultMap.put("belong_name", edu_detail.getBelong_name());
		resultMap.put("applicants_limit", edu_detail.getApplicants_limit());
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
		String emp_no =  (String) httpSession.getAttribute("no");

		String instructor_no = edu_detail.getInstructor_no();

		System.out.println("emp_no : "+emp_no+" instructor_no : "+instructor_no+" edu_no : "+edu_no);

		map.put("edu_no", edu_no);
		map.put("emp_no", emp_no);
		map.put("instructor_no", instructor_no);

		int application = edDao.EducationApplication(map);
		return application;

	}

	/*주현- 교육신청 취소*/
	@RequestMapping("/EducationList/applicationDelete")
	@ResponseBody
	public void applicationDelete(HttpServletRequest request, HttpServletResponse response) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		System.out.println("handler applicationDelete ");
		int edu_no = Integer.parseInt(request.getParameter("edu_no"));

		HttpSession httpSession = request.getSession();
		String emp_no =  (String) httpSession.getAttribute("no");

		map.put("edu_no", edu_no);
		map.put("emp_no", emp_no);

		edDao.EducationApplicationDelete(map);
	}

	/*나현 - 수강목록*/
	@RequestMapping("/eduhistory")
	public String eduHistory(Model model, HttpSession session, HttpServletResponse response) throws IOException {
		String emp_no = (String) session.getAttribute("no");
		//		세션이 있을 때만
		if (emp_no != null) {
			/* 직원의 전체 수강내역 리스트 */
			List<EduHistoryDto> eduhistory_list = eduhistoryDao.eduHistoryList(emp_no);
			for(EduHistoryDto dto : eduhistory_list) {
				Date tempDate = dto.getEnd_date();	// end date 가져온다

				// end date에 7일 더한다
				Calendar cal = Calendar.getInstance();
				cal.setTime(tempDate);
				cal.add(Calendar.DATE, 7);

				//				System.out.println("end_date : " + tempDate + "// cal : " + cal.getTime());

				// 현재 날짜 가져 온다
				Date curDate = new Date();
				Calendar c = Calendar.getInstance();
				c.setTime(curDate);

				// 현재 날짜랑 end date에 7일 더한 날짜랑 비교한다
				if( c.getTime().before(cal.getTime()) ) { //c:현재 날짜 < cal:평가마감일 (버튼 생성)
					// 비교해서 현재 날짜가 더 전이면
					dto.setButtonFlag(1); 
					//				System.out.println("Flag 1 전송"); //flag 1 : 강의평가 할 수 있는 것
				} else {
					// 비교해서 현재 날짜가 이 후면
					dto.setButtonFlag(0);
					//				System.out.println("Flag 0 전송"); //flag 0 : 강의평가 기간이 지나 제출할 수 없음
				}
			}

			Date date = new Date();//현재날짜 보내기
			model.addAttribute("date", date);
			model.addAttribute("eduhistory_list", eduhistory_list);
		}
		return "edu_history/main";
	}
	/* 나현 - 수강목록 끝 */

	/* 나현 - 강의평가 제출내역 보기 */
	@RequestMapping(value="/eduhistory/show_eval", method = RequestMethod.GET, produces="application/json")
	@ResponseBody
	public Map<String, Object> eduHistoryShowEval(HttpServletRequest request, HttpServletResponse response, Model model, HttpSession session, @RequestParam("edu_no") int edu_no) {
		System.out.println("해당 edu_no : " + edu_no);
		
		String emp_no;
		//창연 - 관리자 입장에서 직원의 강의 평가 내용을 볼 수 있도록 수정
		if(null != request.getParameter("emp_no")) {
			emp_no = request.getParameter("emp_no");
		} else {
			emp_no = (String) session.getAttribute("no");			
		}
		Map<String, Object> resultMap = new HashMap<String, Object>();
		EduHistoryDto show_eval = eduhistoryDao.EduHistoryShowEval(edu_no, emp_no); //어떤 직원인지 emp_no를 넣어줌

		System.out.println("가져온 교육명 : " + show_eval.getEdu_name());
		System.out.println("가져온 교육일정 : " + show_eval.getEdu_schedule());
		System.out.println("가져온  강의평가: " + show_eval.getEmp_eval());

		resultMap.put("edu_no", show_eval.getEdu_no());
		resultMap.put("edu_name", show_eval.getEdu_name());
		resultMap.put("edu_state", show_eval.getEdu_state());
		resultMap.put("edu_schedule", show_eval.getEdu_schedule());
		resultMap.put("emp_eval", show_eval.getEmp_eval());
		return resultMap;
	}


	/* 나현 - 수강목록 中 한 강의 선택했을 시 (해당 강의 상세정보) */
	@RequestMapping(value = "/eduhistory/detail")
	public String eduHistoryDetail(Model model, HttpSession session, @RequestParam("edu_no") int no ) 
			throws ParseException, UnsupportedEncodingException{
		//select box로 보여줄 직원의 수강목록
		String emp_no = (String) session.getAttribute("no");
		List<EduHistoryDto> eduhistory_list = eduhistoryDao.eduHistoryList(emp_no);
		model.addAttribute("eduhistory_list", eduhistory_list);

		//해당 edu_no에 관한 커리큘럼 등 상세정보
		EduHistoryDto eduhistory_detail = eduhistoryDao.eduHistoryDetail(no);
		model.addAttribute("eduhistory_detail", eduhistory_detail);

		//---json data (교육대상)
		String target = eduhistory_detail.getEdu_target();
		if (target !=null) {
			target = new String(eduhistory_detail.getEdu_target().getBytes("ISO-8859-1"), "UTF-8"); //한글 인코딩
			// String을 JSON으로 파싱
			JSONParser jsonParser = new JSONParser();
			
			JSONArray arr = (JSONArray) jsonParser.parse(target);
			
			//----- 형변환 잘 되었는지 확인  ------
			if( arr instanceof JSONArray) {
				//System.out.println("arr은 JSONArray 입니다.");
			} else {
				System.out.println("arr은 문자열");
			}
			//-----------------------------
			
			String aaa = "";
			for(int i=0; i<arr.size(); i++) {
				JSONObject tmp = (JSONObject)arr.get(i);
				
				String dept_name = (String)tmp.get("dept_name");
				String belong_name  = (String)tmp.get("belong_name");
				String position_name = (String)tmp.get("position_name");
				
				aaa += belong_name + "사업부 - " + dept_name + "   직급: " + position_name + "<br>";
				
			}
			System.out.println("강의 대상(target) : " + aaa);
			model.addAttribute("edu_target", aaa);
		}else {
			model.addAttribute("edu_target", "제한없음");
		}
		
		
		return "edu_history/detail";
	}

	/* 나현 - 강의자료 다운받기(상세페이지 내에서) */
	@RequestMapping("/eduhistory/eduHistoryFile")
	public void eduHistoryFileDownload(Model model, @RequestParam("edu_no") int no,
			HttpServletRequest req, HttpServletResponse res) throws IOException {
		EduHistoryDto eduhistory_detail = eduhistoryDao.eduHistoryDetail(no);


		//파일 : 주현언니 community의  ProjectFileDownload 서블릿 참고
		String path = eduhistory_detail.getFile_path();
		String file_ori_name = new String(eduhistory_detail.getFile_ori_name().getBytes("UTF-8"), "ISO-8859-1");

		/*String path = request.getParameter("path");*/
		File file = new File(path);

		/*response.setContentType(getContentType()); */
		res.setContentLength((int)file.length());

		System.out.println("file_path : " + eduhistory_detail.getFile_path());
		System.out.println("file_save_name : " + eduhistory_detail.getFile_save_name());
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
		EduHistoryDto eduhistory_detail = eduhistoryDao.eduHistoryDetail(no);
		model.addAttribute("eduhistory_detail", eduhistory_detail);

		return "edu_history/emp_eval";
	}

	/* 나현 - 강의평가 제출 */
	@RequestMapping(value="/eduhistory/write_emp_eval", method=RequestMethod.POST)
	public @ResponseBody String WriteEmpEval(Model model, @RequestParam("edu_no") int no, 
			@RequestParam("emp_eval") String emp_eval,
			HttpServletResponse response) throws Exception {
		System.out.println("교육번호:" +no + ", 강의평가란 : " + emp_eval);

		// 비지니스 로직
		int result = eduhistoryDao.insertEmpEval(no, emp_eval);
		System.out.println("result:" + result);

		//window창 닫고 페이지 reload (view단에서 적용되지 않아 java단에서 처리)
		String command = "<script>";
		command += "window.close();";
		command += "window.opener.location.reload();";
		command += "</script>";

		return command;
	}

}
