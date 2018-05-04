package com.es.notice.handler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.es.notice.NoticeDataBean;

public interface CommandHandler {
	public ModelAndView process(HttpServletRequest request, HttpServletResponse response, NoticeDataBean noticeDto) throws Throwable;
}
