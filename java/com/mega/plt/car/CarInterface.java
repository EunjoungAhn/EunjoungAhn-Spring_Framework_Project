package com.mega.plt.car;

import java.util.List;

public interface CarInterface {

	void carIn(CarVO vo);

	CarVO carOut(String cNum);

	void carPay(CarVO vo);

	List<CarViewVO> chart(String outTime);

}