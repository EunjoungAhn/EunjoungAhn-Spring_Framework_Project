package com.mega.plt.game;

public class InsertPointParamVO {
	private String uID;
	private int score;
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
	@Override
	public String toString() {
		return "InsertPointParamVO [uID=" + uID + ", score=" + score + "]";
	}
	
}
