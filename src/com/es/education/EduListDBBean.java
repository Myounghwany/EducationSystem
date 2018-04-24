package com.es.education;

import java.util.List;

import org.springframework.stereotype.Component;

import com.es.db.SqlMapClient;

@Component("EduListDao")
public class EduListDBBean implements EduListDao{

	@Override
	public List<EduListDto> eduList() {
		return SqlMapClient.getSession().selectList("Education.EduList");
	}
	//수강목록 상세 커리큘럼보기
	@Override
	public EduListDto eduDetail(int no) {
		return SqlMapClient.getSession().selectOne("Education.EduDetail", no);
	}
	
	@Override
	public List<EducationListDto> EducationList() {
		return SqlMapClient.getSession().selectList("Education.EducationList");
	}
	
	@Override
	public EducationListDto EducationListDetail(int edu_no) {
		return SqlMapClient.getSession().selectOne("Education.EducationListDetail",edu_no);
	}
}
