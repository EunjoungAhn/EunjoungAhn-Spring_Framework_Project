package com.mega.plt.game;

public class HintParamVO {
	private String hintcol;
	private int gID;
	public String getHintcol() {
		return hintcol;
	}
	public void setHintcol(String hintcol) {
		this.hintcol = hintcol;
	}
	public int getgID() {
		return gID;
	}
	public void setgID(int gID) {
		this.gID = gID;
	}
	@Override
	public String toString() {
		return "HintParamVO [hintcol=" + hintcol + ", gID=" + gID + "]";
	}
	
}
