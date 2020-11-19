package com.mega.plt.quiz;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class QuizSetDAO implements QuizSetInterface {

	@Autowired
	SqlSessionTemplate mybatis;
	
	public void quizSetInsert(Object object) {
		mybatis.insert("quiz.quizSetInsert", object);
	}

	@Override
	public String quizSetHint1(QuizSetVO quizSetVO, QuizDetailVO quizDetailVO, HttpSession session,
			HttpServletRequest request) {
		return null;
	}

	@Override
	public String quizSetHint2(QuizDetailVO quizDetailVO, HttpSession session, HttpServletRequest request) {
		return null;
	}

	@Override
	public String quizSetHint3(QuizDetailVO quizDetailVO, HttpSession session, HttpServletRequest request) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String quizSetResult(QuizSetVO quizSetVO, HttpSession session, HttpServletRequest request) {
		// TODO Auto-generated method stub
		return null;
	}
	
}