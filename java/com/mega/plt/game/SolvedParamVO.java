package com.mega.plt.game;

public class SolvedParamVO {
	private String solvedCol;
	private int gID;
	public String getSolvedCol() {
		return solvedCol;
	}
	public void setSolvedCol(String solvedCol) {
		this.solvedCol = solvedCol;
	}
	public int getgID() {
		return gID;
	}
	public void setgID(int gID) {
		this.gID = gID;
	}
	@Override
	public String toString() {
		return "SolvedParamVO [solvedCol=" + solvedCol + ", gID=" + gID + "]";
	}
	
}
