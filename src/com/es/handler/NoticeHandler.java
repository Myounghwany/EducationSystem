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

import com.es.notice.NoticeDao;
import com.es.notice.NoticeDataBean;

@Controller
public class NoticeHandler {

	@Resource
	private NoticeDao noticedao;

	@RequestMapping("/notice")
	public ModelAndView list(HttpServletRequest request, HttpServletResponse response) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		List<NoticeDataBean> list;
		List<String> write_name = null;
		int totalList = 0;
		
		int spage = 1;
		if(request.getParameter("page") != null) 
			spage = Integer.parseInt(request.getParameter("page")); 
		int start =spage*10-9; 
		
		map.put("start",start-1);
		
		list = noticedao.noticetList(map);

		if(request.getParameter("opt") !=null) { 
			String opt = request.getParameter("opt");
			String condition = request.getParameter("condition");
			request.setAttribute("condition", condition);
			map.put("opt",opt);
			map.put("condition",condition);
			list = noticedao.noticetList(map);
			
		}
		totalList = noticedao.noticeListCount(map);
		request.setAttribute("listCount", totalList); 
				
		int maxPage = (int)(totalList/10.0+0.9); 
		int startPage = (int)(spage/5.0+0.8)*5-4; 
		int endPage= startPage+4;			
		if(endPage > maxPage) endPage = maxPage;

		request.setAttribute("spage", spage);
		request.setAttribute("maxPage", maxPage);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		request.setAttribute("list", list);

