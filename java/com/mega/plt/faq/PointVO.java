package com.mega.plt.faq;

public class PointVO {
	int pntID;
	String uID;
	int score;
	String cDate;

	public int getPntID() {
		return pntID;
	}

	public void setPntID(int pntID) {
		this.pntID = pntID;
	}

	public String getuID() {
		return uID;
	}

	public void setuID(String uID) {
		this.uID = uID;
	}

	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}

	public String getcDate() {
		return cDate;
	}

	public void setcDate(String cDate) {
		this.cDate = cDate;
	}

	@Override
	public String toString() {
		return "PointVO [pntID=" + pntID + ", uID=" + uID + ", score=" + score + ", cDate=" + cDate + "]";
	}

}
