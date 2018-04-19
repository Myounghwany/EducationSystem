package com.es.handler;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.es.projectCommunity.ProjectCommunityDao;
import com.es.projectCommunity.ProjectCommunityDto;

@Controller
public class ProjectCommunityHandler {

	@Resource
	private ProjectCommunityDao projectDao;
	
	private ProjectCommunityDto projectDto;
	
	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse rep) {
		System.out.println("Controller list");
		
		List<ProjectCommunityDto> list = projectDao.projectList();
		req.setAttribute("list", list);
		System.out.println("list : "+list);
		return new ModelAndView("project_community/list");
	}

	@RequestMapping(value="/ProjectWrite")
	public ModelAndView ProjectWrite(HttpServletRequest req, HttpServletResponse rep) {
		System.out.println("Controller ProjectWrite");
		
		
		return new ModelAndView("project_community/write");
	}
	
}