		return new ModelAndView("notice/list");
	}
	
	@RequestMapping("/notice/delete")
	public String noticeDelte(HttpServletRequest request, HttpServletResponse response) {

		HttpSession httpSession = request.getSession();
		httpSession.setAttribute("emp_no", "E2018040001");
		String emp_no = (String) httpSession.getAttribute("emp_no");
		
		int notice_no = Integer.parseInt(request.getParameter("notice_no"));
		System.out.println(notice_no);
		
		NoticeDataBean detail = noticedao.detailnotice(notice_no);
		
		if(detail.getFile_ori_name() != null) {
			File file = new File(detail.getFile_path());
			if(file.exists()==true) {
				file.delete();
			}
		}
		
		int result = noticedao.deleteNotice(notice_no);
		return "redirect:/notice.do";
	}

	@RequestMapping(value="/notice/write", method=RequestMethod.GET)
	public ModelAndView noticeWrite(HttpServletRequest req, HttpServletResponse rep) {
		System.out.println("Controller noticeWrite GET");
		return new ModelAndView("notice/write");
	}

	@RequestMapping(value="/notice/write", method=RequestMethod.POST)
	public String noticeWriteForm(HttpServletRequest req, HttpServletResponse rep) throws IllegalStateException, IOException {
		HttpSession httpSession = req.getSession();
		String emp_no = (String) httpSession.getAttribute("emp_no");
		String writer_name = (String) httpSession.getAttribute("name");
		
		NoticeDataBean noticeDto = new NoticeDataBean();
		
		
		String title = req.getParameter("title");
		String content = req.getParameter("text");
		String writer = writer_name;
		String file_path= "";
		String file_save_name= "";
		String file_ori_name= "";
		
		
		noticeDto.setTitle(title);
		noticeDto.setContent(content);
		noticeDto.setWriter(writer);
		noticeDto.setWriter_name(writer_name);
		noticeDto.setFile_path(file_path);
		noticeDto.setFile_save_name(file_save_name);
		noticeDto.setFile_ori_name(file_ori_name);
		

		String path = req.getServletContext().getRealPath("/save");
		Map returnObject = new HashMap();
		
		MultipartHttpServletRequest mhsr = (MultipartHttpServletRequest) req;
		Iterator<String> iterator = mhsr.getFileNames();
		
		MultipartFile mfile = null;
		String fieldName = "";
		List resultList = new ArrayList();
		

		File dir = new File(path);
		if(!dir.isDirectory()) {
			dir.mkdirs();
		}
		
		while(iterator.hasNext()) {
			fieldName = iterator.next();
			
			mfile = mhsr.getFile(fieldName);
			
			String origName;
			
			
			origName = new String(mfile.getOriginalFilename().getBytes("UTF-8"),"UTF-8");
			System.out.println(origName);
			

			if("".equals(origName)) {
				continue;
			}


			String ext = origName.substring(origName.lastIndexOf('.'));
			String saveFileName = getUuid() + ext;

			File serverFile = new File(path+ File.separator + saveFileName);
			mfile.transferTo(serverFile);

			file_path= path+ File.separator + saveFileName;
			file_ori_name= origName;
			file_save_name= saveFileName;

			noticeDto.setFile_path(file_path);
			noticeDto.setFile_ori_name(file_ori_name);
			noticeDto.setFile_save_name(file_save_name);
			
		}
		
		int result = noticedao.insertNotice(noticeDto);
		
		return "redirect:/notice.do";
		
	}


	public static String getUuid() {
		return UUID.randomUUID().toString().replaceAll("-","");
	}
	
	
	@RequestMapping("/notice/detail")
	public ModelAndView detail(HttpServletRequest request, HttpServletResponse response) throws Throwable {

		HashMap<String, Object> map = new HashMap<String, Object>(); 
		int notice_no = Integer.parseInt(request.getParameter("notice_no"));
		
		map.put("notice_no", notice_no);
		
		NoticeDataBean result = noticedao.detailnotice(notice_no);
		int hit = noticedao.updateHit(result);
		
		HttpSession httpSession = request.getSession();
		httpSession.setAttribute("emp_no", "E2009010077");

		String emp_no =  (String) httpSession.getAttribute("emp_no");
		map.put("emp_no",emp_no);

		request.setAttribute("result", result);
		request.setAttribute("hit", hit);
		
		return new ModelAndView("notice/detail");  
	}
	
	@RequestMapping("/notice/fileDownload")
	public void download(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int notice_no = Integer.parseInt(request.getParameter("notice_no"));
		NoticeDataBean result = noticedao.detailnotice(notice_no);

		String path = result.getFile_path();
		String file_ori_name= new String(result.getFile_ori_name().getBytes("UTF-8"), "ISO-8859-1"); 
		
		
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
	
	@RequestMapping(value="/notice/modify", method=RequestMethod.GET)
	public ModelAndView noticeModify(HttpServletRequest request, HttpServletResponse response) {
		int notice_no = Integer.parseInt(request.getParameter("notice_no"));
		NoticeDataBean result = noticedao.detailnotice(notice_no);
		request.setAttribute("result", result);

		return new ModelAndView("notice/modify");
	}

	@RequestMapping(value="/notice/modify", method=RequestMethod.POST)
	public String noticeModifyForm(HttpServletRequest request, HttpServletResponse response) throws IllegalStateException, IOException {
		int notice_no = Integer.parseInt(request.getParameter("notice_no"));
		NoticeDataBean detail = noticedao.detailnotice(notice_no);
		
		HttpSession httpSession = request.getSession();
		httpSession.setAttribute("emp_no", "E2009010077");
		String emp_no =  (String) httpSession.getAttribute("emp_no");
		
		NoticeDataBean noticeDto = new NoticeDataBean();

		String title = request.getParameter("title");
		String content = request.getParameter("text");
		String writer = emp_no;
		String file_path= "";
		String file_save_name= "";
		String file_ori_name= "";
		
		noticeDto.setNotice_no(notice_no);
		noticeDto.setTitle(title);
		noticeDto.setContent(content);
		noticeDto.setWriter(writer);
		
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


			String ext = origName.substring(origName.lastIndexOf('.'));//확장자
			String saveFileName = getUuid() + ext;


			File serverFile = new File(path+ File.separator + saveFileName);
			mfile.transferTo(serverFile);

			file_path= path+ File.separator + saveFileName;
			file_save_name= saveFileName;
			file_ori_name= origName;

			noticeDto.setFile_path(file_path);
			noticeDto.setFile_save_name(file_save_name);
			noticeDto.setFile_ori_name(file_ori_name);
			
		}
		
		if(file_ori_name.equals("")) {
			noticeDto.setFile_path(detail.getFile_path());
			noticeDto.setFile_ori_name(detail.getFile_ori_name());
			noticeDto.setFile_save_name(detail.getFile_save_name());
		}
		
		
		int result = noticedao.modifyNotice(noticeDto);
		
		System.out.println("result : " +result);
		
		return "redirect:/notice/detail.do?notice_no="+notice_no;
	}
}
