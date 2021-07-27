package com.quaca.tera.store.controller;

import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.quaca.common.vo.MenuVO;
import com.quaca.common.vo.UserVO;

@Controller
public class StoreController {
	
	// 매장 정보 관리
	@RequestMapping(value = "/quaca/store/storeInfo", method = RequestMethod.GET)
	public String storeInfo(Locale locale, Model model, HttpSession session) {
		MenuVO menuVO = new MenuVO();
		menuVO.setMenuCd("005001");
		model.addAttribute("menuVO",menuVO);
		
		// userInfo 관리 (세션 정보)
		UserVO userVO = new UserVO();
		userVO = (UserVO) session.getAttribute("userInfo");
		model.addAttribute("userVO",userVO);
		
		return "/quaca/store/storeInfo";
	}
	// 매장 정보 관리 수정
	@RequestMapping(value = "/quaca/store/storeUpdate", method = RequestMethod.GET)
	public String storeUpdate(Locale locale, Model model, HttpSession session) {
		MenuVO menuVO = new MenuVO();
		menuVO.setMenuCd("005001");
		model.addAttribute("menuVO",menuVO);
		
		// userInfo 관리 (세션 정보)
		UserVO userVO = new UserVO();
		userVO = (UserVO) session.getAttribute("userInfo");
		model.addAttribute("userVO",userVO);
		
		return "/quaca/store/storeUpdate";
	}
	
	
	// 카테고리 관리 목록
	@RequestMapping(value = "/quaca/store/categoryList", method = RequestMethod.GET)
	public String categoryList(Locale locale, Model model, HttpSession session) {
		MenuVO menuVO = new MenuVO();
		menuVO.setMenuCd("005002");
		model.addAttribute("menuVO",menuVO);
		
		// userInfo 관리 (세션 정보)
		UserVO userVO = new UserVO();
		userVO = (UserVO) session.getAttribute("userInfo");
		model.addAttribute("userVO",userVO);
		
		return "/quaca/store/categoryList";
	}
	// 카테고리 관리 등록
	@RequestMapping(value = "/quaca/store/categoryInsert", method = RequestMethod.GET)
	public String categoryInsert(Locale locale, Model model, HttpSession session) {
		MenuVO menuVO = new MenuVO();
		menuVO.setMenuCd("005002");
		model.addAttribute("menuVO",menuVO);
		
		// userInfo 관리 (세션 정보)
		UserVO userVO = new UserVO();
		userVO = (UserVO) session.getAttribute("userInfo");
		model.addAttribute("userVO",userVO);
		
		return "/quaca/store/categoryInsert";
	}
	// 카테고리 관리 수정
	@RequestMapping(value = "/quaca/store/categoryUpdate", method = RequestMethod.GET)
	public String categoryUpdate(Locale locale, Model model, HttpSession session) {
		MenuVO menuVO = new MenuVO();
		menuVO.setMenuCd("005002");
		model.addAttribute("menuVO",menuVO);
		
		// userInfo 관리 (세션 정보)
		UserVO userVO = new UserVO();
		userVO = (UserVO) session.getAttribute("userInfo");
		model.addAttribute("userVO",userVO);
		
		return "/quaca/store/categoryUpdate";
	}
	
	
	// 상품 관리 목록(카테고리 탭 기능)
	@RequestMapping(value = "/quaca/store/menuList", method = RequestMethod.GET)
	public String menuList(Locale locale, Model model, HttpSession session) {
		MenuVO menuVO = new MenuVO();
		menuVO.setMenuCd("005003");
		model.addAttribute("menuVO",menuVO);
		
		// userInfo 관리 (세션 정보)
		UserVO userVO = new UserVO();
		userVO = (UserVO) session.getAttribute("userInfo");
		model.addAttribute("userVO",userVO);
		
		return "/quaca/store/menuList";
	}
	// 상품 관리 등록
	@RequestMapping(value = "/quaca/store/menuInsert", method = RequestMethod.GET)
	public String menuInsert(Locale locale, Model model, HttpSession session) {
		MenuVO menuVO = new MenuVO();
		menuVO.setMenuCd("005003");
		model.addAttribute("menuVO",menuVO);
		
		// userInfo 관리 (세션 정보)
		UserVO userVO = new UserVO();
		userVO = (UserVO) session.getAttribute("userInfo");
		model.addAttribute("userVO",userVO);
		
		return "/quaca/store/menuInsert";
	}
	// 상품 관리 수정
	@RequestMapping(value = "/quaca/store/menuUpdate", method = RequestMethod.GET)
	public String menuUpdate(Model model, HttpSession session, String menuId) {
		//ModelAndView mav = new ModelAndView();
		MenuVO menuVO = new MenuVO();
		menuVO.setMenuCd("005003");
		model.addAttribute("menuVO",menuVO);
		
		// userInfo 관리 (세션 정보)
		UserVO userVO = new UserVO();
		userVO = (UserVO) session.getAttribute("userInfo");
		model.addAttribute("userVO",userVO);
		
		// 상품 코드
		model.addAttribute("menuId",menuId);
				
		return "/quaca/store/menuUpdate";
	}
	
	
	// 직원 관리 목록
	@RequestMapping(value = "/quaca/store/staffList", method = RequestMethod.GET)
	public String staffList(Locale locale, Model model, HttpSession session) {
		MenuVO menuVO = new MenuVO();
		menuVO.setMenuCd("005004");
		model.addAttribute("menuVO",menuVO);
		
		// userInfo 관리 (세션 정보)
		UserVO userVO = new UserVO();
		userVO = (UserVO) session.getAttribute("userInfo");
		model.addAttribute("userVO",userVO);
		
		return "/quaca/store/staffList";
	}
	// 직원 관리 등록
	@RequestMapping(value = "/quaca/store/staffInsert", method = RequestMethod.GET)
	public String staffInsert(Locale locale, Model model, HttpSession session) {
		MenuVO menuVO = new MenuVO();
		menuVO.setMenuCd("005004");
		model.addAttribute("menuVO",menuVO);
		
		// userInfo 관리 (세션 정보)
		UserVO userVO = new UserVO();
		userVO = (UserVO) session.getAttribute("userInfo");
		model.addAttribute("userVO",userVO);
		
		return "/quaca/store/staffInsert";
	}
	// 직원 관리 수정
	@RequestMapping(value = "/quaca/store/staffUpdate", method = RequestMethod.GET)
	public String staffUpdate(Locale locale, Model model, HttpSession session) {
		MenuVO menuVO = new MenuVO();
		menuVO.setMenuCd("005004");
		model.addAttribute("menuVO",menuVO);
		
		// userInfo 관리 (세션 정보)
		UserVO userVO = new UserVO();
		userVO = (UserVO) session.getAttribute("userInfo");
		model.addAttribute("userVO",userVO);
		
		return "/quaca/store/staffUpdate";
	}
	
