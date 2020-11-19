package com.mega.plt.util;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class VisionController {

	@Autowired
	VisionService visionService;
	@Autowired
	KepcoInterface kepcoService;
	@Autowired
	StorageInterface storageService;

	@RequestMapping("util/vision.util")
	public String goVision(Model model, @RequestParam("filepath") String filePath) {
		String uID = "aaaa"; // 세션에 잡힌 유저 아이디로 수정 예정
		
		// 1. 유저가 업로드한 파일을 클라우드에 저장하기 전에 이름 재지정
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
		String date = simpleDateFormat.format(new Date());
		String fileName = uID + "_" + date + ".jpg";
		
		// 2. 클라우드 업로드 세팅
		final String projectID = "vision-293203";
		final String bucketName = "plt_vision";
		
		// 3. 유저 사진 업로드 후 사용할 클라우드 내 파일 주소
		String realpath = "gs://plt_vision/" + fileName;

		try {
			// 1. google cloud storage에 유저가 선택한 사진 upload하는 메서드
			storageService.uploadImg(projectID, bucketName, fileName, filePath);

			// 2. cloud -> vision
			String poleNum = visionService.analysisImg(realpath); // 전봇대 번호 추출
			
			// 3. vision -> 한전api
			boolean isExist = kepcoService.isRealPole(poleNum); // 실존하는 전봇대인지 체크

			// 4. 최종 출력 결과. 각자 확인하시라고 콘솔에 출력하는 부분
			System.out.println("전봇대 번호: " + poleNum);
			System.out.println("전봇대 유무: " + isExist);

			// 5. 최종 출력 결과 넘기는 부분
			model.addAttribute("poleNum", poleNum); // ajax로 넘기는 값
			model.addAttribute("isExist", isExist); // ajax로 넘기는 값
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "util/successVision";
	}
}
