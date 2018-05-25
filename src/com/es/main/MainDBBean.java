package com.es.main;

import java.util.List;

import com.es.db.SqlMapClient;
import com.es.notice.NoticeDataBean;

public class MainDBBean {
	public List<NoticeDataBean> sellectFive(NoticeDataBean noticeDto){
		return SqlMapClient.getSession().selectList("main.selectFive", noticeDto);
	}
}