	// 행사 관리 목록
	@RequestMapping(value = "/quaca/store/eventList", method = RequestMethod.GET)
	public String eventList(Locale locale, Model model, HttpSession session) {
		MenuVO menuVO = new MenuVO();
		menuVO.setMenuCd("005005");
		model.addAttribute("menuVO",menuVO);
		
		// userInfo 관리 (세션 정보)
		UserVO userVO = new UserVO();
		userVO = (UserVO) session.getAttribute("userInfo");
		model.addAttribute("userVO",userVO);
		
		return "/quaca/store/eventList";
	}
	// 행사 관리 등록
	@RequestMapping(value = "/quaca/store/eventInsert", method = RequestMethod.GET)
	public String eventInsert(Locale locale, Model model, HttpSession session) {
		MenuVO menuVO = new MenuVO();
		menuVO.setMenuCd("005005");
		model.addAttribute("menuVO",menuVO);
		
		// userInfo 관리 (세션 정보)
		UserVO userVO = new UserVO();
		userVO = (UserVO) session.getAttribute("userInfo");
		model.addAttribute("userVO",userVO);
		
		return "/quaca/store/eventInsert";
	}
	// 행사 관리 수정
	@RequestMapping(value = "/quaca/store/eventUpdate", method = RequestMethod.GET)
	public String eventUpdate(Locale locale, Model model, HttpSession session, String eventCd) {
		MenuVO menuVO = new MenuVO();
		menuVO.setMenuCd("005005");
		model.addAttribute("menuVO",menuVO);
		
		// userInfo 관리 (세션 정보)
		UserVO userVO = new UserVO();
		userVO = (UserVO) session.getAttribute("userInfo");
		model.addAttribute("userVO",userVO);
		
		model.addAttribute("eventCd",eventCd);
		return "/quaca/store/eventUpdate";
	}
	
	
}
