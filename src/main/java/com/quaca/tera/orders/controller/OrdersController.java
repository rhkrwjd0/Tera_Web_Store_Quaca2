package com.quaca.tera.orders.controller;

import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.quaca.common.vo.MenuVO;
import com.quaca.common.vo.UserVO;

@Controller
public class OrdersController {
	
	// 주문 정보 ( 접수대기[before] & 주문 진행[after])
	@RequestMapping(value = "/quaca/orders/orderInfo", method = RequestMethod.GET)
	public String orderList(Locale locale, Model model, HttpSession session) {
		MenuVO menuVO = new MenuVO(); 
		menuVO.setMenuCd("003001");
		model.addAttribute("menuVO",menuVO);
		
		// userInfo 관리 (세션 정보)
		UserVO userVO = new UserVO();
		userVO = (UserVO) session.getAttribute("userInfo");
		model.addAttribute("userVO",userVO);
		
		return "/quaca/orders/orderInfo";
	}
	
	// 주문 내역
	@RequestMapping(value = "/quaca/orders/paymentList", method = RequestMethod.GET)
	public String paymentList(Locale locale, Model model, HttpSession session) {
		MenuVO menuVO = new MenuVO(); 
		menuVO.setMenuCd("003002");
		model.addAttribute("menuVO",menuVO);
		
		// userInfo 관리 (세션 정보)
		UserVO userVO = new UserVO();
		userVO = (UserVO) session.getAttribute("userInfo");
		model.addAttribute("userVO",userVO);
		
		return "/quaca/orders/paymentList";
	}
	// 주문 내역(상세 정보)
	@RequestMapping(value = "/quaca/orders/paymentInfo", method = RequestMethod.GET)
	public String paymentInfo(Locale locale, Model model) {
		MenuVO menuVO = new MenuVO(); 
		menuVO.setMenuCd("003002");
		model.addAttribute("menuVO",menuVO);
		return "/quaca/orders/paymentInfo";
	}
}
