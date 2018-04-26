package com.es.education;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Component;

import com.es.db.SqlMapClient;

@Component("EduListDao")
public class EduListDBBean implements EduListDao{

	@Override
	public List<EducationListDto> EducationList() {
		return SqlMapClient.getSession().selectList("Education.EducationList");
	}
	
	@Override
	public EducationListDto EducationListDetail(int edu_no) {
		return SqlMapClient.getSession().selectOne("Education.EducationListDetail",edu_no);
	}
	
	@Override
	public int EducationApplicants(int edu_no) {
		return SqlMapClient.getSession().selectOne("Education.EducationApplicants",edu_no);
	}
	
	@Override
	public int EducationApplication(HashMap<String, Object> map) {
		System.out.println("EducationApplication");
		return SqlMapClient.getSession().insert("Education.EducationApplication", map);
	}
	
}
