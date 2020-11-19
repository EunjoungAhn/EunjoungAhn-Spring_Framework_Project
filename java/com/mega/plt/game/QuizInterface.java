package com.mega.plt.game;

import java.util.List;

public interface QuizInterface {
	
	public List<SearchQuizVO> searchAllQuiz();
	public QuizVO selectQuiz(SelectQuizParamVO selectQuizParamVO);
	

}
