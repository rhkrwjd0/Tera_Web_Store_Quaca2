package com.quaca.tera.stats.controller;

import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.quaca.common.vo.MenuVO;
import com.quaca.common.vo.UserVO;

@Controller
public class StatsController {
	
	// 매출 달력
	@RequestMapping(value = "/quaca/stats/calendar", method = RequestMethod.GET)
	public String calendar(Locale locale, Model model, HttpSession session) {
		MenuVO menuVO = new MenuVO(); 
		menuVO.setMenuCd("004001");
		model.addAttribute("menuVO",menuVO);
		
		// userInfo 관리 (세션 정보)
		UserVO userVO = new UserVO();
		userVO = (UserVO) session.getAttribute("userInfo");
		model.addAttribute("userVO",userVO);
		
		return "/quaca/stats/calendar";
	}

	// 매출 분석
	@RequestMapping(value = "/quaca/stats/sales", method = RequestMethod.GET)
	public String sales(Locale locale, Model model, HttpSession session) {
		MenuVO menuVO = new MenuVO(); 
		menuVO.setMenuCd("004002");
		model.addAttribute("menuVO",menuVO);
		
		// userInfo 관리 (세션 정보)
		UserVO userVO = new UserVO();
		userVO = (UserVO) session.getAttribute("userInfo");
		model.addAttribute("userVO",userVO);
		
		return "/quaca/stats/sales";
	}
	// 영업 분석(시간 통계)
	@RequestMapping(value = "/quaca/stats/time", method = RequestMethod.GET)
	public String time(Locale locale, Model model, HttpSession session) {
		MenuVO menuVO = new MenuVO(); 
		menuVO.setMenuCd("004003");
		model.addAttribute("menuVO",menuVO);
		
		// userInfo 관리 (세션 정보)
		UserVO userVO = new UserVO();
		userVO = (UserVO) session.getAttribute("userInfo");
		model.addAttribute("userVO",userVO);
		
		return "/quaca/stats/time";
	}
	// 영업 분석(시간 통계)
	@RequestMapping(value = "/quaca/stats/menu", method = RequestMethod.GET)
	public String menu(Locale locale, Model model, HttpSession session) {
		MenuVO menuVO = new MenuVO(); 
		menuVO.setMenuCd("004004");
		model.addAttribute("menuVO",menuVO);
		
		// userInfo 관리 (세션 정보)
		UserVO userVO = new UserVO();
		userVO = (UserVO) session.getAttribute("userInfo");
		model.addAttribute("userVO",userVO);
		
		return "/quaca/stats/menu";
	}
	
	
	
}
