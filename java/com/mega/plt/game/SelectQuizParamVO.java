package com.mega.plt.game;

public class SelectQuizParamVO {
	private String qID;
	private String ordr;
	public String getqID() {
		return qID;
	}
	public void setqID(String qID) {
		this.qID = qID;
	}
	public String getOrdr() {
		return ordr;
	}
	public void setOrdr(String ordr) {
		this.ordr = ordr;
	}
	@Override
	public String toString() {
		return "SelectQuizParamVO [qID=" + qID + ", ordr=" + ordr + "]";
	}
	
}
