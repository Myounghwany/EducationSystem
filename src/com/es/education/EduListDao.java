package com.es.education;

import java.util.HashMap;
import java.util.List;

public interface EduListDao {
	public List<EduListDto> eduList();
	
	
	public List<EducationListDto> EducationList();
	public EducationListDto EducationListDetail(int edu_no);
	public int EducationApplicants(int edu_no);
	public int EducationApplication(HashMap<String, Object> map);
	
	
	public EduListDto eduDetail(int no);
}
