package com.mega.plt.user;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class UserController {

	@Autowired
	UserService service;

	@RequestMapping("user/create.do")
	public String create(UserVO vo) {
		int result = service.create(vo);

		if (result == 1) {
			return "user/registerSuccess";
		} else {
			return "user/registerFail";
		}
	}

	@RequestMapping("user/read.do")
	public String read(UserVO vo, HttpSession session) {
		UserVO userVO = service.read(vo);

		if (userVO != null) { // 로그인 성공 후 세션 잡기
			session.setAttribute("uID", userVO.getuID());
			session.setAttribute("name", userVO.getName());
			return "redirect:../index.jsp";
		} else { // 로그인 실패 후 아이디 체크
			int result = service.readUID(vo.getuID());
			if (result == 1) { // 5번 이상 실패하고 온 것
				service.danger();
				return "redirect:../user/find.jsp";
			}
			return "redirect:../user/login.jsp";
		}
	}

	@RequestMapping("user/logout.do")
	public String logout(HttpSession session) {
		session.removeAttribute("uID");
		session.removeAttribute("name");

		return "redirect:../index.jsp";
	}
}
