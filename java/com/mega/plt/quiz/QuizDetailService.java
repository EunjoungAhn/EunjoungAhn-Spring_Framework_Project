package com.mega.plt.quiz;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mega.plt.pole.PoleDAO;

@Service
public class QuizDetailService {
	
	@Autowired
	QuizDetailDAO dao;
	
	@Autowired
	PoleDAO poleDao;

	public void quizDetailInsert(QuizDetailVO quizDetailVO) {
		dao.quizDetailInsert(quizDetailVO);
	}
	
	public double distance(double lat1, double lon1, double lat2, double lon2, String unit) {
		 double poleDistance = poleDao.distance(lat1, lon1, lat2, lon2, unit);
		return poleDistance;
	}
		
}
