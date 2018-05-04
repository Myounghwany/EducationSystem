package com.es.notice;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Component;

import com.es.db.SqlMapClient;

@Component("noticeDao")
public class NoticeDBBean {

	public List<NoticeDataBean> sellectAll(NoticeDataBean noticeDto){
		return SqlMapClient.getSession().selectList("notice.selectAll", noticeDto);
	}
	
	public int insertNotice(NoticeDataBean noticeDto) {
		return SqlMapClient.getSession().insert( "notice.insertBoard", noticeDto );
	}
	
	public int check(String notice_no) {
		return SqlMapClient.getSession().selectOne("notice.check", notice_no);
	}
	
	public NoticeDataBean selectOne(String notice_no) {
		return SqlMapClient.getSession().selectOne( "notice.selectOne", notice_no );
	}
	
	public int updateNotice(NoticeDataBean noticeDto) {
		return SqlMapClient.getSession().insert( "Board.updateBoard", noticeDto );
	}
	
	public int deleteNotice(NoticeDataBean noticeDto) {
		return SqlMapClient.getSession().delete( "Board.deleteBoard", noticeDto );
	}
	
	public List<NoticeDataBean> search(NoticeDataBean noticeDto) throws DataAccessException{
		return SqlMapClient.getSession().selectList("Board.search", noticeDto);
	}
}
