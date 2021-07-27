package com.quaca.common.vo;
public class UserVO{
	
	private String seq;
	private String sid;
	private String password;
	private String token;
	private String storeId;
	private String telNo;
	private String useYn;
	private String theme;
	private String storeName;
	private String insertDt;
	
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getSid() {
		return sid;
	}
	public void setSid(String sid) {
		this.sid = sid;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getToken() {
		return token;
	}
	public void setToken(String token) {
		this.token = token;
	}
	public String getStoreId() {
		return storeId;
	}
	public void setStoreId(String storeId) {
		this.storeId = storeId;
	}
	public String getTelNo() {
		return telNo;
	}
	public void setTelNo(String telNo) {
		this.telNo = telNo;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public String getTheme() {
		return theme;
	}
	public void setTheme(String theme) {
		this.theme = theme;
	}
	public String getStoreName() {
		return storeName;
	}
	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}
	public String getInsertDt() {
		return insertDt;
	}
	public void setInsertDt(String insertDt) {
		this.insertDt = insertDt;
	}
	@Override
	public String toString() {
		return "UserVO [seq=" + seq + ", sid=" + sid + ", password=" + password + ", token=" + token + ", storeId="
				+ storeId + ", telNo=" + telNo + ", useYn=" + useYn + ", theme=" + theme + ", storeName=" + storeName
				+ ", insertDt=" + insertDt + "]";
	}
}