package com.mega.plt.game;

public class QuizVO {

	private String pID;
	private int qID;
	private String hint1;
	private String hint2;
	private String hint3;
	private int ordr;
	private String latitude;
	private String longitude;
	public String getpID() {
		return pID;
	}
	public void setpID(String pID) {
		this.pID = pID;
	}
	public int getqID() {
		return qID;
	}
	public void setqID(int qID) {
		this.qID = qID;
	}
	public String getHint1() {
		return hint1;
	}
	public void setHint1(String hint1) {
		this.hint1 = hint1;
	}
	public String getHint2() {
		return hint2;
	}
	public void setHint2(String hint2) {
		this.hint2 = hint2;
	}
	public String getHint3() {
		return hint3;
	}
	public void setHint3(String hint3) {
		this.hint3 = hint3;
	}
	public int getOrdr() {
		return ordr;
	}
	public void setOrdr(int ordr) {
		this.ordr = ordr;
	}
	public String getLatitude() {
		return latitude;
	}
	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	public String getLongtitude() {
		return longitude;
	}
	public void setLongtitude(String longtitude) {
		this.longitude = longtitude;
	}
	@Override
	public String toString() {
		return "QuizVO [pID=" + pID + ", qID=" + qID + ", hint1=" + hint1 + ", hint2=" + hint2 + ", hint3=" + hint3
				+ ", ordr=" + ordr + ", latitude=" + latitude + ", longtitude=" + longitude + "]";
	}
}
