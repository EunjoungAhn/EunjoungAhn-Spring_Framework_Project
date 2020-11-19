package com.mega.plt.shop;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BuyService implements BuyInterface {

	@Autowired
	BuyDAO dao;
	
	//주문테이블에 저장
	@Override
	public int create(BuyVO vo) {				
		return dao.create(vo);
	}
	
	//주문상세테이블에 저장
	@Override
	public void createOrder(BuyVO vo) {
		int bID = dao.readBuyID(vo); //주문테이블과 같은 번호가 삽입되어야 함
		System.out.println("주문번호" + bID);
		vo.setbID(bID);
		dao.createOrder(vo);
	}
	
	//카트에 주문번호 업데이트... 
	@Override
	public void cartNum(BuyVO vo) {
		int bID = dao.readBuyID(vo); //주문테이블과 같은 번호가 삽입되어야 함
		vo.setbID(bID);		
		System.out.println("카트주문번호" + vo.getbID());
		dao.cartNum(vo);
	}
		
	//카트에 저장된 목록 주문상세테이블에 저장 (복사) 후 삭제
	@Override
	public void cartOrder(BuyVO vo) {
		int result = dao.cartOrder(vo);	
		System.out.println("카트주문정보 상세테이블에 복사 성공" + result);
		System.out.println(vo.getbID());
		System.out.println("카트정보 복사" + result);
		if (result != 0) {
			dao.deleteCart(vo);
		}
	}	
	
	//유저아이디로 결제내역 검색 
	@Override
	public List<BuyVO> buyList(BuyVO vo) {
		return dao.buyList(vo);
	}	
	
	//주문번호별 상세내역
	@Override
	public List<BuyVO> buyDetail(BuyVO vo) {
		return dao.buyDetail(vo);
	}
	
	//포인트 합계 계산
	@Override
	public int point(String uID) {
		int result = dao.userPoint(uID);
		int sumpoint = 0; //기본값 0
		if (result != 0) { // 포인트 테이블에 값이 있는경우 합계 구한다
			sumpoint = dao.point(uID);
		}
		return sumpoint;
	}
	
	@Override
	public void usePoint(BuyVO vo) {
		dao.usePoint(vo);
	}
}
