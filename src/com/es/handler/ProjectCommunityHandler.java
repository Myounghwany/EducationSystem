package com.es.handler;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.es.projectCommunity.ProjectCommunityDao;
import com.es.projectCommunity.ProjectCommunityDto;




@Controller
public class ProjectCommunityHandler {

	
	@Resource
	private ProjectCommunityDao projectDao;
	
	@RequestMapping("/ProjectList")
	public ModelAndView list(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("Controller list");
		HashMap<String, Object> map = new HashMap<String, Object>();
		List<ProjectCommunityDto> list;
		int totalList = 0;
		
		
		int spage = 1;
		if(request.getParameter("page") != null) 
			spage = Integer.parseInt(request.getParameter("page")); //현재페이지
		int start =spage*10-9; // 현재페이지 시작 페이징번호
		
		/*1페이지
		1 1~10
		2 11~20
		
		pageNum =  1
		
		1~10
		
		(pageNum - 1) * 10 + 1 = 1
		(1 - 1) * 10 + 1 = 1
		(2 - 1) * 10 + 1 = 11
		*/
		map.put("start",start-1);
		
		
		list = projectDao.projectList(map);
		
		/*검색 O*/
		if(request.getParameter("opt") !=null) { 
			String opt = request.getParameter("opt");
			String condition = request.getParameter("condition");
			request.setAttribute("condition", condition);
			map.put("opt",opt);
			map.put("condition",condition);
			list = projectDao.projectList(map);
			
		}
		

		totalList = projectDao.projectListCount(map);
		request.setAttribute("listCount", totalList); 
		
		
		/*페이징 처리*/
		int maxPage = (int)(totalList/10.0+0.9); //전체페이지수
		int startPage = (int)(spage/5.0+0.8)*5-4; //시작페이지 번호
		int endPage= startPage+4;			//마지막 페이지 번호
		if(endPage > maxPage) endPage = maxPage;

		request.setAttribute("spage", spage);
		request.setAttribute("maxPage", maxPage);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		request.setAttribute("list", list);

		return new ModelAndView("project_community/list");
	}
	
	@RequestMapping("/ProjectDelete")
	public String ProjectDelte(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("Controller ProjectDelete");
		
		int project_no = Integer.parseInt(request.getParameter("project_no"));
		System.out.println(project_no);
		
		ProjectCommunityDto detail = projectDao.detailProject(project_no);
		
		if(detail.getFile_ori_name() != null) {
			File file = new File(detail.getFile_path());
			if(file.exists()==true) {
				file.delete();
			}
			
		}
		
		
		int result = projectDao.deleteProject(project_no);
		System.out.println("result : "+result);

		return "redirect:ProjectList.do";
	}

	@RequestMapping(value="/ProjectWrite", method=RequestMethod.GET)
	public ModelAndView ProjectWrite(HttpServletRequest req, HttpServletResponse rep) {
		System.out.println("Controller ProjectWrite GET");
		return new ModelAndView("project_community/write");
	}

