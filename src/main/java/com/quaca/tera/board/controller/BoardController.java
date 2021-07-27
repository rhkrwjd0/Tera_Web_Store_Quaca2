package com.quaca.tera.board.controller;

import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.quaca.common.vo.MenuVO;
import com.quaca.common.vo.UserVO;



@Controller
public class BoardController {
	
	// 공지 사항 목록 화면
	@RequestMapping(value = "/quaca/board/noticeList", method = RequestMethod.GET)
	public String noticeList(Locale locale, Model model, HttpSession session) {
		MenuVO menuVO = new MenuVO(); 
		menuVO.setMenuCd("008001");
		model.addAttribute("menuVO",menuVO);
		
		// userInfo 관리 (세션 정보)
		UserVO userVO = new UserVO();
		userVO = (UserVO) session.getAttribute("userInfo");
		model.addAttribute("userVO",userVO);
		
		return "/quaca/board/noticeList";
	}
	// 공지 사항 등록 화면
	@RequestMapping(value = "/quaca/board/noticeInsert", method = RequestMethod.GET)
	public String noticeInsert(Locale locale, Model model, HttpSession session) {
		MenuVO menuVO = new MenuVO(); 
		menuVO.setMenuCd("008001");
		model.addAttribute("menuVO",menuVO);
		
		// userInfo 관리 (세션 정보)
		UserVO userVO = new UserVO();
		userVO = (UserVO) session.getAttribute("userInfo");
		model.addAttribute("userVO",userVO);
		
		return "/quaca/board/noticeInsert";
	}
	// 공지 사항 수정 화면
	@RequestMapping(value = "/quaca/board/noticeUpdate", method = RequestMethod.GET)
	public String noticeUpdate(Locale locale, Model model, HttpSession session) {
		MenuVO menuVO = new MenuVO(); 
		menuVO.setMenuCd("008001");
		model.addAttribute("menuVO",menuVO);
		
		// userInfo 관리 (세션 정보)
		UserVO userVO = new UserVO();
		userVO = (UserVO) session.getAttribute("userInfo");
		model.addAttribute("userVO",userVO);
		
		return "/quaca/board/noticeUpdate";
	}
	
	// 건의 사항 목록 화면
	@RequestMapping(value = "/quaca/board/suggestList", method = RequestMethod.GET)
	public String suggestList(Locale locale, Model model, HttpSession session) {
		MenuVO menuVO = new MenuVO(); 
		menuVO.setMenuCd("008002");
		model.addAttribute("menuVO",menuVO);
		
		// userInfo 관리 (세션 정보)
		UserVO userVO = new UserVO();
		userVO = (UserVO) session.getAttribute("userInfo");
		model.addAttribute("userVO",userVO);
		
		return "/quaca/board/suggestList";
	}
	// 건의 사항 수정 화면
	@RequestMapping(value = "/quaca/board/suggestUpdate", method = RequestMethod.GET)
	public String suggestUpdate(Locale locale, Model model, HttpSession session) {
		MenuVO menuVO = new MenuVO(); 
		menuVO.setMenuCd("008002");
		model.addAttribute("menuVO",menuVO);
		
		// userInfo 관리 (세션 정보)
		UserVO userVO = new UserVO();
		userVO = (UserVO) session.getAttribute("userInfo");
		model.addAttribute("userVO",userVO);
		
		return "/quaca/board/suggestUpdate";
	}	

	// 문의 사항 목록 화면
	@RequestMapping(value = "/quaca/board/inquireList", method = RequestMethod.GET)
	public String inquireList(Locale locale, Model model, HttpSession session) {
		MenuVO menuVO = new MenuVO(); 
		menuVO.setMenuCd("008003");
		model.addAttribute("menuVO",menuVO);
		
		// userInfo 관리 (세션 정보)
		UserVO userVO = new UserVO();
		userVO = (UserVO) session.getAttribute("userInfo");
		model.addAttribute("userVO",userVO);
		
		return "/quaca/board/inquireList";
	}
	// 문의 사항 수정 화면
	@RequestMapping(value = "/quaca/board/inquireUpdate", method = RequestMethod.GET)
	public String inquireUpdate(Locale locale, Model model, HttpSession session) {
		MenuVO menuVO = new MenuVO(); 
		menuVO.setMenuCd("008003");
		model.addAttribute("menuVO",menuVO);
		
		// userInfo 관리 (세션 정보)
		UserVO userVO = new UserVO();
		userVO = (UserVO) session.getAttribute("userInfo");
		model.addAttribute("userVO",userVO);
		
		return "/quaca/board/inquireUpdate";
	}		
	
}
