package com.es.handler;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.es.education.EduHistoryDao;
import com.es.education.EduHistoryDto;

@Controller
public class EducationHandler {
	
	/* 나현 - 수강목록  */
	@Resource
	private EduHistoryDao eduhistoryDao;
	
	@RequestMapping("/eduhistory")
	public String eduHistory(Model model, HttpSession session) throws IOException {
		/* 세션 테스트 */
		session.setAttribute("account", "E2018040001");
		String account = (String) session.getAttribute("account");

		/* 직원의 전체 수강내역 리스트 */
		List<EduHistoryDto> eduhistory_list = eduhistoryDao.eduHistoryList(account);
		model.addAttribute("eduhistory_list", eduhistory_list);
		Date date = new Date();
		model.addAttribute("date", date); //현재 날짜
		 
		return "edu_history/main";
	}
	/* 나현 - 수강목록 끝 */
	
	/* 나현 - 수강목록 中 한 강의 선택했을 시 (해당 강의 상세정보) */
	@RequestMapping(value = "/eduhistory/detail")
	public String eduHistoryDetail(Model model, HttpSession session, @RequestParam("edu_no") int no ) 
			throws ParseException, UnsupportedEncodingException{
		//select box로 보여줄 직원의 수강목록
		String account = (String) session.getAttribute("account");
		List<EduHistoryDto> eduhistory_list = eduhistoryDao.eduHistoryList(account);
		model.addAttribute("eduhistory_list", eduhistory_list);
		
		//해당 edu_no에 관한 커리큘럼 등 상세정보
		EduHistoryDto eduhistory_detail = eduhistoryDao.eduHistoryDetail(no);
		model.addAttribute("eduhistory_detail", eduhistory_detail);

		//---json data (교육대상)
		String target = new String(eduhistory_detail.getEdu_target().getBytes("ISO-8859-1"), "UTF-8"); //한글 인코딩
		
		// String을 JSON으로 파싱
		JSONParser jsonParser = new JSONParser();

		JSONArray arr = (JSONArray) jsonParser.parse(target);

		//----- 형변환 잘 되었는지 확인  ------
		if( arr instanceof JSONArray) {
			//System.out.println("arr은 JSONArray 입니다.");
		} else {
			System.out.println("arr은 문자열");
		}
		//-----------------------------

		String aaa = "";
		for(int i=0; i<arr.size(); i++) {
			JSONObject tmp = (JSONObject)arr.get(i);

			String dept_name = (String)tmp.get("dept_name");
			String belong_name  = (String)tmp.get("belong_name");
			String position_name = (String)tmp.get("position_name");

			aaa += belong_name + "사업부 - " + dept_name + "   직급: " + position_name + "<br>";

		}
		System.out.println("강의 대상(target) : " + aaa);
		model.addAttribute("edu_target", aaa);
		return "edu_history/detail";
	}
	
	/* 나현 - 강의자료 다운받기(상세페이지 내에서) */
	@RequestMapping("/eduhistory/eduHistoryFile")
	public void eduHistoryFileDownload(Model model, @RequestParam("edu_no") int no,
				HttpServletRequest req, HttpServletResponse res) throws IOException {
		EduHistoryDto eduhistory_detail = eduhistoryDao.eduHistoryDetail(no);
		
		//파일 : 주현언니 community의  ProjectFileDownload 서블릿 참고
		String path = eduhistory_detail.getFile_path();
		String file_ori_name = new String(eduhistory_detail.getFile_ori_name().getBytes("UTF-8"), "ISO-8859-1");
		
		/*String path = request.getParameter("path");*/
		File file = new File(path);
		
		/*response.setContentType(getContentType()); */
		res.setContentLength((int)file.length());
		
		System.out.println("file_path : " + eduhistory_detail.getFile_path());
		System.out.println("file_save_name : " + eduhistory_detail.getFile_save_name());
		System.out.println("file.getName() : " + file.getName());
		
		res.setHeader("Content-Disposition", "attachment; filename=\""+file_ori_name+"\";");
		res.setHeader("Content-Transfer-Encoding", "binary");
		
		OutputStream out = res.getOutputStream();
		FileInputStream fis = null;
		
		
		fis = new FileInputStream(file);
		FileCopyUtils.copy(fis, out);
		
		if(fis != null) {
			fis.close();
		}
		out.flush();
	}
	
	
	/* 나현 - 강의평가 페이지*/
	@RequestMapping("/eduhistory/emp_eval")
	public String empEval(Model model, @RequestParam("edu_no") int no) {
		EduHistoryDto eduhistory_detail = eduhistoryDao.eduHistoryDetail(no);
		model.addAttribute("eduhistory_detail", eduhistory_detail);
		
		return "edu_history/emp_eval";
	}
	
	/* 나현 - 강의평가 제출 */
	@RequestMapping(value="/eduhistory/write_emp_eval", method=RequestMethod.POST)
	public @ResponseBody String WriteEmpEval(Model model, @RequestParam("edu_no") int no, 
								@RequestParam("emp_eval") String emp_eval,
								HttpServletResponse response) throws Exception {
		System.out.println("교육번호:" +no + ", 강의평가란 : " + emp_eval);
		
		// 비지니스 로직
		int result = eduhistoryDao.insertEmpEval(no, emp_eval);
		System.out.println("result:" + result);
		
		//window창 닫고 페이지 reload (view단에서 적용되지 않아 java단에서 처리)
		String command = "<script>";
		command += "window.close();";
		command += "window.opener.location.reload();";
		command += "</script>";
		
		return command;
	}
}
