package com.es.handler;

import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
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
import com.es.education.EduListDao;
import com.es.education.EducationListDto;
import com.es.instructor.InstructorDao;
import com.es.instructor.InstructorDto;
import com.es.main.MainDao;
import com.es.main.MainDto;
import com.es.manager.InstListDto;
import com.es.manager.ManagerDao;
import com.es.notice.NoticeDao;
import com.es.notice.NoticeDataBean;

@Controller
public class MainHanler {

	@Resource
	private MainDao maindao;
	
	@Resource
	private EduHistoryDao eduhistoryDao;
	
	@Resource
	private InstructorDao instructorDao;

	@Resource
	private ManagerDao managerDao;
	
	@Resource
	private NoticeDao noticedao;
	
	@Resource
	private EduListDao edDao;
	
		@RequestMapping("main")
		public ModelAndView noitce(HttpServletRequest request, HttpServletResponse response, MainDto maindto, Model model, HttpSession session) throws Throwable {
			HttpSession httpSession = request.getSession();
			String account_no =  (String) httpSession.getAttribute("no");
			String name =  (String) httpSession.getAttribute("name");
			InstructorDto instructorDto = new InstructorDto();
			
			//직원일 경우
			if(account_no.substring(0, 1).equals("E")) {
				String instructor_check = instructorDao.selectInstructorCheck(account_no);
				System.out.println("instructor_check : " + instructor_check);
				//강사 신청 X
				if(instructor_check.equals("0")) {
					System.out.println( "instructor_no X ");
					request.setAttribute("result", "강사만 이용가능한 페이지입니다.");
					request.setAttribute("instructor_no", "null");
					request.setAttribute("account_no", account_no);
				//강사 신청 O
				}else {
					List<InstructorDto> InstructorDto = instructorDao.selectInstructorNo(account_no);
					String instructor_no = InstructorDto.get(0).getInstructor_no();
					String approval_state = String.valueOf(InstructorDto.get(0).getApproval_state());
					String hire_date = InstructorDto.get(0).getHire_date();
					String approval_date = InstructorDto.get(0).getApproval_date();
					
					//강사 승인 O
					if(approval_state.equals("3")) {
						request.setAttribute("account_no", account_no);
						request.setAttribute("instructor_no", instructor_no);
						request.setAttribute("approval_state", approval_state);
						request.setAttribute("hire_date", hire_date);
						System.out.println("instructor_no : " + instructor_no + " 강사권한 O");
						System.out.println("approval_state : " + approval_state);
						//강사정보
						instructorDto.setAccount_no(account_no);
						instructorDto.setInstructor_no(instructor_no);
						List <InstructorDto> instInfo = instructorDao.selectInstructorInfo(instructorDto);
						request.setAttribute("instInfo", instInfo);
						EduList(instructor_no, request, 1);
					//강사 승인 X
					}else {
						request.setAttribute("instructor_no", instructor_no);
						request.setAttribute("approval_state", approval_state);
						request.setAttribute("approval_date", approval_date);
					}
				}
			//직원이 아닐 경우(외부강사일 경우)
			}else {
				request.setAttribute("approval_state", "3");
				request.setAttribute("instructor_no", account_no);
				//강사정보
				instructorDto.setInstructor_no(account_no);
				List <InstructorDto> instInfo = instructorDao.selectInstructorInfo(instructorDto);
				request.setAttribute("instInfo", instInfo);
				EduList(account_no, request, 1);
			}
			
			
			//===================================================
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
				request.setAttribute("date", date);
				request.setAttribute("eduhistory_list", eduhistory_list);
		}
			List<MainDto> noticelist = maindao.noticeFive(maindto);		
			List<MainDto> eduFive = maindao.eduFive(maindto);
			
			request.setAttribute("noticelist", noticelist);
			request.setAttribute("eduFive", eduFive);
			
			//===================
			List<InstListDto> waitList = managerDao.getReqInstList(1);
			List<InstListDto> examingList = managerDao.getReqInstList(2);
			
			request.setAttribute("waitList", waitList);
			request.setAttribute("examingList", examingList);
			
			//===================
			HashMap<String, Object> map = new HashMap<String, Object>();
			List<EducationListDto> edu_list = null;
			List eduTargetList = new ArrayList();
			List applicantsList = new ArrayList();

			/*세션*/

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
			//===================
			return new ModelAndView("index");
		}
		
		
		private void EduList(String account_no, HttpServletRequest request, int page) {
			InstructorDto eduList = new InstructorDto();
			eduList.setAccount_no(account_no);
			eduList.setPage((page*10-9)-1);
			List<InstructorDto> InstructorDto1 = instructorDao.selectEduReq(account_no);
			List<InstructorDto> InstructorDto2 = instructorDao.selectEduList(eduList);
			String evalCnt = instructorDao.selectEvalCnt(account_no);
			int listCount = instructorDao.selectEduListCnt(account_no);
			System.out.println("listCount : " + listCount);
			int maxPage = (int)(listCount/10.0 + 0.9);
			int startPage = (int)((page)/5.0 + 0.8)* 5-4;
			int endPage = startPage + 4;
			if(endPage > maxPage) endPage = maxPage;
			System.out.println("EduList");
			for(int i = 0; i<InstructorDto2.size(); i++) {
				InstructorDto instructorDto = InstructorDto2.get(i);
				String end_date = instructorDto.getEnd_date();
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				try {
					Date deadLine = formatter.parse(end_date);
					Calendar cal = Calendar.getInstance();
					cal.setTime(deadLine);
					cal.add(Calendar.DATE, 8);
					InstructorDto2.get(i).setDeadLine(formatter.format(cal.getTime()));
				} catch (ParseException e) {
					e.printStackTrace();
				}	
			}
			request.setAttribute("evalCnt", evalCnt);
			request.setAttribute("result1", InstructorDto1);
			request.setAttribute("result2", InstructorDto2);
			request.setAttribute("page", page);
			request.setAttribute("maxPage", maxPage);
			request.setAttribute("startPage", startPage);
			request.setAttribute("endPage", endPage);
			
		}
		

}

