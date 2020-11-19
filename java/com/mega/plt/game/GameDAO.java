package com.mega.plt.game;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class GameDAO implements GameInterface {

	@Autowired
	SqlSessionTemplate mybatis;

	//진행도 검색
	@Override
	public GamedetailVO searchProgress(ProgressParamVO progressParamVO) {
		System.out.println("dao param vo: " + progressParamVO);
		GamedetailVO gamedetailVO =  mybatis.selectOne("game.searchProgress", progressParamVO);
		return gamedetailVO;
	}

	//첫 도전시 처리해야할 하나의 트랜젝션 (game테이블 insert & gamedetail테이블 insert)
	@Override
	public boolean insertRecord(ProgressParamVO progressParamVO) {
		boolean result = false;
		int row1 = mybatis.insert("game.insertGame", progressParamVO); //게임테이블 insert
		int row2 = 0;
		if(row1 == 1) {	//부모 테이블 insert 성공시 에만 서브 테이블 insert
			//서브 테이블 insert를 위한 gID검색
			int gID = mybatis.selectOne("game.selectRecentGame", progressParamVO.getuID());
			row2 = mybatis.insert("game.insertGameDetail", gID); //게임 서브 테이블 insert
		}
		if(row1 + row2 > 1) {
			result = true;
		}
		return result;
	}

	//기록검색 
	@Override
	public GameVO getRecord(ProgressParamVO progressParamVO) {
		return mybatis.selectOne("game.getRecord", progressParamVO);
	}

	//힌트 사용 기회 차감 입력: gID, hint1 or hint2
	@Override
	public int updateHintChance(HintParamVO hintParamVO) {
		return mybatis.update("game.updateHintChance", hintParamVO);
	}

	@Override
	public int updateIsSolved(SolvedParamVO solvedParamVO) {
		return mybatis.update("game.updateIsSolved", solvedParamVO);
	}

	@Override
	public int updateScore(UpdateScoreParamVO updateScoreParamVO) {
		return mybatis.update("game.updateScore", updateScoreParamVO);
	}

	@Override
	public int insertPoint(InsertPointParamVO insertPointParamVO) {
		return mybatis.insert("game.insertPoint", insertPointParamVO);
	}
	
	

}
