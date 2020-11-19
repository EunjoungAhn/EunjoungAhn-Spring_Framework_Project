package com.mega.plt.shop;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class ProductController {

	@Autowired
	ProductService service;
	
	@RequestMapping("shop/create.do")
	public void create(ProductVO vo) {
		service.create(vo);
	}	
	
	@RequestMapping("shop/list.do")
	public void productList(Model model) {
		List<ProductVO> list = service.selectAll();
		model.addAttribute("list", list);
	}
			
	@RequestMapping("shop/detail.do")
	public void productDetail(ProductVO productVO, Model model) {
		ProductVO vo = service.sellectOne(productVO);
		model.addAttribute("vo", vo);
	}
	
	@RequestMapping("shop/category.do")
	public void productCatogory(ProductVO productVO, Model model) {
		List<ProductVO> list = service.sellectCategory(productVO);
		model.addAttribute("list", list);
	}

	
}