	@RequestMapping(value="/ProjectWrite", method=RequestMethod.POST)
	public String ProjectWriteForm(HttpServletRequest req, HttpServletResponse rep) throws IllegalStateException, IOException {
		System.out.println("Controller ProjectWriteForm POST");
		HttpSession httpSession = req.getSession();
		/*String writer = (String) httpSession.getAttribute("userId");*/
		
		ProjectCommunityDto projectDto = new ProjectCommunityDto();
		
		String classification = req.getParameter("selectType");
		String title = req.getParameter("title");
		String content = req.getParameter("text");
		String writer = "juhyun";
		String file_path= "";
		String file_save_name= "";
		String file_ori_name= "";
		
		
		projectDto.setClassification(classification);
		projectDto.setTitle(title);
		projectDto.setContent(content);
		projectDto.setWriter(writer);
		projectDto.setFile_path(file_path);
		projectDto.setFile_save_name(file_save_name);
		projectDto.setFile_ori_name(file_ori_name);
		
		
		// -- 파일 저장하기
		
		String path = req.getServletContext().getRealPath("/save");
		Map returnObject = new HashMap();
		
		System.out.println("path : "+path);
		
		MultipartHttpServletRequest mhsr = (MultipartHttpServletRequest) req;
		Iterator<String> iterator = mhsr.getFileNames();

		System.out.println("mhsr.getFileNames() : " +mhsr.getFileNames());
		System.out.println("iterator : " +iterator);
		
		
		MultipartFile mfile = null;
		String fieldName = "";
		List resultList = new ArrayList();
		
		//디렉토리가 없으면 생성
		File dir = new File(path);
		if(!dir.isDirectory()) {
			dir.mkdirs();
		}
		
		while(iterator.hasNext()) {
			fieldName = iterator.next();
			
			mfile = mhsr.getFile(fieldName);
			
			String origName;
			
			/*origName = new String(mfile.getOriginalFilename().getBytes("8859_1"),"UTF-8");*/
			origName = new String(mfile.getOriginalFilename().getBytes("UTF-8"),"UTF-8");
			System.out.println(origName);
			
			//파일명이 없다면
			if("".equals(origName)) {
				continue;
			}
			
			System.out.println("origName : "+origName);
			
			
			//파일 명 변경(uuid로 암호화)
			String ext = origName.substring(origName.lastIndexOf('.'));//확장자
			String saveFileName = getUuid() + ext;
			
			System.out.println("saveFileName : "+saveFileName);
			
			
			//설정한 path에 파일저장
			File serverFile = new File(path+ File.separator + saveFileName);
			mfile.transferTo(serverFile);

			file_path= path+ File.separator + saveFileName;
			file_ori_name= origName;
			file_save_name= saveFileName;

			projectDto.setFile_path(file_path);
			projectDto.setFile_ori_name(file_ori_name);
			projectDto.setFile_save_name(file_save_name);
			
		}
		
		
		
		// write내용 넣기
		
		int result = projectDao.writeProject(projectDto);
		
		return "redirect:ProjectList.do";
		
	}

	public static String getUuid() {
		return UUID.randomUUID().toString().replaceAll("-","");
	}
	
	
	@RequestMapping("/ProjectDetail")
	public ModelAndView detail(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		System.out.println("Controller ProjectDetail ");
		
		
		int project_no = Integer.parseInt(request.getParameter("project_no"));
		
		System.out.println(project_no);
		
		ProjectCommunityDto result = projectDao.detailProject(project_no);
		int hit = projectDao.updateHit(result);
		
		
		request.setAttribute("result", result);
		request.setAttribute("hit", hit);
		
		return new ModelAndView("project_community/detail");  
	}
	
	@RequestMapping("/ProjectFileDownload")
	public void download(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int project_no = Integer.parseInt(request.getParameter("project_no"));
		ProjectCommunityDto result = projectDao.detailProject(project_no);
		//파일
		String path = result.getFile_path();
		String file_ori_name= new String(result.getFile_ori_name().getBytes("UTF-8"), "ISO-8859-1"); 
		
		/*String path = request.getParameter("path");*/
		File file = new File(path);

		/*response.setContentType(getContentType()); */
		response.setContentLength((int)file.length());

		System.out.println("file.getName() : "+file.getName());
		
		
		response.setHeader("Content-Disposition", "attachment; filename=\""+file_ori_name+"\";");
		response.setHeader("Content-Transfer-Encoding", "binary");
		
		OutputStream out = response.getOutputStream();
		FileInputStream fis = null;
		
		
		fis = new FileInputStream(file);
		FileCopyUtils.copy(fis, out);
		
		if(fis != null) {
			fis.close();
		}
		
		out.flush();
		
	}
	
	@RequestMapping(value="/ProjectModify", method=RequestMethod.GET)
	public ModelAndView ProjectModify(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("Controller ProjectModify GET");
		int project_no = Integer.parseInt(request.getParameter("project_no"));
		
		ProjectCommunityDto result = projectDao.detailProject(project_no);
		System.out.println(result);
		request.setAttribute("result", result);
		
		return new ModelAndView("project_community/modify");
	}

