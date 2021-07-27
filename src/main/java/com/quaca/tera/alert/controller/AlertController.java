package com.quaca.tera.alert.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class AlertController {
	
	// 경고 페이지 
	@RequestMapping(value = "/quaca/alert", method = RequestMethod.GET)
	public String login() {
		return "/alert";
	}
	
}
