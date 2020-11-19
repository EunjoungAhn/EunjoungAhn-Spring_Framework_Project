package com.mega.plt.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mega.plt.util.CheckCount;

@Service
public class UserService {
	
	@Autowired
	UserDAO dao;
	
	public int create(UserVO vo) {
		return dao.create(vo);
	}
	
	public UserVO read(UserVO vo) {
		return dao.read(vo);
	}
	
	public int readUID(String uID) {
		int result = dao.readUID(uID);
		
		if (result == 1) { // 아이디는 있는 경우
			int count = CheckCount.checkCount(result);
			
			if (count > 4) { // 테스트 버전은 3번
				danger();
				CheckCount.resetCount();
				return 1;
			}
		}
		return 0;
	}
	
	public void danger() {
		System.out.println("누군가 해킹 시도..");
	}
}
