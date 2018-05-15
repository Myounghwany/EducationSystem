package com.es.education;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Component;

import com.es.db.SqlMapClient;

@Component("EduHistoryDao")
public class EduHistoryDBBean implements EduHistoryDao{
	
	@Override
	public List<EduHistoryDto> eduHistoryList(String emp_no) {
		System.out.println("eduHistory ");
		List<EduHistoryDto> result = null;
		if(emp_no.substring(0, 1).equals("E")) {
			System.out.println("직원인지 체크/"+emp_no.substring(0, 1));
			result = SqlMapClient.getSession().selectList("Education.EduHistory", emp_no);
		} else if(emp_no.substring(0, 1).equals("I")){
			System.out.println("강사인지 체크/"+emp_no.substring(0, 1));
			result = SqlMapClient.getSession().selectList("Education.InstEduHistory", emp_no);
		} 
		return result;
	}
	
	@Override
	public EduHistoryDto eduHistoryDetail(int no) {
		return SqlMapClient.getSession().selectOne("Education.EduHistoryDetail", no);
	}
	
	@Override
	public int insertEmpEval(int no, String emp_eval) {
		HashMap<Object, Object> eval = new HashMap<>();
		eval.put("no", no);
		eval.put("emp_eval", emp_eval);
		return SqlMapClient.getSession().update("Education.insertEmpEval", eval);
	}
	
	@Override
	public EduHistoryDto EduHistoryShowEval(int edu_no, String emp_no) {
		HashMap<Object, Object> eval = new HashMap<>();
		eval.put("no", edu_no);
		eval.put("emp_no", emp_no);
		return SqlMapClient.getSession().selectOne("Education.showEval", eval);
	}
}
