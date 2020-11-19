package com.mega.plt.user;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class UserDAO implements UserInterface{

	@Autowired
	SqlSessionTemplate mybatis;
	
	@Override
	public int create(UserVO vo) {
		int result = mybatis.insert("user.create", vo);
		return result;
	}
	
	public UserVO read(UserVO vo) {
		UserVO userVO = mybatis.selectOne("user.read", vo);
		return userVO;
	}
	
	public int readUID(String uID) {
		int result = mybatis.selectOne("user.readUID", uID);
		return result;
	}
}
