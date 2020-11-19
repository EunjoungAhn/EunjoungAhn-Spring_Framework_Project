package com.mega.plt.util;

import java.io.FileWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.stereotype.Service;

import com.google.cloud.vision.v1.AnnotateImageRequest;
import com.google.cloud.vision.v1.AnnotateImageResponse;
import com.google.cloud.vision.v1.AsyncBatchAnnotateImagesRequest;
import com.google.cloud.vision.v1.AsyncBatchAnnotateImagesResponse;
import com.google.cloud.vision.v1.BatchAnnotateImagesResponse;
import com.google.cloud.vision.v1.EntityAnnotation;
import com.google.cloud.vision.v1.Feature;
import com.google.cloud.vision.v1.GcsDestination;
import com.google.cloud.vision.v1.Image;
import com.google.cloud.vision.v1.ImageAnnotatorClient;
import com.google.cloud.vision.v1.ImageSource;
import com.google.cloud.vision.v1.OutputConfig;
import com.google.protobuf.ByteString;

@Service
public class VisionService implements VisionInterface {

	// 1. 이미지 주소를 image 객체로 만들어서 비전에 연결 후 텍스트 피쳐 추출해오기
	@Override
	public String analysisImg(String filepath) throws Exception {
		List<AnnotateImageResponse> responses = null;
		
		try (ImageAnnotatorClient imageAnnotatorClient = ImageAnnotatorClient.create()) { // 자바7부터 추가된 try()..리소스 알아서 정리해준다고 함
			ImageSource source = ImageSource.newBuilder().setImageUri(filepath).build();
			Image image = Image.newBuilder().setSource(source).build();

			List<AnnotateImageRequest> requests = new ArrayList<>();
			Feature feature = Feature.newBuilder().setType(Feature.Type.TEXT_DETECTION).build();
			AnnotateImageRequest imageRequest = AnnotateImageRequest.newBuilder().addFeatures(feature).setImage(image).build();

			requests.add(imageRequest);

			try (ImageAnnotatorClient client = ImageAnnotatorClient.create()) {
				BatchAnnotateImagesResponse response = client.batchAnnotateImages(requests);
				responses = response.getResponsesList();
			}
			
			System.out.println("2. google vision api로 전봇대 번호 추출 완료");
			return getTextDetection(responses);
		}
	}

	// 2. 추출해온 텍스트 피쳐에서 description만 뽑아서 list에 추가하기
	@Override
	public String getTextDetection(List<AnnotateImageResponse> responses) {
		List<String> list = new ArrayList<>();

		for (AnnotateImageResponse res : responses) {
			for (EntityAnnotation annotation : res.getTextAnnotationsList()) {
				list.add(annotation.getDescription().replace("\n", "").trim()); // 줄바꿈 치환하고 공백 제거 후 add()
			}
		}

		return doFiltering(list);
	}

	// 3. description에서 한글, 특수문자 걸러내고 StringBuiler에 append시켜서 하나의 String값으로 만들기
	@Override
	public String doFiltering(List<String> list) {
		final String kr = "^[^가-힣]*$"; // 한글 정규식
		final String unicode = "[^ !@#$%^&*(),.·'•?\\\":{}|<>]*"; // 특수문자 정규식
		StringBuilder word = new StringBuilder();

		for (int i = 1; i < list.size(); i++) {
			if (list.get(i).matches(unicode) && list.get(i).matches(kr)) {
				word.append(list.get(i));
			}
		}

		return pickPoleNum(word.toString());
	}

	// 4. String에서 전봇대번호만 추출해오기
	@Override
	public String pickPoleNum(String word) {
		final String number = "\\d{4}(?i)\\D\\d{3}"; // 전봇대 번호 추출해오는 정규식
		String poleNum = null;

		Matcher mc = Pattern.compile(number).matcher(word);

		if (mc.find()) {
			poleNum = mc.group(0); // 사진 내 전봇대가 여러개 존재하더라도 일단 첫번째 것만 찍게 해뒀어요. 여러개 하실거면 while loop 돌려야하니까 말씀해주세요
		}

		return poleNum;
	}

	// + 비전에서 읽어들인 결과 텍스트 파일로 추출해서 보려고 만듦(궁금하면 해보세요)
	public void makeFile(String title, String text) {
		try {
			FileWriter file = new FileWriter(title + ".txt");
			file.write(text);
			file.close();
		} catch (Exception e) {}
	}
}
