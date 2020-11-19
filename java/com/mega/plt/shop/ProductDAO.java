package com.mega.plt.shop;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ProductDAO implements ProductInterface{

	@Autowired
	SqlSessionTemplate mybatis;
	
	@Override
	public void create(ProductVO vo) {
		mybatis.insert("product.create", vo);
	}
	
	public List<ProductVO> sellectAll() {
		List<ProductVO> list = mybatis.selectList("product.list");
		return list;
	}
	
	public List<ProductVO> sellectCategory(ProductVO vo) {
		List<ProductVO> list = mybatis.selectList("product.category", vo);
		System.out.println(list);
		return list;		
	}
	
	public ProductVO sellectOne(ProductVO vo) {
		ProductVO vo2 = mybatis.selectOne("product.one", vo);
		return vo2;
	}
	
}
