package com.es.handler;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.List;
import java.util.Locale;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;

import com.es.instructor.InstructorDao;
import com.es.instructor.InstructorDto;


@Controller
@RequestMapping("/instructor")
public class InstructorHandler {

	@Resource
	private InstructorDao instructorDao;
	
	String file_path = "C:\\ExpressJava\\workspace\\EducationSystem\\WebContent\\inst_req\\img\\"; 
	
	
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String home(Locale locale, Model model) throws Exception {
		System.out.println("instructor/main");
		/*String id = "test1234";
		String account_no = instructorDao.selectAccountNo(id);
		System.out.println("account_no : " + account_no);
		System.out.println(account_no.substring(0, 1));*/
		
		String account_no = "E2018040001";
		//직원일 경우
		if(account_no.substring(0, 1).equals("E")) {
			String instructor_check = instructorDao.selectInstructorCheck(account_no);
			System.out.println("instructor_check : " + instructor_check);
			//강사 신청 X
			if(instructor_check.equals("0")) {
				System.out.println( "instructor_no X ");
				model.addAttribute("result", "강사만 이용가능한 페이지입니다.");
				model.addAttribute("instructor_no", "null");
				model.addAttribute("account_no", account_no);
			//강사 신청 O
			}else {
				List<InstructorDto> InstructorDto = instructorDao.selectInstructorNo(account_no);
				String instructor_no = InstructorDto.get(0).getInstructor_no();
				String inproval_state = String.valueOf(InstructorDto.get(0).getApproval_state());
				//강사 승인 O
				if(inproval_state.equals("3")) {
					model.addAttribute("account_no", account_no);
					model.addAttribute("instructor_no", instructor_no);
					model.addAttribute("inproval_state", inproval_state);
					System.out.println("instructor_no : " + instructor_no + "강사권한 O");
					System.out.println("inproval_state : " + inproval_state);
					EduList(instructor_no, model);
				//강사 승인 X
				}else {
					model.addAttribute("instructor_no", instructor_no);
					model.addAttribute("inproval_state", inproval_state);
				}
			}
		//직원이 아닐 경우(외부강사일 경우)
		}else {
			model.addAttribute("inproval_state", "3");
			model.addAttribute("instructor_no", account_no);
			System.out.println("�������");
			EduList(account_no, model);
			
			/*for(int i = 0; i<InstructorDto.size(); i++) {
				InstructorDto instructor= InstructorDto.get(i);
				System.out.println(instructor.getEdu_no() + " / " + instructor.getEdu_field() + " / " + instructor.getEdu_name());
			}*/
		}
		List<InstructorDto> InstructorDto2 = instructorDao.selectEduList(account_no);
		String encode_result = null;
		for(int i = 0; i<InstructorDto2.size(); i++) {
			InstructorDto instructor= InstructorDto2.get(i);
			String target = instructor.getEdu_target();
			/*JSONArray arr = new JSONArray(target);*/
			
			String b = null;
			try {
				b = new String(instructor.getEdu_target().getBytes("ISO-8859-1"), "UTF-8");
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			System.out.println("타겟 : " + b);
			model.addAttribute("target", b);
			
		}
		return "inst_req/main";
	}
	
	private void EduList(String account_no, Model model) {
		List<InstructorDto> InstructorDto1 = instructorDao.selectEduReq(account_no);
		List<InstructorDto> InstructorDto2 = instructorDao.selectEduList(account_no);
		System.out.println("EduList");
		
		model.addAttribute("result1", InstructorDto1);
		model.addAttribute("result2", InstructorDto2);
		
	}

	@RequestMapping(value = "/inst_req", method = RequestMethod.GET)
	public String InstReq(@RequestParam("account_no") String account_no, Locale locale, Model model) throws Exception{
		System.out.println("InstReq Account_no : " + account_no);
		String empName = instructorDao.selectEmployeesName(account_no);
		System.out.println("empName : " + empName);
		InstructorDto InstructorDto = new InstructorDto();
		InstructorDto.setEmp_no(account_no);
		InstructorDto.setName(empName);
		int result = instructorDao.insertInstReq(InstructorDto);
		model.addAttribute("result", result);
		System.out.println("�����û���  : " + result );
		return "inst_req/instReqPro";
	}
	
	@RequestMapping(value = "/edu_req", method = RequestMethod.GET)
	public String EduReq(@RequestParam("instructor_no") String instructor_no, Locale locale, Model model) throws Exception{
		model.addAttribute("instructor_no", instructor_no);
		
		
		List<InstructorDto> edu_code = instructorDao.selectEduCode();
		List<InstructorDto> belong_no = instructorDao.selectBelongNo();
		List<InstructorDto> instructor = instructorDao.selectInstructor();
		List<InstructorDto> position = instructorDao.selectPosition();
		
		model.addAttribute("edu_code", edu_code);
		model.addAttribute("belong_no", belong_no);
		model.addAttribute("instructor", instructor);
		model.addAttribute("position", position);
		
		return "inst_req/eduReqFrom";
	}
	
	@ResponseBody
	@RequestMapping(value = "/belong", method = RequestMethod.GET)
	public List<InstructorDto> Belong(@RequestParam("belong_no") String belong_no, Locale locale, Model model) throws Exception{
		System.out.println("instructor/belong");
		List<InstructorDto> department = instructorDao.selectDepartment(belong_no);  
		for(int i = 0; i<department.size(); i++) {
			InstructorDto dept= department.get(i);
			System.out.println(dept.getDept_no() + " / " + dept.getDept_name() + " / " + dept.getBelong_no());
		}
		return department;
	}
	
	
	@RequestMapping(value = "/eduReq", method = RequestMethod.POST)
	public String EduReg(HttpServletRequest request, HttpServletResponse response, Model model,@RequestParam("file_name") MultipartFile file) throws Exception{
		String file_ori_name = file.getOriginalFilename();
		String file_save_name = uploadFile(file_ori_name, file.getBytes());
		File f = new File(file_path+file.getOriginalFilename());
	    file.transferTo(f);
	    System.out.println("file_ori_name : " + file_ori_name + " / "+"file_save_name" + file_save_name);
		
		String edu_code = request.getParameter("edu_code");
		String belong_no = request.getParameter("belong_no");
		String edu_field = request.getParameter("edu_field");
		String edu_name = request.getParameter("edu_name");
		String edu_way = request.getParameter("edu_way");
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		String edu_date = request.getParameter("edu_date");
		String input_time = request.getParameter("input_time");
		String closing_date = request.getParameter("closing_date");
		String edu_location = request.getParameter("edu_location");
		String instructor_no = request.getParameter("instructor_no");
		String manager = request.getParameter("manager");
		String budget = request.getParameter("budget");
		String note = request.getParameter("note");
		String applicants_limit = request.getParameter("applicants_limit");
		String file_name = request.getParameter("file_name");
		
		System.out.println(edu_code + '/'+ belong_no + '/'+ edu_field + '/'+ edu_name + '/'+ edu_way + '/'+ startDate 
				+ '/'+ endDate + '/'+ edu_date + '/'+ input_time + '/'+ closing_date + '/'+ edu_location + '/'+ instructor_no 
				+ '/'+ manager + '/'+ budget + '/'+ note + '/'+ applicants_limit + '/' + file_name);
		String[] select1 = request.getParameterValues("select1");
		int length = select1.length;
		String[] belong_no1 = new String[length];
		String[] belong_name = new String[length];
		String[] dept_no = new String[length];
		String[] dept_name = new String[length];
		String[] position_no = new String[length];
		String[] position_name = new String[length];
		
		JSONArray arr = new JSONArray();
		JSONObject obj = new JSONObject();
		for(int i=0; i<select1.length; i++) {
			int idx1 = select1[i].indexOf("!");
			int idx2 = select1[i].indexOf("@");
			int idx3 = select1[i].indexOf("#");
			int idx4 = select1[i].indexOf("$");
			int idx5 = select1[i].indexOf("%");
			belong_no1[i] = select1[i].substring(0, idx1);
			belong_name[i] = select1[i].substring(idx1+1, idx2);
			dept_no[i] = select1[i].substring(idx2+1, idx3);
			dept_name[i] = select1[i].substring(idx3+1, idx4);
			position_no[i] = select1[i].substring(idx4+1, idx5);
			position_name[i] = select1[i].substring(idx5+1, select1[i].length());
			obj.put("belong_no", belong_no1[i]);
			obj.put("belong_name", belong_name[i]);
			obj.put("dept_no", dept_no[i]);
			obj.put("dept_name", dept_name[i]);
			obj.put("position_no", position_no[i]);
			obj.put("position_name", position_name[i]);
			/*arr.add(obj);*/
			arr.put(obj);
		}
		System.out.println("target : " + arr.toString());
		InstructorDto instructorDto = new InstructorDto();
		instructorDto.setEdu_code(Integer.parseInt(edu_code));
		instructorDto.setBelong_no(Integer.parseInt(belong_no));
		instructorDto.setEdu_field(edu_field);
		instructorDto.setEdu_name(edu_name);
		instructorDto.setEdu_way(edu_way);
		instructorDto.setEdu_schedule(startDate+"~"+endDate);
		instructorDto.setStart_date(startDate);
		instructorDto.setEnd_date(endDate);
		instructorDto.setEdu_date(edu_date);
		instructorDto.setInput_time(Integer.parseInt(input_time));
		instructorDto.setClosing_date(closing_date);
		instructorDto.setEdu_location(edu_location);
		instructorDto.setInstructor_no(instructor_no);
		instructorDto.setManager(manager);
		instructorDto.setEdu_target(arr.toString());
		instructorDto.setBudget(budget);
		instructorDto.setNote(note);
		instructorDto.setApplicants_limit(Integer.parseInt(applicants_limit));
		instructorDto.setFile_ori_name(file_ori_name);
		instructorDto.setFile_save_name(file_save_name);
		instructorDto.setFile_path(file_path);;
		
		int result = instructorDao.insertEduReq(instructorDto);
		int result2 = instructorDao.insertEduReqDetail(instructorDto);
		
		return "redirect:/instructor/main.do";
	}
	private String uploadFile(String originalName, byte[] fileData) throws Exception{
        // uuid 생성(Universal Unique IDentifier, 범용 고유 식별자)
        UUID uuid = UUID.randomUUID();
        // 랜덤생성+파일이름 저장
        String savedName = uuid.toString()+"_"+originalName;
        File target = new File(file_path, savedName);
        // 임시디렉토리에 저장된 업로드된 파일을 지정된 디렉토리로 복사
        // FileCopyUtils.copy(바이트배열, 파일객체)
        FileCopyUtils.copy(fileData, target);
        return savedName;
    }
	
	@RequestMapping(value = "/eduDetail", method = RequestMethod.GET)
	public String eduDatil(@RequestParam("edu_no") String edu_no, Model model) throws Exception{
		System.out.println("edu_no : " + edu_no);
		List<InstructorDto> edu_list = instructorDao.selectEduList2(edu_no);
		List<InstructorDto> edu_detail = instructorDao.selectEduDetail(edu_no);
		
		for(int i = 0; i<edu_list.size(); i++) {
			InstructorDto edu_list2 = edu_list.get(i);
			System.out.println(edu_list2.getEdu_no() + " / " + edu_list2.getBelong_no() + " / " + edu_list2.getEdu_field() + " / " + edu_list2.getEdu_way() + " / ");
			String b = null;
			try {
				b = new String(edu_list2.getEdu_target().getBytes("ISO-8859-1"), "UTF-8");
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			System.out.println("교육대상 : " + b);
			JSONArray arr = new JSONArray(b);
			String[] belong_name = new String[arr.length()];
			String[] dept_name = new String[arr.length()];
			String[] position_name = new String[arr.length()];
			for(int i1 = 0; i1 < arr.length(); i1++) {
				JSONObject obj = arr.getJSONObject(i1);
				belong_name[i1] = obj.getString("belong_name");
				dept_name[i1] = obj.getString("dept_name");
				position_name[i1] = obj.getString("position_name");
				System.out.println(belong_name[i1] + " / " + dept_name[i1] + " / " + position_name[i1] );
			}
			model.addAttribute("belong_name", belong_name);
			model.addAttribute("dept_name", dept_name);
			model.addAttribute("position_name", position_name);
			
		}
		/*for(int i = 0; i<edu_detail.size(); i++) {
			InstructorDto edu_list2 = edu_detail.get(i);
			System.out.println( "education_detail : " + edu_list2.getFile_path() + " / " + edu_list2.getFile_ori_name() + " / " + edu_list2.getFile_save_name() + " / ");
		}*/
		model.addAttribute("edu_list", edu_list);
		model.addAttribute("edu_detail", edu_detail);
		model.addAttribute("edu_no", edu_no);
		
		
		//수강자목록 조회
		List<InstructorDto> edu_history = instructorDao.selectEduHistory(edu_no);
		model.addAttribute("edu_history", edu_history);
		return "inst_req/eduDetail";
	}
	
	@RequestMapping(value = "/fileDown", method = RequestMethod.GET)
	public void FileDown(@RequestParam("edu_no") String edu_no, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception{
		List<InstructorDto> file_info = instructorDao.selectEduDetail(edu_no);
		String file_path = file_info.get(0).getFile_path();
		String file_ori_name = file_info.get(0).getFile_ori_name();
		String file_save_name = file_info.get(0).getFile_save_name();
		String fileName = null;
		System.out.println(file_path);
		System.out.println(file_ori_name);
		System.out.println(file_save_name);
		
		String header = request.getHeader("User-Agent");
		
		if (header.contains("MSIE") || header.contains("Trident")) {        // 익스플로러의 경우 한글처리
			fileName = URLEncoder.encode(file_ori_name.toString(),"UTF-8").replaceAll("\\+", "%20");
	    } else {                                                            // 익스플로러 이외 한글처리
	    	fileName = new String(file_ori_name.getBytes("utf-8"), "ISO-8859-1");
	    }
		File file = new File(file_path+file_ori_name);
		response.reset();
		response.setContentType("application/octer-stream");
		response.setHeader("Content-Disposition", "attachment;filename=" + fileName + "");
		response.setHeader("Content-Transper-Encoding", "binary");
		response.setContentLength((int) file.length());                // 파일 사이즈 설정
	    
	    response.setHeader("Pargma", "no-cache");
	    
	    response.setHeader("Expires", "-1");
	 
	    byte[] data = new byte[2048];
	    FileInputStream fis = new FileInputStream(file);
	    
	    BufferedInputStream bis = new BufferedInputStream(fis);
	     
	    BufferedOutputStream fos = new BufferedOutputStream(response.getOutputStream());
	 
	    int count = 0;
	    while ((count = bis.read(data)) != -1) {
	        fos.write(data,0,count);
	    }
	 
	    if (fis != null)
	        fis.close();
	    if (bis != null)
	        bis.close();
	    if (fos != null)
	        fos.close();

	}
	
	@RequestMapping(value = "/eduModify", method = RequestMethod.GET)
	public String eduModify(@RequestParam("edu_no") String edu_no, Model model) throws Exception{
		model.addAttribute("edu_no", edu_no);
		List<InstructorDto> edu_code = instructorDao.selectEduCode();
		List<InstructorDto> belong_no = instructorDao.selectBelongNo();
		List<InstructorDto> instructor = instructorDao.selectInstructor();
		List<InstructorDto> position = instructorDao.selectPosition();
		List<InstructorDto> edu_list = instructorDao.selectEduList2(edu_no);
		List<InstructorDto> edu_detail = instructorDao.selectEduDetail(edu_no);
		
		for(int i = 0; i<edu_detail.size(); i++) {
			InstructorDto edu_list2 = edu_detail.get(i);
			edu_detail.get(0).setStart_date(edu_list2.getStart_date().substring(0, 10).replace("-", ".")); 
			edu_detail.get(0).setEnd_date(edu_list2.getEnd_date().substring(0, 10).replace("-", ".")); 
		}
		for(int i = 0; i<edu_list.size(); i++) {
			InstructorDto edu_list1 = edu_list.get(i);
			edu_list.get(0).setClosing_date(edu_list1.getClosing_date().substring(0, 10).replace("-", ".")); 
		}
		
		model.addAttribute("edu_code", edu_code);
		model.addAttribute("belong_no", belong_no);
		model.addAttribute("instructor", instructor);
		model.addAttribute("position", position);
		model.addAttribute("edu_list", edu_list);
		model.addAttribute("edu_detail", edu_detail);
		
		return "inst_req/eduModify";
	}
	
	@RequestMapping(value = "/eduModify", method = RequestMethod.POST)
	public String EduModify(HttpServletRequest request, HttpServletResponse response, Model model,@RequestParam("file_name") MultipartFile file) throws Exception{
		
		String file_ori_name = file.getOriginalFilename();
		String file_save_name = uploadFile(file_ori_name, file.getBytes());
		File f = new File(file_path+file.getOriginalFilename());
	    file.transferTo(f);
	    System.out.println("file_ori_name : " + file_ori_name + " / "+"file_save_name" + file_save_name);
		String edu_way = request.getParameter("edu_way");
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		String edu_date = request.getParameter("edu_date");
		String input_time = request.getParameter("input_time");
		String closing_date = request.getParameter("closing_date");
		String edu_location = request.getParameter("edu_location");
		String budget = request.getParameter("budget");
		String note = request.getParameter("note");
		String applicants_limit = request.getParameter("applicants_limit");
		/*String file_name = request.getParameter("file_name");*/
		
		System.out.println(edu_way + '/'+ startDate 
				+ '/'+ endDate + '/'+ edu_date + '/'+ input_time + '/'+ closing_date + '/'+ edu_location + '/'+ budget + '/'+ note + '/'+ applicants_limit );
		String[] select1 = request.getParameterValues("select1");
		int length = select1.length;
		String[] belong_no1 = new String[length];
		String[] belong_name = new String[length];
		String[] dept_no = new String[length];
		String[] dept_name = new String[length];
		String[] position_no = new String[length];
		String[] position_name = new String[length];
		
		JSONArray arr = new JSONArray();
		JSONObject obj = new JSONObject();
		for(int i=0; i<select1.length; i++) {
			int idx1 = select1[i].indexOf("!");
			int idx2 = select1[i].indexOf("@");
			int idx3 = select1[i].indexOf("#");
			int idx4 = select1[i].indexOf("$");
			int idx5 = select1[i].indexOf("%");
			belong_no1[i] = select1[i].substring(0, idx1);
			belong_name[i] = select1[i].substring(idx1+1, idx2);
			dept_no[i] = select1[i].substring(idx2+1, idx3);
			dept_name[i] = select1[i].substring(idx3+1, idx4);
			position_no[i] = select1[i].substring(idx4+1, idx5);
			position_name[i] = select1[i].substring(idx5+1, select1[i].length());
			obj.put("belong_no", belong_no1[i]);
			obj.put("belong_name", belong_name[i]);
			obj.put("dept_no", dept_no[i]);
			obj.put("dept_name", dept_name[i]);
			obj.put("position_no", position_no[i]);
			obj.put("position_name", position_name[i]);
			/*arr.add(obj);*/
			arr.put(obj);
		}
		System.out.println("target : " + arr.toString());
		InstructorDto instructorDto = new InstructorDto();
		instructorDto.setEdu_no(Integer.parseInt(request.getParameter("edu_no")));
		instructorDto.setEdu_way(edu_way);
		instructorDto.setEdu_schedule(startDate+"~"+endDate);
		instructorDto.setStart_date(startDate);
		instructorDto.setEnd_date(endDate);
		instructorDto.setEdu_date(edu_date);
		instructorDto.setInput_time(Integer.parseInt(input_time));
		instructorDto.setClosing_date(closing_date);
		instructorDto.setEdu_location(edu_location);
		instructorDto.setEdu_target(arr.toString());
		instructorDto.setBudget(budget);
		instructorDto.setNote(note);
		instructorDto.setApplicants_limit(Integer.parseInt(applicants_limit));
		instructorDto.setFile_ori_name(file_ori_name);
		instructorDto.setFile_save_name(file_save_name);
		instructorDto.setFile_path(file_path);;
		
		int result = instructorDao.modifyEdu(instructorDto);
		int result2 = instructorDao.modifyEduDetail(instructorDto);
		
		return "redirect:/instructor/eduDetail.do?edu_no="+request.getParameter("edu_no");
		
	}
	
	@RequestMapping(value = "/inst_eval", method = RequestMethod.GET)
	public String InstEval(@RequestParam("edu_no") String edu_no, Model model) throws Exception{
		System.out.println("/inst_eval");
		return "inst_req/instEval";
	}
}
