package com.mega.plt.game;

public class ProgressParamVO {
	private String uID; //사용자아이디
	private int qID; // 퀴즈셋 아이디
	public String getuID() {
		return uID;
	}
	public void setuID(String uID) {
		this.uID = uID;
	}
	public int getqID() {
		return qID;
	}
	public void setqID(int qID) {
		this.qID = qID;
	}
	@Override
	public String toString() {
		return "ProgressParamVO [uID=" + uID + ", qID=" + qID + "]";
	}
	
}
