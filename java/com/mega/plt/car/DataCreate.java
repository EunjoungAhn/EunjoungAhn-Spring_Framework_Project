package com.mega.plt.car;

import java.util.Random;

public class DataCreate {

	public static void main(String[] args) {
		// cNum, inTime, outTime, price, payment
		Random r = new Random();
		String inTime;
		String outTime;
		int tt;
//		int a = r.nextInt(32);
//		int a1 = r.nextInt(99)+1;
//		String[] a2 = {"가", "나", "다", "라", "마", "거", "너", "더", "러", "머", "버", "서", "어", "저",
//				"고", "노", "도", "로", "모", "보", "소", "오", "조", "구", "누","두", "루", "무", "부", "수", "우", "주"};
//		System.out.println(a1 + a2[a] + a3 + "");
//		System.out.println(a2.length);
		
		// cNum, phone, inTime, outTime, price, pay
		// ('1234', '01012345678', '2020-01-01 00:00:00', '2020-01-01 00:00:00', 이건계산, true
		for (int i = 0; i < args.length; i++) {
			
		}
		
		// DATETIME
		for (int i = 1; i <= 31; i++) {
			for (int j = 0; j < 15; j++) { // 하루에 15대...
				int cNum = randomRange(1111, 9999); // 1111 ~ 9999
				int phone = randomRange(11111111, 99999999); // 11111111 ~ 99999999
				int time = randomRange(0, 23); // 0시 ~ 23시
				int rand = randomRange(1, 5);
				tt = time + rand;
				inTime = "2020-10-" + i + " " + time + ":00:00";
				outTime = "2020-10-" + i + " " + tt + ":00:00";
				if (tt >= 24) {
					outTime = "2020-10-" + (i+1) + " 0" + (tt-24) + ":00:00";
					if ((i+1) >= 32) {
						continue;
					}
				}
				int price = ((time+rand) - time) * 4000;
				System.out.println("(NULL, \'" + cNum + "\', \'010" + phone + "\', \'" + inTime + "\', \'" + outTime + "\', " + price + ", TRUE), ");
			}
		}
		
		
		
	}
	
	public static int randomRange(int min, int max) {
		Random r = new Random();
		return r.nextInt((max - min) + 1) + min;
	}

}
