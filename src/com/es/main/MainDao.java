package com.es.main;

import java.util.List;

import com.es.notice.NoticeDataBean;

public interface MainDao {

	public List<NoticeDataBean> sellectAll(NoticeDataBean noticedto);
}
