package com.es.notice;

import java.util.List;

import org.springframework.dao.DataAccessException;

public interface NoticeDao {

	public List<NoticeDataBean> sellectAll(NoticeDataBean noticeDto);
	
	public int insertNotice(NoticeDataBean noticeDto);
	
	public int check(String notice_no);
	
	public NoticeDataBean selectOne(String notice_no);
	
	public int updateNotice(NoticeDataBean noticeDto);
	
	public int deleteNotice(NoticeDataBean noticeDto);
	
	public List<NoticeDataBean> search (NoticeDataBean noticeDto) throws DataAccessException;

	
}
