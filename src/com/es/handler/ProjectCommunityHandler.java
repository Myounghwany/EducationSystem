package com.es.handler;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.es.projectCommunity.ProjectCommunityDao;
import com.es.projectCommunity.ProjectCommunityDto;


@Controller
public class ProjectCommunityHandler {

	@Resource
	private ProjectCommunityDao projectDao;
	
	@RequestMapping("/ProjectList")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse rep) {
		System.out.println("Controller list");
		
		List<ProjectCommunityDto> list = projectDao.projectList();
		req.setAttribute("list", list);
		System.out.println("list : "+list);
		return new ModelAndView("project_community/list");
	}

	@RequestMapping(value="/ProjectWrite", method=RequestMethod.GET)
	public ModelAndView ProjectWrite(HttpServletRequest req, HttpServletResponse rep) {
		System.out.println("Controller ProjectWrite GET");
		return new ModelAndView("project_community/write");
	}

	@RequestMapping(value="/ProjectWrite", method=RequestMethod.POST)
	public String ProjectWriteForm(ProjectCommunityDto projectDto) throws IllegalStateException, IOException {
		System.out.println("Controller ProjectWriteForm POST");
		
		MultipartFile uploadfile = projectDto.getUpfile();
		
		if(uploadfile != null) {
			String fileName = uploadfile.getOriginalFilename();
			System.out.println("fileName : "+fileName);
			
			projectDto.setFile_name(fileName);
			
			File file = new File("C:/images/"+fileName);
			uploadfile.transferTo(file);
			
		}
		
		
/*		String path = req.getServletContext().getRealPath("/save");
	    int maxSize = 1024*1024*100; 
	    String encoding="UTF-8";
		Map returnObject = new HashMap();
		
		
		MultipartHttpServletRequest mhsr = (MultipartHttpServletRequest) req;
		Iterator<String> iterator = mhsr.getFileNames();


		
		MultipartFile mfile = null;
		String fileName = "";
		List resultList = new ArrayList();
		
		//디렉토리가 없으면 생성
		File dir = new File(path);
		if(!dir.isDirectory()) {
			dir.mkdirs();
		}
		
		while(iterator.hasNext()) {
			fileName = iterator.next();
			mfile = mhsr.getFile(fileName);
			String origName;
			
			origName = new String(mfile.getOriginalFilename().getBytes("8859_1"),"UTF-8");
			//파일명이 없다면
			if("".equals(origName)) {
				continue;
			}
			
			//파일 명 변경(uuid로 암호화)
			String ext = origName.substring(origName.lastIndexOf('.'));//확장자
			String saveFileName = getUuid() + ext;
			
			//설정한 path에 파일저장
			File serverFile = new File(path+ File.separator + saveFileName);
			mfile.transferTo(serverFile);
			
			Map file = new HashMap();
			file.put("origName",origName);
			file.put("sfile",serverFile);
			resultList.add(file);
			
		}
		
		
		returnObject.put("files", resultList);
		returnObject.put("params", mhsr.getParameterMap());
		
		returnObject.put("files",resultList);
		returnObject.put("params", mhsr.getParameterMap());
		*/
		
		
		
		return "redirect:index.do";
	}

	/*public static String getUuid() {
		return UUID.randomUUID().toString().replaceAll("-","");
	}*/
	
}
