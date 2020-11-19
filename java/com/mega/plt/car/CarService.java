package com.mega.plt.car;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CarService {

	@Autowired
	CarInterface dao;

	static QueueCreate que = new QueueCreate(30); // 주차 총 공간

	public void carIn(CarVO vo) {
		que.enque(vo.getcNum());
		System.out.println("vo.getcNum():" + vo.getcNum());
		dao.carIn(vo); // 뭐가 됐던 dao는 한번만
	}

	// 결제 할 자동차 정보
	public CarVO carOut() throws Exception {
		String i = que.q_front(); // 첫번째 값을 가져옴
		System.out.println(i + "가 들어있어요..............");
		if (i == null) {
			return null;
		} else {
			return dao.carOut(i);
		}
	}

	// 결제합니다
	public void carPay(CarVO vo) {
		// String i = que.q_front();
		que.deque(); // 첫번째 값을 뺌
		dao.carPay(vo); // 화면에 찍은 cID를 기준으로 dao에서 처리
		System.out.println(que.dump()); // 뭐가 남았는지 다 찍어
	}

	public int carPresent() {
		return que.size();
	}

	public List<String> chartMonth() {
		List<CarViewVO> list = null; // 값 가져올 리스트
		List<String> ch = new ArrayList<String>();
		String month = null;
		int day = 0; // 일 수
		
		for (int i = 1; i <= 10; i++) {
			int price = 0;
			if (i != 10) {
				month = "0" + i;
			} else {
				month = Integer.toString(i);
			}
			list = dao.chart(month);
			
			if (month.equals("02")) {
				day = 29;
			} else if (month.equals("04") || month.equals("06") || month.equals("09")) {
				day = 30;
			} else {
				day = 31;
			}

			System.out.println("LIST에는 " + list.size() + "개가 존재!!");
			System.out.println("처리할게요!");

			for (int j = 0; j < list.size(); j++) {
				CarViewVO vo = list.get(j);
				price += vo.getPrice();
			}
			// 나와야 총 매출액을 찍음...
			System.out.println(i + "달 검색하신 달의 평균 매출: " + price/day);
			ch.add(Integer.toString(price/day));
			System.out.println("저장하고있어요!!");
		}
		return ch;
	}
	
	public List<String> chartDay(String outTime) {
		List<CarViewVO> list = null;
		List<String> ch = new ArrayList<String>();
		int day = 0; // 일 수
		String day2 = null; // 일 수
		
		if (outTime.equals("02")) {
			day = 29;
		} else if (outTime.equals("04") || outTime.equals("06") || outTime.equals("09")) {
			day = 30;
		} else {
			day = 31;
		}
		
		for (int i = 1; i <= day; i++) {
			int price = 0;
			if (i < 10) {
				day2 = outTime + "-0" + i;
			} else {
				day2 = outTime + "-" + i; // 11-16
			}
			System.out.println("@@@@@@@@@@@@@@@" + day2);
			list = dao.chart(day2);
			System.out.println("LIST에는 " + list.size() + "개가 존재!!");
			for (int j = 0; j < list.size(); j++) {
				CarViewVO vo = list.get(j);
				price += vo.getPrice();
			}
			// 나와야 총 매출액을 찍음...
			System.out.println(i + "검색하신 날의 매출: " + price);
			ch.add(Integer.toString(price));
			System.out.println("저장하고있어요!!");
			System.out.println("");
		}
		return ch;
	}
	
	public List<String> chartHours(String outTime) {
		List<CarViewVO> list = null;
		List<String> ch = new ArrayList<String>();
		String hours = null; // 일 수
		
		for (int i = 0; i <= 23; i++) {
			int price = 0;
			if (i < 10) {
				hours = outTime + " 0" + i;
			} else {
				hours = outTime + " " + i; 
			}
			System.out.println("@@@@@@@@@@@@@@@" + hours);
			list = dao.chart(hours);
			System.out.println("LIST에는 " + list.size() + "개가 존재!!");
			for (int j = 0; j < list.size(); j++) {
				CarViewVO vo = list.get(j);
				price += vo.getPrice();
			}
			// 나와야 총 매출액을 찍음...
			System.out.println(i + "검색하신 날의 매출: " + price);
			ch.add(Integer.toString(price));
			System.out.println("저장하고있어요!!");
			System.out.println("");
		}
		return ch;
	}

}
