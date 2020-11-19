package com.mega.plt.game;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class GameController {

	@Autowired
	GameService gameService;

	//퀴즈셋에 대한 기록검색
	@RequestMapping("game/searchProgress.game")
	public void searchProgress(ProgressParamVO progressParamVO, Model model) {
		System.out.println("================ searchProgress.game received vo : " + progressParamVO + " =================");
		int progress = gameService.searchProgress(progressParamVO);
		System.out.println("진행도 검색 컨트롤러 리턴값 progress: " + progress);
		model.addAttribute("progress", progress);
	}
	
	//퀴즈셋 선택 후 첫 도전일때 기록 초기화
	@RequestMapping("game/insertRecord.game")
	public void insertRecord(ProgressParamVO progressParamVO, Model model) {
		System.out.println("================ insertRecord.game received vo : " + progressParamVO + " =================");
		boolean result = gameService.insertRecord(progressParamVO);
		System.out.println("return in insertRecord.game : " + result);
		model.addAttribute("result", result);
	}
	
	@RequestMapping("game/getRecord.game")
	@ResponseBody
	public GameVO getRecord(ProgressParamVO progressParamVO, Model model) {
		System.out.println("gameVO: "+gameService.getRecord(progressParamVO));
		return gameService.getRecord(progressParamVO);
	}
	
	@RequestMapping("game/updateHintChance.game")
	public void updateHintChance(HintParamVO hintParamVO, Model model) {
		System.out.println("================ updateHintChance.game received vo : " + hintParamVO + " =================");
		int row = gameService.updateHintChance(hintParamVO);
		boolean result = false;
		if(row == 1) {
			result = true;
			System.out.println("hint 기회 update 성공");
		}else {
			System.out.println("hint 기회 update 실패");
		}
		model.addAttribute("updateHintResult", result);
	}
	
	@RequestMapping("game/updateIsSolved.game")
	public void updateIsSolved(SolvedParamVO solvedParamVO, Model model) {
		boolean result = false;
		System.out.println("================ updateIsSolved.game received vo : " + solvedParamVO + " =================");
		int row = gameService.updateIsSolved(solvedParamVO);
		if(row == 1) {
			result = true;
		}else {
			result = false;
		}
		model.addAttribute("result", result);
	}
	
	@RequestMapping("game/updateScore.game")
	public void updateScore(UpdateScoreParamVO updateScoreParamVO, InsertPointParamVO insertPointParamVO, Model model) {
		boolean result = gameService.updateScore(updateScoreParamVO, insertPointParamVO);
		model.addAttribute("result", result);
	}
	
}
