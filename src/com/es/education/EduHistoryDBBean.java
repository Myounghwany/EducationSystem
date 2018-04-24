package com.es.education;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Component;

import com.es.db.SqlMapClient;

@Component("EduHistoryDao")
public class EduHistoryDBBean implements EduHistoryDao{
	
	@Override
	public List<EduHistoryDto> eduHistoryList() {
		return SqlMapClient.getSession().selectList("Education.EduHistory");
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
}
