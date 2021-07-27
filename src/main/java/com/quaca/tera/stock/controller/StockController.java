package com.quaca.tera.stock.controller;

import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.quaca.common.vo.MenuVO;
import com.quaca.common.vo.UserVO;

@Controller
public class StockController {
	
	// 재고 관리 목록
	@RequestMapping(value = "/quaca/stock/stockList", method = RequestMethod.GET)
	public String stockList(Locale locale, Model model, HttpSession session) {
		MenuVO menuVO = new MenuVO();
		menuVO.setMenuCd("006001");
		model.addAttribute("menuVO",menuVO);
		
		// userInfo 관리 (세션 정보)
		UserVO userVO = new UserVO();
		userVO = (UserVO) session.getAttribute("userInfo");
		model.addAttribute("userVO",userVO);
		
		return "/quaca/stock/stockList";
	}
	// 재고 관리 등록
	@RequestMapping(value = "/quaca/stock/stockInsert", method = RequestMethod.GET)
	public String stockInsert(Locale locale, Model model, HttpSession session) {
		MenuVO menuVO = new MenuVO();
		menuVO.setMenuCd("006001");
		model.addAttribute("menuVO",menuVO);
		
		// userInfo 관리 (세션 정보)
		UserVO userVO = new UserVO();
		userVO = (UserVO) session.getAttribute("userInfo");
		model.addAttribute("userVO",userVO);
		
		return "/quaca/stock/stockInsert";
	}
	// 재고 관리 수정(입고 & 출고 처리)
	@RequestMapping(value = "/quaca/stock/stockUpdate", method = RequestMethod.GET)
	public String stockUpdate(Locale locale, Model model, HttpSession session, String stockCd) {
		MenuVO menuVO = new MenuVO();
		menuVO.setMenuCd("006001");
		model.addAttribute("menuVO",menuVO);
		
		// userInfo 관리 (세션 정보)
		UserVO userVO = new UserVO();
		userVO = (UserVO) session.getAttribute("userInfo");
		model.addAttribute("userVO",userVO);
		
		model.addAttribute("stockCd",stockCd);
		
		return "/quaca/stock/stockUpdate";
	}
	
}
