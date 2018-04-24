package com.es.education;

import java.util.List;

public interface EduListDao {
	public List<EduListDto> eduList();
	
	
	public List<EducationListDto> EducationList();
	public EducationListDto EducationListDetail(int edu_no);

	public EduListDto eduDetail(int no);
}
