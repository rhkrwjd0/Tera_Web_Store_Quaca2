package com.quaca.common.vo;

public class MenuVO {
	public String menuCd;
	public String menuName;
	public String getMenuCd() {
		return menuCd;
	}
	public void setMenuCd(String menuCd) {
		this.menuCd = menuCd;
	}
	public String getMenuName() {
		return menuName;
	}
	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}
	@Override
	public String toString() {
		return "menuVO [menuCd=" + menuCd + ", menuName=" + menuName + "]";
	}
}
