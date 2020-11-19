package com.mega.plt.faq;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class PointDAO {
	
	@Autowired
	SqlSessionTemplate mybatis;
	
	public List<PointVO> quick() {
		return mybatis.selectList("faq.list");
	}
	
	public List<PointVO> find(int score) {
		return mybatis.selectList("faq.find", score);
	}
	
	public List<PointVO> list() {
		List<PointVO> pointList = mybatis.selectList("faq.scoreList");
		return pointList;
	}
	
	//score를 기준으로 DB에서 uID를 검색해주는 함수 
	public List<PointVO> uIDSearch(int score) {
		List<PointVO> idList = mybatis.selectList("faq.idList", score);
		return idList;
	}
}
