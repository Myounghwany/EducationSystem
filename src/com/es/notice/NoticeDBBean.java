package com.es.notice;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Component;

import com.es.db.SqlMapClient;

@Component("noticeDao")
public class NoticeDBBean implements NoticeDao {

	@Override
	public List<NoticeDataBean> noticetList(HashMap<String, Object> map) {
		
		if(map.get("opt")==null){
			return SqlMapClient.getSession().selectList("notice.noticeList",map);
		}else if(map.get("opt").equals("0")){ 
			System.out.println("제목으로 검색");
			return SqlMapClient.getSession().selectList("notice.selectTitleList",map);
		}else if(map.get("opt").equals("1")) {
			return SqlMapClient.getSession().selectList("notice.selectContentList",map);
		}else if(map.get("opt").equals("2")) {
			return SqlMapClient.getSession().selectList("notice.selectTCList",map);
		}else {
			return SqlMapClient.getSession().selectList("notice.selectWriterList",map);
		}
	}
	
	@Override
	public int insertNotice(NoticeDataBean noticeDto) {
		return SqlMapClient.getSession().insert("notice.insertNotice", noticeDto);
	}
	
	@Override
	public NoticeDataBean detailnotice(int notice_no) {
		return SqlMapClient.getSession().selectOne("notice.detailnotice",notice_no);
	}
	
	@Override
	public int updateHit(NoticeDataBean noticeDto) {
		return SqlMapClient.getSession().update("notice.updateHit",noticeDto);
	}
	
	@Override
	public int modifyNotice(NoticeDataBean noticeDto) {
		return SqlMapClient.getSession().update("notice.modifyNotice",noticeDto);
	}
	
	@Override
	public int deleteNotice(int notice_no) {
		return SqlMapClient.getSession().delete("notice.deleteNotice", notice_no);
	}

	@Override
	public int noticeListCount(HashMap<String, Object> map) {
		
		if(map.get("opt")==null){
			return SqlMapClient.getSession().selectOne("notice.noticeListCount");
		}else if(map.get("opt").equals("0")){
			System.out.println("제목으로 검색");
			return SqlMapClient.getSession().selectOne("notice.selectTitleListCount",map);
		}else if(map.get("opt").equals("1")) {
			return SqlMapClient.getSession().selectOne("notice.selectContentListCount",map);
		}else if(map.get("opt").equals("2")) {
			return SqlMapClient.getSession().selectOne("notice.selectTCListCount",map);
		}else {
			return SqlMapClient.getSession().selectOne("notice.selectWriterListCount",map);
		}
		
	}
}
