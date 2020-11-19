package com.mega.plt.util;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import org.springframework.stereotype.Service;

@Service
public class KepcoService implements KepcoInterface {
	final private String SERVICE_KEY = "=Gl4FrEWDmeTnrNfyXuX5dDyQxILxbzrFXP4WnxyfFzaId95nyOfB%2FaAu5xTZVkeIsv1FjSlOhNLZOGKGs%2FX57Q%3D%3D";
	
	@Override
	public boolean isRealPole(String poleNum) {
		boolean isExist = false;
		try {
			StringBuilder urlBuilder = new StringBuilder("http://openapi.kepco.co.kr/service/elecPowerPoleNumberService/getElecPowerPoleNumberItem");
			urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + SERVICE_KEY);
			urlBuilder.append("&" + URLEncoder.encode("poleNumber","UTF-8") + "=" + URLEncoder.encode(poleNum, "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("poleNumber","UTF-8") + "=" + URLEncoder.encode(poleNum, "UTF-8"));
			
			URL url = new URL(urlBuilder.toString());
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Content-type", "application/json");
//			System.out.println("Response code: " + conn.getResponseCode()); // api 출력 결과 xml이 궁금하신 분들은 주석 풀고 찍어보세요
			
			//BufferedReader rd;
			if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
			    //rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			    isExist = true; // 200~300 사이이면 실존하는 전봇대!!!
			}
			else {
			    //rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
			}
			
			//StringBuilder sb = new StringBuilder();
			//String line;
//			while ((line = rd.readLine()) != null) {
//			    sb.append(line+"\n");
//			}
//			System.out.println("나는 xml"+sb.toString());
//			rd.close();
			conn.disconnect();
			System.out.println("3. 한전api로 실존 여부 체크 완료");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return isExist;
	}
}
