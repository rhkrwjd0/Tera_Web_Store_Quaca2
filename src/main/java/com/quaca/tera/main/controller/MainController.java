package com.quaca.tera.main.controller;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.quaca.common.vo.MenuVO;
import com.quaca.common.vo.UserVO;
	

@Controller
public class MainController {
	
	// 메인
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String no1(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String returnURL = "";
		HttpSession session = request.getSession();
        Object obj = session.getAttribute("userInfo");
        if ( obj ==null ){
        	returnURL = "redirect:/quaca/login";
        }else{
        	returnURL = "redirect:/quaca/main";
        }
        return returnURL;
	}
	// 메인
	@RequestMapping(value = "/quaca", method = RequestMethod.GET)
	public String no2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String returnURL = "";
		HttpSession session = request.getSession();
        Object obj = session.getAttribute("userInfo");
        if ( obj ==null ){
        	returnURL = "redirect:/quaca/login";
        }else{
        	returnURL = "redirect:/quaca/main";
        }
        return returnURL;
	}
	
	// 메인
	@RequestMapping(value = "/quaca/main", method = RequestMethod.GET)
	public String main(Locale locale, Model model, HttpSession session) {
		// 메뉴 코드 관리 
		MenuVO menuVO = new MenuVO(); 
		menuVO.setMenuCd("002");
		model.addAttribute("menuVO",menuVO);
		
		// userInfo 관리 (세션 정보)
		UserVO userVO = new UserVO();
		userVO = (UserVO) session.getAttribute("userInfo");
		model.addAttribute("userVO",userVO);
		return "/quaca/main/dashBoard";
	}	
	// 캔도 차트 테스트
	@RequestMapping(value = "/testKendo", method = RequestMethod.GET)
	public String testKendo(Locale locale, Model model) {

		return "/testKendo";
	}
}
