package com.es.handler;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.es.petition.PetitionDao;
import com.es.petition.PetitionDto;
import com.es.petition.PetitionLikeDao;
import com.es.petition.PetitionLikeDto; 
 
@Controller
public class PetitionHandler {

	@Resource
	private PetitionDao petitionDao;
	@Resource
	private PetitionLikeDao petitionLikeDao;
	  	
	@RequestMapping(value="/PetitionWrite", method=RequestMethod.GET)
	public ModelAndView write(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		System.out.println("Write Handler");
		return new ModelAndView("petition/write");
	}
	
	@RequestMapping(value="/PetitionWrite", method=RequestMethod.POST)
	public String writePro(HttpServletRequest request, HttpServletResponse response)  throws IllegalStateException,IOException {  // String IOException
		System.out.println("WritePro Handler");
		
//		HttpSession httpSession = request.getSession();
		String emp_no = "test1";
		String file_path= "";
		String file_save_name= "";
		String file_ori_name= "";
		
		PetitionDto petitionDto = new PetitionDto();
		petitionDto.setWriter(emp_no);
		petitionDto.setTitle(request.getParameter("title"));
		petitionDto.setClassification(request.getParameter("classification"));
		petitionDto.setContent(request.getParameter("content")); 
		petitionDto.setFile_path(file_path);
		petitionDto.setFile_ori_name(file_save_name);
		petitionDto.setFile_save_name(file_ori_name);
		
		String path = request.getServletContext().getRealPath("/save"); 
		 
		MultipartHttpServletRequest mhsr = (MultipartHttpServletRequest) request;
		Iterator<String> iterator = mhsr.getFileNames();
 
		MultipartFile mfile = null;
		String fieldName = ""; 
		
		File dir = new File(path);
		if(!dir.isDirectory()) {
			dir.mkdirs();
		}
		
		while(iterator.hasNext()) {
			fieldName = iterator.next();
			mfile = mhsr.getFile(fieldName);
			String origName;
			 
			origName = new String(mfile.getOriginalFilename().getBytes("UTF-8"),"UTF-8"); 
			 
			if("".equals(origName)) {
				continue;
			}
			 
			String ext = origName.substring( origName.lastIndexOf('.') ); 
			String saveFileName = getUuid() + ext; 
			
			File serverFile = new File( path+ File.separator + saveFileName );
			mfile.transferTo(serverFile);

			file_path= path+ File.separator + saveFileName;
			file_ori_name= origName;
			file_save_name= saveFileName;

			petitionDto.setFile_path(file_path);
			petitionDto.setFile_ori_name(file_ori_name);
			petitionDto.setFile_save_name(file_save_name); 
		}
		  
		petitionDao.petitionWrite(petitionDto);
		
		return "redirect:PetitionList.do"; 
	}
	
	public static String getUuid() {
		return UUID.randomUUID().toString().replaceAll("-","");
	}
	
	@RequestMapping("/PetitionDetail")
	public ModelAndView detail(HttpServletRequest request, HttpServletResponse response) throws IllegalStateException,Throwable {
		System.out.println("Detail Handler");
		 
		int petition_no = Integer.parseInt( request.getParameter("petition_no") );
		 
		PetitionDto petitionDto = petitionDao.petitionDetail(petition_no);
		int count = petitionLikeDao.agreeCount(petition_no);
		
		if(request.getParameter("msg") == "true" ) {
			request.setAttribute("agree","true");
		} else if (request.getParameter("msg") == "false") {
			request.setAttribute("agree","false");
		}
		
		request.setAttribute("count", count);
		request.setAttribute("result", petitionDto);  
		
		return new ModelAndView("petition/detail");  
	}
	
	@RequestMapping("/PetitionAgree")
	public String agree(HttpServletRequest request, HttpServletResponse response) throws IllegalStateException,Throwable {
		System.out.println("Agree Handler");
		
		int petition_no = Integer.parseInt( request.getParameter("petition_no")) ; 
		String emp_no = "test1";
		
		PetitionLikeDto petitionLikeDto = new PetitionLikeDto();
		petitionLikeDto.setPetition_no(petition_no);
		petitionLikeDto.setEmp_no(emp_no);
		
		int agree = petitionLikeDao.petitionAgree(petitionLikeDto);
		
		System.out.println(agree);
		 
		int count = petitionLikeDao.agreeCount(petition_no);
		System.out.println(count);
		if(count >2) { 
			petitionLikeDao.approvalUpdate(petition_no);
		}
		
		if ( agree == 0 ) {
			String msg = "true";
			return "redirect:PetitionDetail.do?petition_no="+petition_no+"&msg="+msg;
		} else {
			String msg = "false";
			return "redirect:PetitionDetail.do?petition_no="+petition_no+"&msg="+msg;
		}
	}
	
	@RequestMapping("/PetitionFileDownload")
	public void download(HttpServletRequest request, HttpServletResponse response) throws IOException { 
		System.out.println("File Handler");
		
		int petition_no = Integer.parseInt( request.getParameter("petition_no") );
		
		PetitionDto petitionDto = petitionDao.petitionDetail(petition_no);
		String path = petitionDto.getFile_path();
		String file_ori_name= new String(petitionDto.getFile_ori_name().getBytes("UTF-8"), "ISO-8859-1"); 
		 
		File file = new File(path);
 
		response.setContentLength((int)file.length()); 
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
	 
	@RequestMapping("/PetitionList")
	public ModelAndView list(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		System.out.println("List Handler");
		HashMap<String, Object> map = new HashMap<String,Object>();
		List<PetitionDto> list; 
		
		int totalList = 0;
		int spage = 1;
		
		if(request.getParameter("page") != null) 
			spage = Integer.parseInt( request.getParameter("page") );
		
		int start =spage*10-9;
		
		map.put("start",start-1);
		 
		list = petitionDao.petitionList(map);
		
		if(request.getParameter("src") !=null) { 
			String src = request.getParameter("src");
			String search = request.getParameter("search");
			request.setAttribute("search", search);
			map.put("src",src);
			map.put("search",search);
			list = petitionDao.petitionList(map);
			
			totalList = list.size();
		}
		 
//		totalList = petitionDao.petitionListCount(map);
//		request.setAttribute("listCount", totalList); 
		 
		int maxPage = (int)(totalList/10.0+0.9);  
		int startPage = (int)(spage/5.0+0.8)*5-4;  
		int endPage= startPage+4; 
		if(endPage > maxPage) endPage = maxPage; 

		request.setAttribute("spage", spage);
		request.setAttribute("maxPage", maxPage);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		request.setAttribute("list", list);

		return new ModelAndView("petition/list");
		// 여기서 write_time을 가져와서 6개월 더한 값을 저장한후에 서버시간이 
	} 
	
	
}
