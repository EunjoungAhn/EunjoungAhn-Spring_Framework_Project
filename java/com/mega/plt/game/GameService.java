package com.mega.plt.game;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class GameService {

	@Autowired
	GameDAO gameDAO;

	public int searchProgress(ProgressParamVO progressParamVO) {
	
		GamedetailVO gamedetailVO = gameDAO.searchProgress(progressParamVO);
		
		if(gamedetailVO != null) {			
			return gamedetailVO.getIsSolved1() + gamedetailVO.getIsSolved2() + gamedetailVO.getIsSolved3();
		}else {
			return -1;
		}

	}

	public boolean insertRecord(ProgressParamVO progressParamVO) {
		return gameDAO.insertRecord(progressParamVO);
	}

	public GameVO getRecord(ProgressParamVO progressParamVO) {
		return gameDAO.getRecord(progressParamVO);
	}

	public int updateHintChance(HintParamVO hintParamVO) {
		hintParamVO.setHintcol("hint" + hintParamVO.getHintcol());
		return gameDAO.updateHintChance(hintParamVO);
	}

	public int updateIsSolved(SolvedParamVO solvedParamVO) {
		solvedParamVO.setSolvedCol("isSolved" + solvedParamVO.getSolvedCol());
		return gameDAO.updateIsSolved(solvedParamVO);
	}
	
	//game테이블의 score 업데이트 후 , point테이블 insert 실패시 rollback
	@Transactional
	public boolean updateScore(UpdateScoreParamVO updateScoreParamVO, InsertPointParamVO insertPointParamVO) {
		boolean result = false;
		int rowup = gameDAO.updateScore(updateScoreParamVO);
		int rowin = gameDAO.insertPoint(insertPointParamVO);
		if((rowup + rowin) == 2) {
			result = true;
		}
		return result;
	}

}
