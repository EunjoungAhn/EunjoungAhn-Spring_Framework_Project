package com.mega.plt.shop;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class BuyController {

	@Autowired
	BuyInterface service;

	// 일반 단일제품 주문
	@RequestMapping("shop/pay2.do")
	public void create(BuyVO vo) {

		int buy = service.create(vo); // 부모테이블에 먼저 저장 (주문정보)
		if (buy == 1) {
			service.createOrder(vo); // 자식테이블에 저장 (주문상세)
			if (vo.getScore() != 0) { // 사용포인트가 있을경우만 디비저장 (-값)
				service.usePoint(vo);
			}
		}
	}

	// 카트에서 여러개 제품 주문
	@RequestMapping("shop/cartpay2.do")
	public void cartOrder(BuyVO vo) {
		int buy = service.create(vo); // 주문테이블에 저장
		if (buy == 1) {
			service.cartNum(vo); // 주문번호 업데이트
			service.cartOrder(vo); // 카트테이블에서 복사해서 주문상세테이블에 저장후 삭제
			if (vo.getScore() != 0) { // 사용포인트가 있을경우만 디비저장 (-값)
				service.usePoint(vo);
			}
		}

	}

	// 주문리스트
	@RequestMapping("shop/buylist.do")
	public void buyList(BuyVO vo, Model model) {
		List<BuyVO> list = service.buyList(vo);		
		model.addAttribute("list", list);		
		//주문번호 별 제목 달아주기
		int orderNum = 0;
		for (int i = 0; i < list.size(); i++) {
			orderNum = list.get(i).getbID();			
			System.out.println(orderNum);
			vo.setbID(orderNum);
			List<BuyVO> title = service.buyDetail(vo);
			String name="";
			for (int j = 0; j < title.size(); j++) {
				//System.out.println(title.get(j).getName());
			}
			if (title.size()==1) {
				name = title.get(0).getName();				
			}else {
				name = title.get(0).getName() + " 포함 " + title.size() + "건";
			}			
			//System.out.println(name);
			list.get(i).setName(name);		
		}
		
	}

	// 주문번호별 상세내역
	@RequestMapping("shop/buydetail.do")
	public void buyDetail(BuyVO vo, Model model) {
		List<BuyVO> list = service.buyDetail(vo);		
		model.addAttribute("list", list);
	}

	// 보유포인트 조회 (합계)
	@ResponseBody
	@RequestMapping("shop/point.do")
	public int point(String uID) {
		int result = service.point(uID);
		System.out.println(result);
		return result;
	}

}
