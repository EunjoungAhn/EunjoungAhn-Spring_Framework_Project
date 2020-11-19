package com.mega.plt.game;

public class GameVO {
	private int gID; //게임아이디(퀴즈셋에 대한 유저의 진행상황)
	private String uID; //유저아이디
	private String start; //시작시각
	private String end; //종료시각
	private int score; //스코어
	private String hint1;//hint1 사용여부
	private String hint2;//hint2 사용여부
	private String hint3;//hint3 사용여부
	private String isSolved1; //1번문제 풀이여부
	private String isSolved2; //2번문제 풀이여부
	private String isSolved3; //3번문제 풀이여부
	public int getgID() {
		return gID;
	}
	public void setgID(int gID) {
		this.gID = gID;
	}
	public String getuID() {
		return uID;
	}
	public void setuID(String uID) {
		this.uID = uID;
	}
	public String getStart() {
		return start;
	}
	public void setStart(String start) {
		this.start = start;
	}
	public String getEnd() {
		return end;
	}
	public void setEnd(String end) {
		this.end = end;
	}
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
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
	public String getIsSolved1() {
		return isSolved1;
	}
	public void setIsSolved1(String isSolved1) {
		this.isSolved1 = isSolved1;
	}
	public String getIsSolved2() {
		return isSolved2;
	}
	public void setIsSolved2(String isSolved2) {
		this.isSolved2 = isSolved2;
	}
	public String getIsSolved3() {
		return isSolved3;
	}
	public void setIsSolved3(String isSolved3) {
		this.isSolved3 = isSolved3;
	}
	@Override
	public String toString() {
		return "GameVO [gID=" + gID + ", uID=" + uID + ", start=" + start + ", end=" + end + ", score=" + score
				+ ", hint1=" + hint1 + ", hint2=" + hint2 + ", hint3=" + hint3 + ", isSolved1=" + isSolved1
				+ ", isSolved2=" + isSolved2 + ", isSolved3=" + isSolved3 + "]";
	}
	
}
