package com.es.education;

import java.util.HashMap;
import java.util.List;

public interface EduListDao {
	
	
	public List<EducationListDto> EducationList(HashMap<String, Object> map);
	public int EducationListCount(HashMap<String, Object> map);
	public EducationListDto EducationListDetail(int edu_no);
	public int EducationApplicants(int edu_no);
	public int EducationApplication(HashMap<String, Object> map);
	
	
}
