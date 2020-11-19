package com.mega.plt.car;
 

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class CarDAO implements CarInterface {

	@Autowired
	SqlSessionTemplate mybatis;
	
	/* (non-Javadoc)
	 * @see com.mega.plt.car.CarInterface#carIn(com.mega.plt.car.CarVO)
	 */
	@Override
	public void carIn(CarVO vo) {
		mybatis.insert("car.in", vo);
	}
	
	/* (non-Javadoc)
	 * @see com.mega.plt.car.CarInterface#carOut(java.lang.String)
	 */
	@Override
	public CarVO carOut(String cNum) {
		CarVO vo = mybatis.selectOne("car.one", cNum);
		System.out.println("----------------" + vo);
		return vo;
	}
	
	/* (non-Javadoc)
	 * @see com.mega.plt.car.CarInterface#carPay(com.mega.plt.car.CarVO)
	 */
	@Override
	public void carPay(CarVO vo) {
		mybatis.update("car.pay", vo);
	}
	
	/* (non-Javadoc)
	 * @see com.mega.plt.car.CarInterface#chart(java.lang.String)
	 */
	@Override
	public List<CarViewVO> chart(String outTime) {
		// 차트 찍을 리스트 가져오기
		List<CarViewVO> list = mybatis.selectList("car.chart", outTime);
		return list;
	}
	
}
