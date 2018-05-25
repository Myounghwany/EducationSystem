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
import javax.servlet.http.HttpSession;

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
		
		return new ModelAndView("petition/write");
	}
	
	@RequestMapping(value="/PetitionWrite", method=RequestMethod.POST)
	public String writePro(HttpServletRequest request, HttpServletResponse response)  throws IllegalStateException,IOException {
		
		String emp_no = "test1";
		
//		HttpSession httpSession = request.getSession();
//		String emp_no =  (String) httpSession.getAttribute("emp_no");
		
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
		
		if( !dir.isDirectory() ) {
			dir.mkdirs();
		}
		
		while( iterator.hasNext() ) {
			fieldName = iterator.next();
			mfile = mhsr.getFile(fieldName);
			String origName;
			 
			origName = new String( mfile.getOriginalFilename().getBytes("UTF-8"),"UTF-8" ); 
			 
			if( "".equals(origName) ) {
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
		
		String list = request.getParameter("list");
		int petition_no = Integer.parseInt( request.getParameter("petition_no") );
		  
		PetitionDto petitionDto = petitionDao.petitionDetail(petition_no);
		String content = (petitionDto.getContent()).replace("\r\n", "<br>");
		
		request.setAttribute("list",list);
		request.setAttribute("content",content);
		request.setAttribute("result", petitionDto);  
		
		return new ModelAndView("petition/detail");  
	}
	
	@RequestMapping("/PetitionDelete")
	public String delete(HttpServletRequest request, HttpServletResponse response) throws IllegalStateException,Throwable {
	 
		int petition_no = Integer.parseInt( request.getParameter("petition_no") );
		
		petitionDao.petitionDelete(petition_no);

		return "redirect:ManageList.do"; 
	}
	
	@RequestMapping("/PetitionAgree")
	public String agree(HttpServletRequest request, HttpServletResponse response) throws IllegalStateException,Throwable {
 
		String list = request.getParameter("list");
		int petition_no = Integer.parseInt( request.getParameter("petition_no")) ; 
		 
		String emp_no = "test0";    // 현재 세션꺼로 변경
		
//		HttpSession httpSession = request.getSession();
//		String emp_no =  (String) httpSession.getAttribute("emp_no");
		
		PetitionLikeDto petitionLikeDto = new PetitionLikeDto();
		petitionLikeDto.setPetition_no(petition_no);
		petitionLikeDto.setEmp_no(emp_no);  
		
		int state = petitionDao.petitionState(petition_no); // 청원 상태 체크
		
		if(state == 2 || state == 3 || state == 4 || state == 5) {
			response.setContentType("text/html; charset=UTF-8"); 
			PrintWriter out = response.getWriter();
			out.println("<script>alert('기간이 만료된 청원입니다.'); history.go(-1); </script>"); 
			out.flush(); 
			return null;
		}
		
		int agreeCheck = petitionLikeDao.petitionAgree(petitionLikeDto); // 참여 중복 여부 체크

		if ( agreeCheck == 0 ) {
			response.setContentType("text/html; charset=UTF-8"); 
			PrintWriter out = response.getWriter();
			out.println("<script>alert('참여는 한번만 가능합니다.'); history.go(-1); </script>"); 
			out.flush(); 
			return null;
		} 
		
	    int count =  petitionLikeDao.countCheck(petition_no); // 청원 참여 개수 체크
	     
		if(count > 10) {  
			petitionLikeDao.approvalUpdate(petition_no); // 심사중 업데이트
		}
		
		return "redirect:PetitionDetail.do?petition_no="+petition_no+"&list="+list;
	}

	
	@RequestMapping("/PetitionFileDownload")
	public void download(HttpServletRequest request, HttpServletResponse response) throws IOException { 
		 
		int petition_no = Integer.parseInt( request.getParameter("petition_no") );
		
		PetitionDto petitionDto = petitionDao.petitionDetail(petition_no);
		
		String path = petitionDto.getFile_path();
		String file_ori_name= new String( petitionDto.getFile_ori_name().getBytes("UTF-8"), "ISO-8859-1" ); 
		File file = new File(path);
 
		response.setContentLength( (int)file.length() ); 
		response.setHeader( "Content-Disposition", "attachment; filename=\""+file_ori_name+"\";" );
		response.setHeader( "Content-Transfer-Encoding", "binary" );
		
		OutputStream out = response.getOutputStream();
		FileInputStream fis = null; 
		fis = new FileInputStream(file);
		FileCopyUtils.copy(fis, out);
		
		if(fis != null) {
			fis.close();
		} 
		out.flush();
		
	}
	 
	@RequestMapping("/PetitionList") // 청원메인
	public ModelAndView list(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		 
		HashMap<String, Object> map = new HashMap<String,Object>(); 
		map.put("start",0);
		
		List<PetitionDto> ongoinglist = petitionDao.ongoingList(map);
		List<PetitionDto> evaluatelist = petitionDao.evaluateList(map);
  
		request.setAttribute("olist", ongoinglist);
		request.setAttribute("elist", evaluatelist);
		
		return new ModelAndView("petition/list");
	} 
	
	@RequestMapping("/AllList") // 모든청원
	public ModelAndView all(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		 
		HashMap<String, Object> map = new HashMap<String,Object>(); 
		
		int totalList = 0;
		int spage = 1;
		
		if(request.getParameter("page") != null) 
			spage = Integer.parseInt( request.getParameter("page") );
		
		int start =spage*10-9;
		
		map.put("start",start-1);
		  
		List<PetitionDto> list = petitionDao.allList(map);
		
		if(request.getParameter("src") !=null) { 
			String src = request.getParameter("src");
			String search = request.getParameter("search");
			request.setAttribute("src", src);
			request.setAttribute("search", search);
			map.put("src",src);
			map.put("search",search);
 
			list = petitionDao.allList(map);
			
			totalList = list.size();
		}
		
		totalList = petitionDao.petitionListCount(map);
		
		int maxPage = (int)(totalList/10.0+0.9);  
		int startPage = (int)(spage/5.0+0.8)*5-4;  
		int endPage= startPage+4; 
		if(endPage > maxPage) endPage = maxPage; 
 
		request.setAttribute("spage", spage);
		request.setAttribute("maxPage", maxPage);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		request.setAttribute("list", list);
		return new ModelAndView("petition/all");
	} 
	
	@RequestMapping("/OngoingList") // 진행중인 청원
	public ModelAndView ongoing(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		 
		HashMap<String, Object> map = new HashMap<String,Object>(); 
		map.put("sort","ongoing");
		
		int totalList = 0;
		int spage = 1;
		
		if(request.getParameter("page") != null) 
			spage = Integer.parseInt( request.getParameter("page") );
		
		int start =spage*10-9;
		
		map.put("start",start-1);
		  
		List<PetitionDto> list = petitionDao.ongoingList(map);
		
		if(request.getParameter("src") !=null) { 
			String src = request.getParameter("src");
			String search = request.getParameter("search");
			request.setAttribute("src", src);
			request.setAttribute("search", search);
			map.put("src",src);
			map.put("search",search);
 
			list = petitionDao.ongoingList(map);
			
			totalList = list.size();
		}
		
		totalList = petitionDao.petitionListCount(map);
		
		int maxPage = (int)(totalList/10.0+0.9);  
		int startPage = (int)(spage/5.0+0.8)*5-4;  
		int endPage= startPage+4; 
		if(endPage > maxPage) endPage = maxPage; 
 
		request.setAttribute("spage", spage);
		request.setAttribute("maxPage", maxPage);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		request.setAttribute("list", list);

		return new ModelAndView("petition/ongoing");
	} 
	
	
	@RequestMapping("/ExpireList") // 기간이 만료된 청원
	public ModelAndView expire(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		 
		HashMap<String, Object> map = new HashMap<String,Object>();
		map.put("sort","expire");
		
		int totalList = 0;
		int spage = 1;
		
		if(request.getParameter("page") != null) 
			spage = Integer.parseInt( request.getParameter("page") );
		
		int start =spage*10-9;
		
		map.put("start",start-1);
		 
		List<PetitionDto> list = petitionDao.expireList(map);
		
		if(request.getParameter("src") !=null) { 
			String src = request.getParameter("src");
			String search = request.getParameter("search");
			request.setAttribute("src", src);
			request.setAttribute("search", search);
			map.put("src",src);
			map.put("search",search);
			list = petitionDao.expireList(map);
			
			totalList = list.size();
		}
		
		totalList = petitionDao.petitionListCount(map);
  
		int maxPage = (int)(totalList/10.0+0.9);  
		int startPage = (int)(spage/5.0+0.8)*5-4;  
		int endPage= startPage+4; 
		if(endPage > maxPage) endPage = maxPage; 
 
		request.setAttribute("spage", spage);
		request.setAttribute("maxPage", maxPage);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		request.setAttribute("list", list);

		return new ModelAndView("petition/expire");
	} 
	
	@RequestMapping("/EvaluateList") // 심사중인 청원
	public ModelAndView evaluate(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		 
		HashMap<String, Object> map = new HashMap<String,Object>(); 
		map.put("sort","evaluate");
		
		int totalList = 0;
		int spage = 1;
		
		if(request.getParameter("page") != null) 
			spage = Integer.parseInt( request.getParameter("page") );
		
		int start =spage*10-9;
		
		map.put("start",start-1);
		  
		List<PetitionDto> list = petitionDao.evaluateList(map);
		
		if(request.getParameter("src") !=null) { 
			String src = request.getParameter("src");
			String search = request.getParameter("search");
			request.setAttribute("src", src);
			request.setAttribute("search", search);
			map.put("src",src);
			map.put("search",search);
			list = petitionDao.evaluateList(map);
			
			totalList = list.size();
		}
		
		totalList = petitionDao.petitionListCount(map);
  
		int maxPage = (int)(totalList/10.0+0.9);  
		int startPage = (int)(spage/5.0+0.8)*5-4;  
		int endPage= startPage+4; 
		if(endPage > maxPage) endPage = maxPage; 
 
		request.setAttribute("spage", spage);
		request.setAttribute("maxPage", maxPage);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		request.setAttribute("list", list);

		return new ModelAndView("petition/evaluate");
	} 
	
	@RequestMapping("/AnswerList") // 심사완료된 청원
	public ModelAndView accept(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		 
		HashMap<String, Object> map = new HashMap<String,Object>(); 
		map.put("sort","answer");
		
		int totalList = 0;
		int spage = 1;
		
		if(request.getParameter("page") != null) 
			spage = Integer.parseInt( request.getParameter("page") );
		
		int start =spage*10-9;
		
		map.put("start",start-1);
		  
		List<PetitionDto> list = petitionDao.answerList(map);
		
		if(request.getParameter("src") !=null) { 
			String src = request.getParameter("src");
			String search = request.getParameter("search");
			request.setAttribute("src", src);
			request.setAttribute("search", search);
			map.put("src",src);
			map.put("search",search);
			list = petitionDao.answerList(map);
			
			totalList = list.size();
		}
		
		totalList = petitionDao.petitionListCount(map);
  
		int maxPage = (int)(totalList/10.0+0.9);  
		int startPage = (int)(spage/5.0+0.8)*5-4;  
		int endPage= startPage+4; 
		if(endPage > maxPage) endPage = maxPage; 
 
		request.setAttribute("spage", spage);
		request.setAttribute("maxPage", maxPage);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		request.setAttribute("list", list);

		return new ModelAndView("petition/answer");
	} 
	
	@RequestMapping("/ManageList") // 관리자 청원
	public ModelAndView manage(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		 
		HashMap<String, Object> map = new HashMap<String,Object>(); 
		List<PetitionDto> list; 
		
		int totalList = 0;
		int spage = 1;
		
		if(request.getParameter("page") != null) 
			spage = Integer.parseInt( request.getParameter("page") );
		
		int start =spage*10-9;
		
		map.put("start",start-1);
		
		if(request.getParameter("sort") != null ) {
			map.put("sort","evaluate");
			list = petitionDao.evaluateList(map);	 
			request.setAttribute("sort", "1");
		}
		else 
			list = petitionDao.allList(map);
		
		
		if(request.getParameter("src") !=null) { 
			String src = request.getParameter("src");
			String search = request.getParameter("search");
			request.setAttribute("src", src);
			request.setAttribute("search", search);
			map.put("src",src);
			map.put("search",search);
			
			if(request.getParameter("sort") != null ) {
				list = petitionDao.evaluateList(map);
			}else 
				list = petitionDao.allList(map);
			
			totalList = list.size();
		}
		
		totalList = petitionDao.petitionListCount(map);
		
		int maxPage = (int)(totalList/10.0+0.9);  
		int startPage = (int)(spage/5.0+0.8)*5-4;  
		int endPage= startPage+4; 
		if(endPage > maxPage) endPage = maxPage; 
 
		request.setAttribute("spage", spage);
		request.setAttribute("maxPage", maxPage);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		request.setAttribute("list", list);
		return new ModelAndView("petition/manageList");
	} 
	
	
	@RequestMapping("/ReplyWrite") // 관리자 답변 작성 페이지
	public ModelAndView replyWrite(HttpServletRequest request, HttpServletResponse response)  throws Throwable {  
		 
		int petition_no = Integer.parseInt( request.getParameter("petition_no") );
		String list = request.getParameter("list");
		
		PetitionDto petitionDto = petitionDao.petitionDetail(petition_no);
		
		String content = ( petitionDto.getContent()).replace("\r\n", "<br>" );
		
		request.setAttribute("content",content);
		request.setAttribute("list",list);
		request.setAttribute("result", petitionDto);  
	
		return new ModelAndView("petition/replyWrite");
	}
	
	@RequestMapping("/ReplyWritePro")
	public String replyWritePro(HttpServletRequest request, HttpServletResponse response)  throws Throwable {  
		 
		int petition_no = Integer.parseInt( request.getParameter("petition_no") ); 
		String category = request.getParameter("category");
		 
		PetitionDto petitionDto = new PetitionDto();
		petitionDto.setPetition_no(petition_no);
		petitionDto.setComment(request.getParameter("comment")); 
		
		petitionDao.replyWrite(petitionDto);
		
		if (category.equals("Y")) {
			petitionDao.acceptUpdate(petition_no);  // 채택
		}else {
			petitionDao.refusalUpdate(petition_no); // 거부
		}
 
		return "redirect:ManageList.do"; 
	}
	
}
