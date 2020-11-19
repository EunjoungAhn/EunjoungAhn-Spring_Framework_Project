package com.mega.plt.shop;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CartService {

	@Autowired
	CartDAO dao;

	public int create(CartVO vo) {
		return dao.create(vo);
	}

	public int update(CartVO vo) {
		if (vo.getCnt() > 0) { //수량이 0이상일때에만 업데이트
			dao.update(vo);			
		} else {
			vo.setCnt(1); 
		}
		System.out.println(vo.getCnt());
		return dao.update(vo);
	}

	public int total (CartVO vo) {
		return dao.total(vo);
	}

	public int delete(CartVO vo) {
		return dao.delete(vo);
	}

	public int usercart(CartVO vo) {
		return dao.usercart(vo);
	}

	public List<CartVO> read(CartVO vo) {
		return dao.read(vo);

	}

}