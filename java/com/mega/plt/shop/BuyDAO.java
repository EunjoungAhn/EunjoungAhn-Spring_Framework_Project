package com.mega.plt.shop;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BuyDAO {

	@Autowired
	SqlSessionTemplate mybatis;

	public int create(BuyVO vo) {
		int result = mybatis.insert("buy.create", vo);
		return result;
	}

	public void createOrder(BuyVO vo) {
		mybatis.insert("buy.detail", vo);
	}

	public int readBuyID(BuyVO vo) {
		int bID = mybatis.selectOne("buy.bID", vo);
		return bID;
	}

	public int cartOrder(BuyVO vo) {
		int result = mybatis.insert("buy.cart", vo);
		return result;
	}

	public void cartNum(BuyVO vo) {
		mybatis.update("buy.cartnum", vo);
	}

	public void deleteCart(BuyVO vo) {
		mybatis.delete("buy.deleteCart", vo);
	}

	public List<BuyVO> buyList(BuyVO vo) {
		List<BuyVO> list = mybatis.selectList("buy.list", vo);
		return list;
	}
	
	//주문번호당 상품 여러개 이므로 리스트로 가져와야하네......
	public List<BuyVO> buyDetail(BuyVO vo) {
		List<BuyVO> list = mybatis.selectList("buy.orderdetail", vo);
		return list;
	}
	
	public int userPoint(String uID) {
		int result = mybatis.selectOne("buy.userpoint", uID);
		return result;
	}
	
	public int point(String uID) {
		int result = mybatis.selectOne("buy.point", uID);
		System.out.println(result);
		return result;
	}

	public void usePoint(BuyVO vo) {
		mybatis.insert("buy.usePoint", vo);
	}

}
