package com.mega.plt.quiz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.mega.plt.pole.PoleDAO;
import com.mega.plt.pole.PoleVO;

@Service
public class QuizSetService {

	@Autowired
	QuizSetDAO dao;
	
	@Autowired
	QuizDetailDAO detailDao;
	
	@Autowired
	PoleDAO poleDAO;
	
	public void quizSetInsert(Object object) {
		dao.quizSetInsert(object);
	}
	
	public void quizDetailInsert(QuizDetailVO qdvo) {
		detailDao.quizDetailInsert(qdvo);
	}
	
	public List<PoleVO> poleList(String pID) {
		return poleDAO.poleList(pID);
	}
	
}