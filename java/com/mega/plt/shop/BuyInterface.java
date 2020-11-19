package com.mega.plt.shop;

import java.util.List;

public interface BuyInterface {

	//주문테이블에 저장
	int create(BuyVO vo);

	//주문상세테이블에 저장
	void createOrder(BuyVO vo);

	//카트에 주문번호 업데이트... 
	void cartNum(BuyVO vo);

	//카트에 저장된 목록 주문상세테이블에 저장 (복사) 후 삭제
	void cartOrder(BuyVO vo);

	//유저아이디로 결제내역 검색 
	List<BuyVO> buyList(BuyVO vo);

	//주문번호별 상세내역
	List<BuyVO> buyDetail(BuyVO vo);

	//포인트 합계 계산
	int point(String uID);

	void usePoint(BuyVO vo);

}