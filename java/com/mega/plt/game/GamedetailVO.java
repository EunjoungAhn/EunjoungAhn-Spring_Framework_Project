package com.mega.plt.game;

public class GamedetailVO {
	private int gdID; //게임디테일 아이디
	private int gID; //게임아이디
	private int hint1; //1힌트 사용여부
	private int hint2; //2힌트 사용여부
	private int hint3; //3힌트 사용여부
	private int isSolved1; //1번째 문제 해결여부
	private int isSolved2; //2번째 문제 해결여부
	private int isSolved3; //3번째 문제 해결여부
	public int getGdID() {
		return gdID;
	}
	public void setGdID(int gdID) {
		this.gdID = gdID;
	}
	public int getgID() {
		return gID;
	}
	public void setgID(int gID) {
		this.gID = gID;
	}
	public int getHint1() {
		return hint1;
	}
	public void setHint1(int hint1) {
		this.hint1 = hint1;
	}
	public int getHint2() {
		return hint2;
	}
	public void setHint2(int hint2) {
		this.hint2 = hint2;
	}
	public int getHint3() {
		return hint3;
	}
	public void setHint3(int hint3) {
		this.hint3 = hint3;
	}
	public int getIsSolved1() {
		return isSolved1;
	}
	public void setIsSolved1(int isSolved1) {
		this.isSolved1 = isSolved1;
	}
	public int getIsSolved2() {
		return isSolved2;
	}
	public void setIsSolved2(int isSolved2) {
		this.isSolved2 = isSolved2;
	}
	public int getIsSolved3() {
		return isSolved3;
	}
	public void setIsSolved3(int isSolved3) {
		this.isSolved3 = isSolved3;
	}
	@Override
	public String toString() {
		return "GamedetailVO [gdID=" + gdID + ", gID=" + gID + ", hint1=" + hint1 + ", hint2=" + hint2 + ", hint3="
				+ hint3 + ", isSolved1=" + isSolved1 + ", isSolved2=" + isSolved2 + ", isSolved3=" + isSolved3 + "]";
	}
	
	
	
}
