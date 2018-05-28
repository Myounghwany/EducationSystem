package com.es.main;

import java.util.List;

import org.springframework.stereotype.Component;

import com.es.db.SqlMapClient;
import com.es.notice.NoticeDao;
import com.es.notice.NoticeDataBean;

@Component("mainDao")
public class MainDBBean implements MainDao{
	
	public List<MainDto> noticeFive(MainDto maindto){
		return SqlMapClient.getSession().selectList("main.noticeFive", maindto);
	}
	
	public List<MainDto> historyFive(MainDto maindto){
		return SqlMapClient.getSession().selectList("main.historyFive", maindto);
	}
	
	@Override
	public List<MainDto> instructorFive(MainDto maindto) {
		return SqlMapClient.getSession().selectList("main.instructorFive", maindto);
	}
	
	@Override
	public List<MainDto> petitionFive(MainDto maindto) {
		return SqlMapClient.getSession().selectList("main.petitionFive", maindto);
	}
}
