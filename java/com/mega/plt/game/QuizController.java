package com.mega.plt.game;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class QuizController {

	@Autowired
	QuizService quizService;

	@RequestMapping("game/searchAllQuiz.quiz")
	@ResponseBody
	public List<SearchQuizVO> searchAllQuize() {
		List<SearchQuizVO> list = quizService.searchAllQuiz();
		System.out.println("controller list size: " + list.size());

		for (int i = 0; i < list.size(); i++) {
			System.out.println(list.get(i));
		}

		return list;
	}
	
	@RequestMapping("game/selectQuiz.quiz")
	@ResponseBody
	public QuizVO selectQuiz(SelectQuizParamVO selectQuizParamVO) {
		System.out.println();
		System.out.println(selectQuizParamVO);
		System.out.println();
		return quizService.selectQuiz(selectQuizParamVO);
	}
}
