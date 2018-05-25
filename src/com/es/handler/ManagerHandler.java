package com.es.handler;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.es.education.EduHistoryDto;
import com.es.employees.DepartmentDto;
import com.es.employees.PositionDto;
import com.es.instructor.InstructorDto;
import com.es.manager.EmpListDto;
import com.es.manager.ExInstructorDto;
import com.es.manager.InstListDto;
import com.es.manager.ManagerDao;

@Controller
@RequestMapping("manage")
public class ManagerHandler {
	
	@Resource
	ManagerDao managerDao;
	
	@RequestMapping("empList")
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
	
	@RequestMapping("empDetail")
	public ModelAndView empDetail(HttpServletRequest request, HttpServletResponse response) {
		String emp_no = request.getParameter("emp_no");
		EmpListDto emp = managerDao.getEmpDetail(emp_no);
		List<EduHistoryDto> eduHistory = managerDao.getEmpEduList(emp_no);
		for(EduHistoryDto dto : eduHistory) {
			Date tempDate = dto.getEnd_date();	// end date 가져온다
			
			// end date에 7일 더한다
			Calendar cal = Calendar.getInstance();
			cal.setTime(tempDate);
			cal.add(Calendar.DATE, 15);
			
			// 현재 날짜 가져 온다
			Date curDate = new Date();
			Calendar c = Calendar.getInstance();
			c.setTime(curDate);
			
			// 현재 날짜랑 end date에 7일 더한 날짜랑 비교한다
			if( c.getTime().before(cal.getTime()) ) { //c:현재 날짜 < cal:평가마감일 (버튼 생성)
				// 비교해서 현재 날짜가 더 전이면
				dto.setButtonFlag(1); 
			} else {
				// 비교해서 현재 날짜가 이 후면
				dto.setButtonFlag(0);
			}
		}
		
		Date date = new Date();//현재날짜 보내기
		request.setAttribute("date", date);
		request.setAttribute("emp", emp);
		request.setAttribute("eduHistory", eduHistory);
		return new ModelAndView("manage/empDetail");
	}
	
	@RequestMapping("instList")
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
	
	@RequestMapping("instDetail")
	public ModelAndView instDetail(HttpServletRequest request, HttpServletResponse response) {
		String inst_no = request.getParameter("inst_no");
		InstructorDto inst = managerDao.getInstDetail(inst_no);
		List<EduHistoryDto> eduHistory = managerDao.getEmpEduList(inst_no);
		for(EduHistoryDto dto : eduHistory) {
			Date tempDate = dto.getEnd_date();	// end date 가져온다
			
			// end date에 7일 더한다
			Calendar cal = Calendar.getInstance();
			cal.setTime(tempDate);
			cal.add(Calendar.DATE, 15);
			
			// 현재 날짜 가져 온다
			Date curDate = new Date();
			Calendar c = Calendar.getInstance();
			c.setTime(curDate);
			
			// 현재 날짜랑 end date에 7일 더한 날짜랑 비교한다
			if( c.getTime().before(cal.getTime()) ) { //c:현재 날짜 < cal:평가마감일 (버튼 생성)
				// 비교해서 현재 날짜가 더 전이면
				dto.setButtonFlag(1); 
			} else {
				// 비교해서 현재 날짜가 이 후면
				dto.setButtonFlag(0);
			}
		}
		
		Date date = new Date();//현재날짜 보내기
		request.setAttribute("date", date);
		request.setAttribute("emp", inst);
		request.setAttribute("eduHistory", eduHistory);
		return new ModelAndView("manage/empDetail");
	}
	
