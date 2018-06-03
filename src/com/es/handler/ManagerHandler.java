package com.es.handler;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.es.education.EduCodeDto;
import com.es.education.EduHistoryDto;
import com.es.employees.DepartmentDto;
import com.es.employees.PositionDto;
import com.es.instructor.InstructorDBBean;
import com.es.instructor.InstructorDao;
import com.es.instructor.InstructorDto;
import com.es.manager.EmpListDto;
import com.es.manager.ExInstructorDto;
import com.es.manager.InstListDto;
import com.es.manager.ManagerDao;
import com.es.manager.MustEduDto;

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
	public ModelAndView instDetail(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String page = request.getParameter("page");
		if(page == null) page = "1"; 
		String inst_no = request.getParameter("inst_no");
		InstructorDto inst = managerDao.getInstDetail(inst_no);
		request.setAttribute("inst", inst);
		EduList(inst, page, request);
		return new ModelAndView("manage/instDetail");
	}
	
	private void EduList(InstructorDto inst, String page, HttpServletRequest request) {
		InstructorDto eduList = new InstructorDto();
		InstructorDao instructorDao = new InstructorDBBean();
		String account_no = inst.getInstructor_no();
		eduList.setAccount_no(account_no);
		eduList.setPage((Integer.parseInt(page)*10-9)-1);
		List<InstructorDto> InstructorDto1 = instructorDao.selectEduReq(account_no);
		List<InstructorDto> InstructorDto2 = instructorDao.selectEduList(eduList);
		int listCount = instructorDao.selectEduListCnt(account_no);
		System.out.println("listCount : " + listCount);
		int maxPage = (int)(listCount/10.0 + 0.9);
		int startPage = (int)(Integer.parseInt(page)/5.0 + 0.8)* 5-4;
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
			} catch (Exception e) {
				e.printStackTrace();
			}	
		}
		request.setAttribute("result1", InstructorDto1);
		request.setAttribute("result2", InstructorDto2);
		request.setAttribute("page", page);
		request.setAttribute("maxPage", maxPage);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
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
	
	@RequestMapping("reqInstDelete")
	public ModelAndView deleteReqInst(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		String emp_no = request.getParameter("emp_no");
		int result = managerDao.deleteReqInst(emp_no);
		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		if(result == 1) {
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('삭제되었습니다.')");
			out.println("</script>");
			out.flush();
		} else {
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('삭제에 실패하였습니다. 다시 시도해주세요.');");
			out.println("</script>");
			out.flush();
		}
		return instEval(request, response);
	}
	
	@RequestMapping("mustEmpList")
	public ModelAndView mustList(HttpServletRequest request, HttpServletResponse response) throws ParseException {
		List<EduCodeDto> eduList = managerDao.getMustEduList();
		List<MustEduDto> empList = new ArrayList<MustEduDto>(), stateList;
		List<EmpListDto> tempList;
		int edu_code;
		int target_belong;
		int target_dept;
		int target_pos;
		JSONParser jsonParser = new JSONParser();
		JSONArray arr;
		JSONObject temp;
		HashMap<String, Object> emp_map;
		for(EduCodeDto edu : eduList) {
			edu_code = edu.getEdu_code();
			arr = (JSONArray) jsonParser.parse(edu.getEdu_target());
			if(!(arr instanceof JSONArray)) {
				System.out.println("형변환 실패");
				break;
			}
			for(int i=0; i<arr.size(); i++) {
				temp = (JSONObject)arr.get(i);
				emp_map = new HashMap<String, Object>();
				target_belong = Integer.parseInt((String)temp.get("belong_no"));
				target_dept = Integer.parseInt((String)temp.get("dept_no"));
				target_pos = Integer.parseInt((String)temp.get("position_no"));
				System.out.println("소속번호 : " + target_belong + ", 부서번호 : " + target_dept + ", 직책번호 : " + target_pos);
				emp_map.put("belong", target_belong);
				emp_map.put("dept", target_dept);
				emp_map.put("pos", target_pos);
				tempList = managerDao.getMustEduEmpList(emp_map);
				stateList = managerDao.getMustEduStateList(edu_code);
				MustEduDto tempDto;
				int ok = 0;
				for(int j=0; j<tempList.size(); j++) {
					tempDto = new MustEduDto();
					for(int k=0; k<stateList.size(); k++) {
						if(tempList.get(j).getEmp_no().equals(stateList.get(k).getEmp_no())) {
							tempDto.setEmp_no(tempList.get(j).getEmp_no());
							tempDto.setName(tempList.get(j).getName());
							tempDto.setDept_name(tempList.get(j).getDept_name());
							tempDto.setPosition_name(tempList.get(j).getPosition_name());
							tempDto.setEdu_code(stateList.get(k).getEdu_code());
							tempDto.setEdu_state(stateList.get(k).getEdu_state());
							ok = 1;
							break;
						} else {
							ok = 0;
						}
					}
					if(ok == 0) {
						tempDto.setEmp_no(tempList.get(j).getEmp_no());
						tempDto.setName(tempList.get(j).getName());
						tempDto.setDept_name(tempList.get(j).getDept_name());
						tempDto.setPosition_name(tempList.get(j).getPosition_name());
						tempDto.setEdu_code(edu_code);
						tempDto.setEdu_state(null);
						ok = 0;
					} else if(ok != 0) {
						ok = 0;
					}
					System.out.println("사번 : " + tempDto.getEmp_no() + ", 상태 : " + tempDto.getEdu_state());
					empList.add(tempDto);
				}
			}			
		}
		request.setAttribute("eduList", eduList);
		request.setAttribute("empList", empList);
		return new ModelAndView("manage/empMustFinish");
	}
	
}

