package com.mega.plt.game;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class QuizService {
	
	@Autowired
	QuizDAO quizDAO;
	
	public List<SearchQuizVO> searchAllQuiz(){
		return quizDAO.searchAllQuiz();
	}
	
	public QuizVO selectQuiz(SelectQuizParamVO selectQuizParamVO) {
		return quizDAO.selectQuiz(selectQuizParamVO);
	}

}
