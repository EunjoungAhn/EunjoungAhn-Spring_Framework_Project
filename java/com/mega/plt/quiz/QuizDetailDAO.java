package com.mega.plt.quiz;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class QuizDetailDAO implements QuizDetailInterface{

	@Autowired
	SqlSessionTemplate mybatis;

	public void quizDetailInsert(QuizDetailVO quizDetailVO) {
		mybatis.insert("quizDetail.quizDetailInsert", quizDetailVO);
	}


}
