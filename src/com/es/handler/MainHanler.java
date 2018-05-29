package com.es.handler;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
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
import com.es.instructor.InstructorDao;
import com.es.instructor.InstructorDto;
import com.es.main.MainDao;
import com.es.main.MainDto;
import com.es.manager.InstListDto;
import com.es.manager.ManagerDao;

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

