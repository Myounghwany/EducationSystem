package com.es.handler;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;

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
import org.springframework.web.multipart.MultipartFile;

import com.es.instructor.InstructorDao;
import com.es.instructor.InstructorDto;
import com.es.manager.EduListDto;
import com.es.manager.ManagerEduDao;
import com.es.manager.PagingDto;

@Controller
public class ManagerEduHandler {
	@Resource
	ManagerEduDao managerEduDao;
	
	@Resource
	InstructorDao instructorDao;	

	/* 나현 - 교육목록 - 교육리스트 */
	@RequestMapping(value="manage/eduList")
	public String eduList(Model model, HttpServletRequest request, HttpServletRequest response) {
		//paging 로직
		PagingDto pageDao = new PagingDto();
		int totalCount = managerEduDao.count();
		int page = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));
		pageDao.setPageNo(page); //1
		pageDao.setPageSize(7); //7
		pageDao.setTotalCount(totalCount); 
		page = (page-1) * pageDao.getPageSize() + 1;

		//검색하기 로직
		
		String search_belong = null, search_edu_code = null, search_manager = null, keyword = null;
		if(null != request.getParameter("search_belong")
				|| null != request.getParameter("search_edu_code")
				|| null != request.getParameter("search_manager")) {
			search_belong = request.getParameter("search_belong");
			search_edu_code = request.getParameter("search_edu_code");
			search_manager = request.getParameter("search_manager");
			keyword = request.getParameter("keyword");
			request.setAttribute("search_belong", search_belong);
			request.setAttribute("search_edu_code", search_edu_code);
			request.setAttribute("search_manager", search_manager);
			request.setAttribute("keyword", keyword);
		}
		
		List<EduListDto> eduList = managerEduDao.eduList(page, pageDao.getPageSize());
		model.addAttribute("eduList", eduList);

		if(keyword != null) {
			System.out.println("search_belong : " + search_belong +"\n" + "keyword : " + keyword);
			System.out.println("search_edu_code : " + search_edu_code +"\n" + "keyword : " + keyword);
			System.out.println("search_manager : " + search_manager +"\n" + "keyword : " + keyword);
//			eduList = managerEduDao.searchAll(searchOption, keyword);
			model.addAttribute("eduList", eduList);
		}
		
		List<InstructorDto> belong = instructorDao.selectBelongNo();
		List<InstructorDto> edu_code = instructorDao.selectEduCode();
		List<InstructorDto> instructor = instructorDao.selectInstructor();
		
		model.addAttribute("belong", belong);
		model.addAttribute("edu_code", edu_code);
		model.addAttribute("instructor", instructor);
		model.addAttribute("paging", pageDao);
		model.addAttribute("totalCount", totalCount);
		return "manage/eduList";
	}
	
	/* 나현 - 교육목록 - 교육디테일*/
	@RequestMapping(value="manage/edu_detail", method = RequestMethod.GET, produces="application/json")
	@ResponseBody
	public Map<String, Object> eduDetail(Model model, HttpSession session, @RequestParam("edu_no") int edu_no) throws ParseException, UnsupportedEncodingException {
		System.out.println("해당 edu_no : " + edu_no);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		EduListDto eduListDetail = managerEduDao.eduListDetail(edu_no);
		
		System.out.println(" 소속명 : " + eduListDetail.getBelong_name());
		System.out.println(" 교육코드명 : " + eduListDetail.getEdu_code_name());
		System.out.println(" 교육명 : " + eduListDetail.getEdu_name());
		System.out.println(" 교육일정 : " + eduListDetail.getEdu_schedule());
		System.out.println(" 소속번호 : " + eduListDetail.getBelong_no());
		System.out.println(" 소요예산 : " + eduListDetail.getBudget());
		System.out.println(" 신청마감일 : " + eduListDetail.getClosing_date());
		System.out.println(" 교육코드 : " + eduListDetail.getEdu_code());
		System.out.println(" 교육일시 : " + eduListDetail.getEdu_date());
		System.out.println(" 교육뷴야 : " + eduListDetail.getEdu_field());
		System.out.println(" 교육장소 : " + eduListDetail.getEdu_location());
		System.out.println(" 교육대상 : " + eduListDetail.getEdu_target());
		System.out.println(" 교육방법 : " + eduListDetail.getEdu_way());
		System.out.println(" 강사이름 : " + eduListDetail.getInstructor_name());
		System.out.println(" 강사번호 : " + eduListDetail.getInstructor_no());
		System.out.println(" 담당자 : " + eduListDetail.getManager());
		System.out.println(" 비고 : " + eduListDetail.getNote());

		//---json data (교육대상)
		String target = new String(eduListDetail.getEdu_target().getBytes("ISO-8859-1"), "UTF-8"); //한글 인코딩

		// String을 JSON으로 파싱
		JSONParser jsonParser = new JSONParser();

		JSONArray arr = (JSONArray) jsonParser.parse(target);

		String aaa = "";
		for(int i=0; i<arr.size(); i++) {
			JSONObject tmp = (JSONObject)arr.get(i);

			String dept_name = (String)tmp.get("dept_name");
			String belong_name  = (String)tmp.get("belong_name");
			String position_name = (String)tmp.get("position_name");

			aaa += belong_name + "사업부 - " + dept_name + "   직급: " + position_name + "<br>";

		}
		System.out.println("강의 대상(target) : " + aaa);
		model.addAttribute("edu_no", eduListDetail.getEdu_no());
		resultMap.put("edu_target", aaa); //강의대상
		resultMap.put("edu_no", eduListDetail.getEdu_no());
		resultMap.put("belong_no", eduListDetail.getBelong_no());
		resultMap.put("belong_name", eduListDetail.getBelong_name());
		resultMap.put("edu_name", eduListDetail.getEdu_name());
		resultMap.put("edu_schedule", eduListDetail.getEdu_schedule());
		resultMap.put("budget", eduListDetail.getBudget());
		resultMap.put("closing_date", eduListDetail.getClosing_date());
		resultMap.put("edu_code", eduListDetail.getEdu_code());
		resultMap.put("edu_code_name", eduListDetail.getEdu_code_name());
		resultMap.put("edu_date", eduListDetail.getEdu_date());
		resultMap.put("edu_feild", eduListDetail.getEdu_field());
		resultMap.put("edu_location", eduListDetail.getEdu_location());
		resultMap.put("edu_way", eduListDetail.getEdu_way());
		resultMap.put("instructor_name", eduListDetail.getInstructor_name());
		resultMap.put("instructor_no", eduListDetail.getInstructor_no());
		resultMap.put("manager", eduListDetail.getManager());
		resultMap.put("note", eduListDetail.getNote());
		return resultMap;
	}
	
	/*교육목록 - 강의계획서 수정 페이지 이동*/
	@RequestMapping(value="manage/eduModify")
	public String eduModify(@RequestParam("edu_no") String edu_no, @RequestParam("manager_no") String manager_no,
				Model model) throws Exception {
		System.out.println("수정할 강의계획서 edu_no : " + edu_no + "세션no: "+ manager_no);
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
		model.addAttribute("instructor_no", manager_no);
		
		model.addAttribute("edu_no", edu_no);

		return "manage/eduModify";
	}
	
	@ResponseBody
	@RequestMapping(value = "manage/belong", method = RequestMethod.GET)
	public List<InstructorDto> Belong(@RequestParam("belong_no") String belong_no, Locale locale, Model model) throws Exception{
		System.out.println("manage/belong");
		List<InstructorDto> department = instructorDao.selectDepartment(belong_no);
		System.out.println("department:" + department);
		for(int i = 0; i<department.size(); i++) {
			InstructorDto dept= department.get(i);
			System.out.println(dept.getDept_no() + " / " + dept.getDept_name() + " / " + dept.getBelong_no());
		}
		return department;
	}
	
	/* 파일 업로드 */
	private String uploadFile(String file_path, String originalName, byte[] fileData) throws Exception{
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
	
	/*교육목록 - 강의계획서 수정 로직*/
	@RequestMapping(value = "manage/eduModify", method = RequestMethod.POST)
	public String EduModify(HttpServletRequest request, HttpServletResponse response, @RequestParam("file_name") MultipartFile file) throws Exception{
		String file_ori_name = file.getOriginalFilename();
		String file_path = null;
		String file_save_name = null;
		
		if(file_ori_name.length() != 0) {
			file_path = request.getServletContext().getRealPath("/save");
			file_save_name = uploadFile(file_path, file_ori_name, file.getBytes());
			File dir = new File(file_path);
			if(!dir.isDirectory()) {
				dir.mkdirs();
			}
			File f = new File(file_path+file.getOriginalFilename());
			file.transferTo(f);			
			System.out.println("file_ori_name : " + file_ori_name + " / "+"file_save_name : " + file_save_name);
		}
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
		for(int i=0; i<select1.length; i++) {
			JSONObject obj = new JSONObject();
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
			arr.add(obj);
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
		
		return "redirect:/manage/eduList.do";
	}
	
}
