package com.mega.plt.faq;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class PointController {
	@Autowired
	PointService service;

	@RequestMapping("faq/point.do")
	@ResponseBody
	public List<PointVO> point() {
		List<PointVO> list = service.point();
		for (int i = 0; i < list.size(); i++) {
			System.out.println(list.get(i).getuID());
		}
		return list;
	}

	@RequestMapping("faq/pointUid.do")
	@ResponseBody
	public List<PointVO> pointUid() {
		List<PointVO> rankReady = new ArrayList<PointVO>();
		int[] mergeList = service.mergeSort();// 정렬된 배열
		for (int i = 0; i < service.mergeSort().length; i++) {
			// 배열에서 하나씩 꺼내서, 그 값으로 uID 찾으러 갔다가 반환을 리스트로 반환
			PointVO rankPoint = new PointVO();//
			// get으로 하나씩 가져와야 하기 때문에 for문에 for문을 사용
			for (int j = 0; j < service.uIDSearch(mergeList[i]).size(); j++) {
				// get으로 하나씩 꺼낼때 vo에서 꺼내서 넣기
				rankPoint.setuID(service.uIDSearch(mergeList[i]).get(j).getuID());
				rankPoint.setScore(mergeList[i]);
			}
			rankReady.add(rankPoint);
		}
		return rankReady;
	}
}