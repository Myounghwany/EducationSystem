package com.es.handler;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.es.employees.BelongDto;
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
	
	@RequestMapping("manageEmpList")
	public ModelAndView empList(HttpServletRequest request, HttpServletResponse response) {
		int pageNum;
		if(request.getParameter("pageNum") == null) {
			pageNum = 1;
		} else {
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		}
		int start = (pageNum - 1) * 10;
		int count = managerDao.getEmpCount();
		if(start > count) {
			start = (count / 10) * 10;
		}
		List<EmpListDto> empList = managerDao.getEmpList(start);
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
		
		
		request.setAttribute("empList", empList);
		request.setAttribute("pageStart", pageStart);
		request.setAttribute("pageEnd", pageEnd);
		request.setAttribute("next", next);
		return new ModelAndView("manage/empList");
	}
	
	@RequestMapping("manageInstList")
	public ModelAndView instList(HttpServletRequest request, HttpServletResponse response) {
		int pageNum;
		if(request.getParameter("pageNum") == null) {
			pageNum = 1;
		} else {
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		}
		int start = (pageNum - 1) * 10;
		int count = managerDao.getInstCount();
		if(start > count) {
			start = (count / 10) * 10;
		}
		List<InstListDto> instList = managerDao.getInstList(start);
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















