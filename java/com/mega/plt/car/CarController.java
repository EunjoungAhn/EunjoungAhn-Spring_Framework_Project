package com.mega.plt.car;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
public class CarController {

	@Autowired
	CarService service;
	
	// 자동차가 새로 들어옴
	@RequestMapping("car/carIn.do")
	public void carIn(CarVO carVO) {
		service.carIn(carVO);
	}
	
	// 현재 주차장 상황
	@RequestMapping("car/present.do")
	public String present(Model model) {
		int num = service.carPresent();
		model.addAttribute("num", num);
		return "car/num";
	}
	
	// 자동차가 나감
	@RequestMapping("car/out.do")
	public String carOut(Model model) throws Exception {
		CarVO vo = service.carOut();
		int price = 0; // 가격
		// 최초 30분은 무료, 30분에 2000원으로 책정함
		if (vo != null) {
			model.addAttribute("one", vo);
			SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");
			
			Date d1 = sdf.parse(vo.getInTime()); // 들어온 시간
			Date d2 = new Date(); // 나가는 시간(현재 시간)
			
			System.out.println("d1: " + d1);
			System.out.println("d2: " + d2);
			
			long diff = d2.getTime() - d1.getTime();
			long minutes = diff / (1000*60) % 60; // 분
			long hour = diff / (1000*60*60) % 24; // 시
			
//			System.out.println("seconds? " + diff / 1000 % 60); // 초
			System.out.println("minues? " + minutes); // 분
			System.out.println("hour: " + hour); // 시
			
			
			if (((int)minutes%30) != 0) { // 30분이후에는 한 번 더 내야함
				price = (int)hour * 4000 + ((int)minutes/30) * 2000 + 2000; // 40분있는 경우와 50분 있는 경우와 동일
			} else {
				price = (int)hour * 4000 + ((int)minutes/30) * 2000; 
			}
		}
		
		model.addAttribute("price", price);
		
		return "car/out";
	}
	
	// 결제합니다..
	@RequestMapping("car/pay.do")
	public String carPay(CarVO carVO, Model model) {
		service.carPay(carVO);
		return "car/pay";
	}
	
	@RequestMapping("car/pos.do")
	public void carPos() {
		
	}
	
	@RequestMapping("car/chartMonth.do")
	@ResponseBody
	public List<String> carChart() {
		List<String> list = service.chartMonth();
		return list;
	}
	
	@RequestMapping("car/chartDay.do")
	@ResponseBody
	public List<String> carChartDay(String outTime) {
		List<String> list = service.chartDay(outTime);
		return list;
	}
	
	@RequestMapping("car/chartHours.do")
	@ResponseBody
	public List<String> carChartHours(String outTime) {
		List<String> list = service.chartHours(outTime);
		return list;
	}
	
	
	
}
