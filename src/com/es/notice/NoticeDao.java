package com.es.notice;

import java.util.HashMap;
import java.util.List;

public interface NoticeDao {
	
	public List<NoticeDataBean> noticetList(HashMap<String, Object> map);
	
	public int insertNotice(NoticeDataBean noticeDto);
	
	public NoticeDataBean detailnotice(int notice_no);
	
	public int updateHit(NoticeDataBean noticeDto);
	
	public int modifyNotice(NoticeDataBean noticeDto);
	
	public int deleteNotice(int notice_no);
	
	public int noticeListCount(HashMap<String, Object> map);
	

	
}
