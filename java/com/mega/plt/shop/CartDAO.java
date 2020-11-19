package com.mega.plt.shop;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CartDAO {
	
	@Autowired
	SqlSessionTemplate mybatis;
	
	
	public int create(CartVO vo) {
		int result = mybatis.insert("cart.create", vo);
		return result;
	}
	
	public int update(CartVO vo) {
		int result = mybatis.update("cart.update", vo);
		return result;
	}
	
	public int delete(CartVO vo) {
		int result = mybatis.delete("cart.delete", vo);
		return result;
	}
	
	public int total(CartVO vo) {
		int total = mybatis.selectOne("cart.total", vo);
		return total;
	}
	
	public int usercart(CartVO vo) {
		int result = mybatis.selectOne("cart.read", vo);
		System.out.println("dao" + result);
		return result;
	}
	
	
	public List<CartVO> read(CartVO vo) {
		List<CartVO> list = mybatis.selectList("cart.list", vo);
		return list;
	}


}
