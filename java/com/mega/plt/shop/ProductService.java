package com.mega.plt.shop;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ProductService {
	
	@Autowired
	ProductDAO dao;
	
	public void create(ProductVO vo) {
		dao.create(vo);
	}
	
	public List<ProductVO> selectAll() {
		return dao.sellectAll();
	}
	
	public ProductVO sellectOne(ProductVO vo) {
		return dao.sellectOne(vo);
	}
	
	public List<ProductVO> sellectCategory(ProductVO vo) {
		return dao.sellectCategory(vo);
	}
}
