package com.es.handler;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.es.user.UserDao;
import com.es.user.UserDto;

@Controller
public class UserHandler {

	@Resource
	UserDao userDao;

	@RequestMapping(value="user/login", method = RequestMethod.POST)
	public String loginCheck(UserDto userDto, HttpSession session, Model model) throws Exception{

		System.out.println("login emp_no : "+ userDto.getEmp_no());
		System.out.println("login password : "+ userDto.getPassword());
		System.out.println("login emp_name : " + userDto.getName());

		String emp_no = userDto.getEmp_no();
		String password = userDto.getPassword();

		int result = userDao.loginCheck(emp_no, password);

		switch(result) {
		case -1 :
			model.addAttribute("result", "아이디나 비밀번호가 틀렸습니다.");
			System.out.println("case -1");
		case 0:
			model.addAttribute("result", "아이디나 비밀번호가 틀렸습니다.");
			System.out.println("case 0");
		case 1:
			UserDto getUser = userDao.findById(emp_no, password);
			session.setAttribute("emp_no", getUser.getEmp_no());
			session.setAttribute("password", getUser.getPassword());
			session.setAttribute("name",  getUser.getName());
			System.out.println("case 1");
			break;
		}
		System.out.println("세션 등록.." + session);

	return "redirect:/";
	}

	@RequestMapping(value="user/logout", method= RequestMethod.GET)
	public String logout(HttpSession session, Model model) {
		userDao.logout(session);
		return "redirect:/";
	}

}
