package com.es.handler;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.es.employees.DepartmentDto;
import com.es.employees.EmployeesDto;
import com.es.employees.PositionDto;
import com.es.manager.EmpListDto;
import com.es.manager.InstListDto;
import com.es.manager.ManagerDao;

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
}