	@RequestMapping("exInstList")
	public ModelAndView exInstList(HttpServletRequest request, HttpServletResponse response) {
		int pageNum;
		String srchCat = null, srchWord = null;
		if(null != request.getParameter("srchCat")) {
			srchCat = request.getParameter("srchCat");
			srchWord = request.getParameter("srchWord");
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
		if(null != srchCat && null != srchWord) {
			srchMap.put("cat", srchCat);
			srchMap.put("word", srchWord);
			count = managerDao.getExInstCount(srchMap);
		} else {
			count = managerDao.getExInstCount();
		}
		if(start > count) {
			start = (count / 10) * 10;
		}
		List<InstListDto> exInstList;
		if(null != srchCat && null != srchWord) {
			srchMap.put("start", start);
			exInstList = managerDao.getExInstList(srchMap);
			System.out.println(exInstList.size());
		} else {
			exInstList = managerDao.getExInstList(start);
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
		
		request.setAttribute("exInstList", exInstList);
		request.setAttribute("pageStart", pageStart);
		request.setAttribute("pageEnd", pageEnd);
		request.setAttribute("next", next);
		return new ModelAndView("manage/exInstList");
	}
	
	@RequestMapping("exInstDetail")
	public ModelAndView exInstDetail(HttpServletRequest request, HttpServletResponse response) {
		String inst_no = request.getParameter("exInst_no");
		ExInstructorDto exInst = managerDao.getExInstDetail(inst_no);
		request.setAttribute("exInst", exInst);
		return new ModelAndView("manage/exInstDetail");
	}
	
	@RequestMapping(value="exInstRegist", method=RequestMethod.GET)
	public ModelAndView exInstRegistView(HttpServletRequest request, HttpServletResponse response) {
		return new ModelAndView("manage/exInstRegist");
	}
	
	@RequestMapping(value="exInstRegist", method=RequestMethod.POST)
	public ModelAndView exInstRegist(HttpServletRequest request, HttpServletResponse response) {
		String name = request.getParameter("name");
		String identity_no = request.getParameter("identy_no1") + "-" + request.getParameter("identy_no2") + "XXXXXX";
		String address = request.getParameter("address");
		String phone = request.getParameter("phone1") + "-" + request.getParameter("phone2") + "-" + request.getParameter("phone3");
		String email = request.getParameter("email");
		
		Calendar now = Calendar.getInstance();
		String year = Integer.toString(now.get(now.YEAR));
		String month;
		int month_temp = now.get(now.MONTH) + 1;
		if(month_temp < 10) {
			month = "0" + Integer.toString(month_temp);
		} else {
			month = Integer.toString(month_temp);
		}
		
		String find_no = 'I' + year + month;
		String temp_no = managerDao.getInstNo(find_no);
		String inst_no;
		if(null != temp_no) {
			int number = Integer.parseInt(temp_no.substring(7, 11)) + 1;
			if((number / 1000) != 0) {
				inst_no = find_no + Integer.toString(number);
			} else if((number / 100) != 0) {
				inst_no = find_no + "0" + Integer.toString(number);
			} else if((number / 10) != 0) {
				inst_no = find_no + "00" + Integer.toString(number);
			} else {
				inst_no = find_no + "000" + Integer.toString(number);
			}
		} else {
			inst_no = find_no + "0001";
		}
		
		ExInstructorDto inst = new ExInstructorDto();
		inst.setInstructor_no(inst_no);
		inst.setName(name);
		inst.setIdentity_no(identity_no);
		inst.setAddress(address);
		inst.setPhone(phone);
		inst.setEmail(email);
		
		int result = managerDao.setExInst(inst);
		if(result == 0) {
			try {
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert('외부강사 등록에 실패하였습니다.<br/>다시 시도해주세요.');");
				out.println("</script>");
				out.flush();
				return new ModelAndView("manage/exInstRegist");
			} catch (IOException e) {
				e.printStackTrace();
			}						
		} else if(result == 1) {
			HashMap<String, String> param = new HashMap<String, String>();
			param.put("inst_no", inst_no);
			param.put("name", name);
			result = managerDao.setInst(param);
			if(result == 0) {
				try {
					PrintWriter out = response.getWriter();
					out.println("<script>");
					out.println("alert('강사 등록에 실패하였습니다.<br/>다시 시도해주세요.');");
					out.println("</script>");
					out.flush();
					return new ModelAndView("manage/exInstRegist");
				} catch (IOException e) {
					e.printStackTrace();
				}				
			}
		}
		return exInstList(request, response);
	}
	
	@RequestMapping(value="reqInstList", method=RequestMethod.GET)
	public ModelAndView instEval(HttpServletRequest request, HttpServletResponse response) {
		List<InstListDto> waitList = managerDao.getReqInstList(1);
		List<InstListDto> examingList = managerDao.getReqInstList(2);
		List<InstListDto> refusedList = managerDao.getReqInstList(4);
		request.setAttribute("waitList", waitList);
		request.setAttribute("examingList", examingList);
		request.setAttribute("refusedList", refusedList);
		return new ModelAndView("manage/instReqList");
	}
	
	@RequestMapping(value="reqInstList", method=RequestMethod.POST)
	public ModelAndView changeEval(HttpServletRequest request, HttpServletResponse response) {
		String emp_no = request.getParameter("emp_no");
		int approval_state = Integer.parseInt(request.getParameter("approval_state"));
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("emp_no", emp_no);
		param.put("approval_state", approval_state);
		if(managerDao.changeReqInst(param) == 0) {
			try {
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert('변경에 실패하였습니다.<br>잠시 후 다시 시도해주세요.')");
				out.println("</script>");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return instEval(request, response);
	}
	
}

