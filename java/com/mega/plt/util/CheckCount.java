package com.mega.plt.util;

public class CheckCount {
	static int count;
	
	public static int checkCount(int count) {
		CheckCount.count += count;
		return CheckCount.count;
	}
	
	public static void resetCount() {
		count = 0;
	}
}
