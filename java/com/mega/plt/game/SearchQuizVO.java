package com.mega.plt.game;

public class SearchQuizVO {
	private int qID; //퀴즈셋아이디
	private String title;//퀴즈셋제목
	private String uID; //출제자
	private String pID;//첫번째 전신주아이디
	private String latitude;//첫번째 전신주 위도
	private String longitude;//첫번째 전신주 경도
	public int getqID() {
		return qID;
	}
	public void setqID(int qID) {
		this.qID = qID;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getuID() {
		return uID;
	}
	public void setuID(String uID) {
		this.uID = uID;
	}
	public String getpID() {
		return pID;
	}
	public void setpID(String pID) {
		this.pID = pID;
	}
	public String getLatitude() {
		return latitude;
	}
	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	public String getLongitude() {
		return longitude;
	}
	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	
	@Override
	public String toString() {
		return "SearchQuizVO [qID=" + qID + ", title=" + title + ", uID=" + uID + ", pID=" + pID + ", latitude="
				+ latitude + ", longitude=" + longitude + "]";
	}
	
}