	@RequestMapping(value="/ProjectModify", method=RequestMethod.POST)
	public String ProjectModifyForm(HttpServletRequest request, HttpServletResponse response) throws IllegalStateException, IOException {
		System.out.println("Controller ProjectModify POST");
		int project_no = Integer.parseInt(request.getParameter("project_no"));
		ProjectCommunityDto detail = projectDao.detailProject(project_no);
		
		/*String writer = (String) httpSession.getAttribute("userId");*/
		
		/*세션등록*/
		HttpSession httpSession = request.getSession();
		httpSession.setAttribute("name", "juhyun");
		String name =  (String) httpSession.getAttribute("name");
		
		ProjectCommunityDto projectDto = new ProjectCommunityDto();
		
		String classification = request.getParameter("selectType");
		String title = request.getParameter("title");
		String content = request.getParameter("text");
		String writer = name;
		String file_path= "";
		String file_save_name= "";
		String file_ori_name= "";
		
		projectDto.setProject_no(project_no);
		projectDto.setClassification(classification);
		projectDto.setTitle(title);
		projectDto.setContent(content);
		projectDto.setWriter(writer);
		
		
		System.out.println("classification : "+classification+" title : "+title+" content : "+content+" writer : "+writer);
		
		
		// -- 파일 저장하기
		
		String path = request.getServletContext().getRealPath("/save");
		
		MultipartHttpServletRequest mhsr = (MultipartHttpServletRequest) request;
		Iterator<String> iterator = mhsr.getFileNames();

		System.out.println("mhsr.getFileNames() : " +mhsr.getFileNames());
		System.out.println("iterator : " +iterator);
		
		
		MultipartFile mfile = null;
		String fieldName = "";
		
		//디렉토리가 없으면 생성
		File dir = new File(path);
		if(!dir.isDirectory()) {
			dir.mkdirs();
		}
		
		while(iterator.hasNext()) {
			fieldName = iterator.next();
			
			mfile = mhsr.getFile(fieldName);
			
			String origName;
			
			origName = new String(mfile.getOriginalFilename().getBytes("UTF-8"),"UTF-8");
			//파일명이 없다면
			if("".equals(origName)) {
				continue;
			}
			
			System.out.println("origName : "+origName);
			
			
			//파일 명 변경(uuid로 암호화)
			String ext = origName.substring(origName.lastIndexOf('.'));//확장자
			String saveFileName = getUuid() + ext;
			
			System.out.println("saveFileName : "+saveFileName);
			
			
			//설정한 path에 파일저장
			File serverFile = new File(path+ File.separator + saveFileName);
			mfile.transferTo(serverFile);

			file_path= path+ File.separator + saveFileName;
			file_save_name= saveFileName;
			file_ori_name= origName;

			projectDto.setFile_path(file_path);
			projectDto.setFile_save_name(file_save_name);
			projectDto.setFile_ori_name(file_ori_name);
			
		}
		
		if(file_ori_name.equals("")) {
			projectDto.setFile_path(detail.getFile_path());
			projectDto.setFile_ori_name(file_ori_name);
			projectDto.setFile_save_name(file_save_name);
		}
		
		System.out.println("projectDto.getClassification() : "+projectDto.getClassification());
		System.out.println("projectDto.getContent() : "+projectDto.getContent());
		System.out.println("projectDto.getFile_path() : "+projectDto.getFile_path());
		System.out.println("projectDto.getProject_no() :"+projectDto.getProject_no());
		System.out.println("projectDto.getTitle() : "+projectDto.getTitle());
		System.out.println("projectDto.getWriter() :"+projectDto.getWriter());
		
		
		
		int result = projectDao.modifyProject(projectDto);
		
		System.out.println("result : " +result);
		
		return "redirect:ProjectDetail.do?project_no="+project_no;
	}
	
}
