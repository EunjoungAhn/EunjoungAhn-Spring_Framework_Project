package com.mega.plt.quiz;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public interface QuizSetInterface {

	// 1번째 문제 만들기 담당 컨트롤
	String quizSetHint1(QuizSetVO quizSetVO, QuizDetailVO quizDetailVO, HttpSession session,
			HttpServletRequest request);

	// 2번째 문제 만들기 담당 컨트롤
	String quizSetHint2(QuizDetailVO quizDetailVO, HttpSession session, HttpServletRequest request);

	// 3번째 문제 만들기 담당 컨트롤
	String quizSetHint3(QuizDetailVO quizDetailVO, HttpSession session, HttpServletRequest request);

	// 마지막 DB 등록 전 문제 화면 담당 컨트롤
	String quizSetResult(QuizSetVO quizSetVO, HttpSession session, HttpServletRequest request);

}