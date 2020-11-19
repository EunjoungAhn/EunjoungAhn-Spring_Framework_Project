package com.mega.plt.faq;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PointService {

	@Autowired
	PointDAO dao;

	static int[] sortReady;// 내가 정렬해야 할 원소의 배열

	public int[] mergeSort() {
		mergeSort m = new mergeSort();
		sortReady = new int[dao.list().size()];// DB의 데이터 양 만큼 배열의 크기 지정
		for (int i = 0; i < dao.list().size(); i++) {
			// DB에서 정렬할 값 하나씩 순서대로 배열에 담기
			sortReady[i] = dao.list().get(i).getScore();
		}
		// 정렬할 배열의 시작 인덱스, 끝 인덱스, 배열값 넘기기
		m.mergeSort(0, sortReady.length - 1, sortReady);
		return sortReady;
	}

	public List<PointVO> uIDSearch(int score) {
		return dao.uIDSearch(score);
	}

	public List<PointVO> point() {
		List<PointVO> list = dao.quick(); // 정렬안된 리스트
		List<PointVO> pointList = new ArrayList<PointVO>();
		String user = null;
		int[] a = new int[list.size()];
		for (int i = 0; i < list.size(); i++) {
			a[i] = list.get(i).getScore();
		}
		QuickCreate q = new QuickCreate();
		q.quicksort(a);
		for (int i = 0; i < a.length; i++) {
			System.out.println(a[i]);
		}
		for (int i = 0; i < a.length; i++) {
//			PointVO vo = new PointVO();
			// 같은 스코어일 경우 DAO에서 2개 이상 가져오게 됨
			if (dao.find(a[i]).size() >= 2) {
				for (int j = 0; j < dao.find(a[i]).size(); j++) {
					PointVO vo = new PointVO();
					user = dao.find(a[i]).get(j).getuID();
					vo.setuID(user);
					vo.setScore(a[i]);
					pointList.add(vo);
				}
				i = i + dao.find(a[i]).size() - 1;
			} else {
				PointVO vo = new PointVO();
				user = dao.find(a[i]).get(0).getuID();
				vo.setuID(user);
				vo.setScore(a[i]);
				pointList.add(vo);
			}
		}
		return pointList;
	}

}
