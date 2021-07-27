package com.quaca.common.vo;

import org.springframework.web.multipart.MultipartFile;

public class FileVO{
	
	private int fileID;
	private String fileEncNm;
	private String fileOrgNm;
	private String filePath;
	private String fileSize;
	private String fileType;
	private String storeId;
	private String type;
	private String refId;
	private String delYn;
	private String insertId;
	private String insertDt;
	
	private MultipartFile file;
	
	public int getFileID() {
		return fileID;
	}
	public void setFileID(int fileID) {
		this.fileID = fileID;
	}
	public String getFileEncNm() {
		return fileEncNm;
	}
	public void setFileEncNm(String fileEncNm) {
		this.fileEncNm = fileEncNm;
	}
	public String getFileOrgNm() {
		return fileOrgNm;
	}
	public void setFileOrgNm(String fileOrgNm) {
		this.fileOrgNm = fileOrgNm;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public String getFileSize() {
		return fileSize;
	}
	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}
	public String getFileType() {
		return fileType;
	}
	public void setFileType(String fileType) {
		this.fileType = fileType;
	}
	public String getStoreId() {
		return storeId;
	}
	public void setStoreId(String storeId) {
		this.storeId = storeId;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getRefId() {
		return refId;
	}
	public void setRefId(String refId) {
		this.refId = refId;
	}
	public String getDelYn() {
		return delYn;
	}
	public void setDelYn(String delYn) {
		this.delYn = delYn;
	}
	public String getInsertId() {
		return insertId;
	}
	public void setInsertId(String insertId) {
		this.insertId = insertId;
	}
	public String getInsertDt() {
		return insertDt;
	}
	public void setInsertDt(String insertDt) {
		this.insertDt = insertDt;
	}
	public MultipartFile getFile() {
		return file;
	}
	public void setFile(MultipartFile file) {
		this.file = file;
	}
	@Override
	public String toString() {
		return "FileVO [fileID=" + fileID + ", fileEncNm=" + fileEncNm + ", fileOrgNm=" + fileOrgNm + ", filePath="
				+ filePath + ", fileSize=" + fileSize + ", fileType=" + fileType + ", storeId=" + storeId + ", type="
				+ type + ", refId=" + refId + ", delYn=" + delYn + ", insertId=" + insertId + ", insertDt=" + insertDt
				+ ", file=" + file + "]";
	}
}