package com.mega.plt.shop;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class CartController {

	@Autowired
	CartService service;

	@RequestMapping("shop/addCart.do")
	@ResponseBody
	public boolean insertCart(CartVO vo) {
		boolean messege = false;
		// 장바구니에 목록에서 유저 & 상품 아이디로 검색해서 개수가 0일때만 카트 추가
		int usercart = service.usercart(vo);
		if (usercart == 0) {
			int result = service.create(vo);
			if (result == 1) {
				messege = true;
			}
		}
		return messege;
	}

	@RequestMapping("shop/update.do")
	public String update(CartVO vo) {
		int result = service.update(vo);
		if (result == 1) {
			return "redirect:cart.do?uID=" + vo.getuID();
		} else {
			return "fail";// views/fail.jsp호출
		}
	}

	@RequestMapping("shop/delete.do")
	public String delete(CartVO vo) {
		int result = service.delete(vo);
		if (result == 1) {
			return "redirect:cart.do?uID=" + vo.getuID();
		} else {
			return "fail";// views/fail.jsp호출
		}

	}

	@RequestMapping("shop/cart.do")
	public void cartList(CartVO vo, Model model) {
		List<CartVO> list = service.read(vo);
		
		// 카트에 담긴 물건이 없으면.. 토탈금액 계산하지 말것
		if (list.size() > 0) {
			int total = service.total(vo);
			vo.setTotal(total);
			System.out.println("총금액" + vo.getTotal());
			model.addAttribute("total", total);			
			String name = "";
			for (int i = 0; i < list.size(); i++) {
				name = list.get(i).getName();
				System.out.println(name);
			}
			model.addAttribute("list", list);
			model.addAttribute("name", list.get(0).getName()); //카트 첫번째 물건 이름
			model.addAttribute("cart", "장바구니");
		}else {
			model.addAttribute("cart", "장바구니가 비어있습니다");
		}

		
	}

}
