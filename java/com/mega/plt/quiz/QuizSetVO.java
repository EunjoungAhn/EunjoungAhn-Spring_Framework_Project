package com.mega.plt.quiz;

public class QuizSetVO {
	private	int qID;
	private	String uID;
	private	String title;
	private	String cDate;
	
	public int getqID() {
		return qID;
	}
	public void setqID(int qID) {
		this.qID = qID;
	}
	public String getuID() {
		return uID;
	}
	public void setuID(String uID) {
		this.uID = uID;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getcDate() {
		return cDate;
	}
	public void setcDate(String cDate) {
		this.cDate = cDate;
	}
	@Override
	public String toString() {
		return "QuizSetVO [qID=" + qID + ", uID=" + uID + ", title=" + title + ", cDate=" + cDate + "]";
	}
}