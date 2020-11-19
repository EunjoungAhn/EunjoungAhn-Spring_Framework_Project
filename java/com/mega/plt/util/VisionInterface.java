package com.mega.plt.util;

import java.util.List;

import com.google.cloud.vision.v1.AnnotateImageResponse;

public interface VisionInterface {
	String analysisImg(String fileName) throws Exception; // 이미지파일 받아서 비전으로 텍스트읽어오기
	String getTextDetection(List<AnnotateImageResponse> responses); // 읽어온 텍스트 중 문자열 골라서 리스트에 넣기
	String doFiltering(List<String> list); // 리스트에서 특수문자, 한글 제외하기
	String pickPoleNum(String word);
}
