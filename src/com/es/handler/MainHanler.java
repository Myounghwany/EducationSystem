package com.es.handler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.es.education.EduHistoryDao;
import com.es.education.EduHistoryDto;
import com.es.education.EduListDao;
import com.es.education.EducationListDto;
import com.es.notice.NoticeDao;
import com.es.notice.NoticeDataBean;

@Controller
public class MainHanler {

	@Resource
	private NoticeDao noticedao;

	@Resource
	private EduListDao edDao;

	@Resource
	private EduHistoryDao eduhistoryDao;


}
