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
		List<EmpListDto> empList = managerDao.getEmpList(pageNum);
		int count = managerDao.getEmpCount();
		request.setAttribute("empList", empList);
		request.setAttribute("empCount", count);
		return new ModelAndView("manage/empList");
	}
}















