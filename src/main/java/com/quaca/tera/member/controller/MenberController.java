package com.quaca.tera.member.controller;

import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.quaca.common.vo.MenuVO;
import com.quaca.common.vo.UserVO;

@Controller
public class MenberController {
	
	// 고객 목록 화면
	@RequestMapping(value = "/quaca/member/memberList", method = RequestMethod.GET)
	public String memberList(Locale locale, Model model, HttpSession session) {
		MenuVO menuVO = new MenuVO(); 
		menuVO.setMenuCd("007001");
		model.addAttribute("menuVO",menuVO);		
		
		// userInfo 관리 (세션 정보)
		UserVO userVO = new UserVO();
		userVO = (UserVO) session.getAttribute("userInfo");
		model.addAttribute("userVO",userVO);
		
		return "/quaca/member/memberList";
	}
	// 고객 정보 화면
	@RequestMapping(value = "/quaca/member/memberInfo", method = RequestMethod.GET)
	public String memberInfo(Locale locale, Model model, HttpSession session, String userId) {
		MenuVO menuVO = new MenuVO(); 
		menuVO.setMenuCd("007001");
		model.addAttribute("menuVO",menuVO);
		
		// userInfo 관리 (세션 정보)
		UserVO userVO = new UserVO();
		userVO = (UserVO) session.getAttribute("userInfo");
		model.addAttribute("userVO",userVO);
		
		model.addAttribute("userId",userId);
		
		return "/quaca/member/memberInfo";
	}
}
