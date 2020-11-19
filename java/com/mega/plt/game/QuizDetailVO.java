package com.mega.plt.game;

public class QuizDetailVO {
	private int qdID; //퀴즈 디테일 아이디
	private int qID; //퀴즈 아이디
	private String pID; //전신주아이디
	private String hint1;
	private String hint2;
	private String hint3;
	private int ordr; //순서
	public int getQdID() {
		return qdID;
	}
	public void setQdID(int qdID) {
		this.qdID = qdID;
	}
	public int getqID() {
		return qID;
	}
	public void setqID(int qID) {
		this.qID = qID;
	}
	public String getpID() {
		return pID;
	}
	public void setpID(String pID) {
		this.pID = pID;
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
	@Override
	public String toString() {
		return "QuizDetailVO [qdID=" + qdID + ", qID=" + qID + ", pID=" + pID + ", hint1=" + hint1 + ", hint2=" + hint2
				+ ", hint3=" + hint3 + ", ordr=" + ordr + "]";
	}
	

}
