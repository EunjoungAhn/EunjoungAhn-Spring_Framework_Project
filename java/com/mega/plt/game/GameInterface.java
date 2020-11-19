package com.mega.plt.game;

public interface GameInterface {
	
	public GamedetailVO searchProgress(ProgressParamVO progressParamVO);
	public boolean insertRecord(ProgressParamVO progressParamVO);
	public GameVO getRecord(ProgressParamVO progressParamVO);
	public int updateHintChance(HintParamVO hintParamVO);
	public int updateIsSolved(SolvedParamVO solvedParamVO);
	public int updateScore(UpdateScoreParamVO updateScoreParamVO);
	public int insertPoint(InsertPointParamVO insertPointParamVO);
}
