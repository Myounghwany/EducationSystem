package com.es.education;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Component;

import com.es.db.SqlMapClient;

@Component("EduListDao")
public class EduListDBBean implements EduListDao{

	@Override
	public List<EducationListDto> EducationList(HashMap<String, Object> map) {
	
		if(map.get("opt")==null){//전체
			return SqlMapClient.getSession().selectList("Education.EducationList",map);
		}else if(map.get("opt").equals("0")){ //교육명
			return SqlMapClient.getSession().selectList("Education.selectTitleList",map);
		}else if(map.get("opt").equals("1")) {//교육번호
			return SqlMapClient.getSession().selectList("Education.selectNoList",map);
		}else if(map.get("opt").equals("2")) {//교육분야
			System.out.println("DBBean 교육분야 opt : "+map.get("opt")+" condition : "+map.get("condition"));
			return SqlMapClient.getSession().selectList("Education.selectFieldList",map);
		}else {//강사명
			return SqlMapClient.getSession().selectList("Education.selectInstructorList",map);
		}
		
		
	}
	
	@Override
	public int EducationListCount(HashMap<String, Object> map) {
		
		if(map.get("opt")==null){//전체
			System.out.println("EducationListCount DBBean 전체 ");
			return SqlMapClient.getSession().selectOne("Education.EducationListCount");
		}else if(map.get("opt").equals("0")){ //교육명
			return SqlMapClient.getSession().selectOne("Education.selectTitleListCount",map);
		}else if(map.get("opt").equals("1")) {//교육코드
			return SqlMapClient.getSession().selectOne("Education.selectCodeListCount",map);
		}else if(map.get("opt").equals("2")) {//교육분야
			return SqlMapClient.getSession().selectOne("Education.selectFieldListCount",map);
		}else {//강사명
			return SqlMapClient.getSession().selectOne("Education.selectInstructorListCount",map);
		}
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
