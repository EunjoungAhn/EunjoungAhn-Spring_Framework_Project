package com.mega.plt.game;

public class UpdateScoreParamVO {
	private int gID;
	private int score;
	public int getgID() {
		return gID;
	}
	public void setgID(int gID) {
		this.gID = gID;
	}
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
	@Override
	public String toString() {
		return "UpdateScoreParamVO [gID=" + gID + ", score=" + score + "]";
	}
	
}
