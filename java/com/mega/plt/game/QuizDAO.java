package com.mega.plt.game;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class QuizDAO implements QuizInterface {
	
	@Autowired
	SqlSessionTemplate mybatis;

	@Override
	public List<SearchQuizVO> searchAllQuiz() {
		
		return mybatis.selectList("quiz.selectAllQuiz");	
	}

	@Override
	public QuizVO selectQuiz(SelectQuizParamVO selectQuizParamVO) {
		return mybatis.selectOne("quiz.selectQuiz", selectQuizParamVO);
	}

	
}
