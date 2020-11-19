package com.mega.plt.faq;
//병합 정렬
public class mergeSort {//원소가 저장되어 있는 배열을 계속 쪼개서 길이가 1인 배열을 만들고, 그 이후 정렬하면서 합치는 자료구조
	static int[] tmpArray;//정렬된 원소를 임시 저장하는 배열
	
	public void mergeSort(int start, int end, int[] sortReady) {
		tmpArray = new int[sortReady.length];
		//start 배열의 시작 인덱스, end는 배열의 끝 인덱스
		if (start < end) {
			int mid = (start + end) / 2;//중간지점
			mergeSort(start, mid, sortReady);//시작부터 중간 지점까지 병합정렬하기
			mergeSort(mid + 1, end,sortReady);//중간지점 다음부터 끝까지 병합정렬하기 
			//두 분할의 첫번째 원소의 인덱스를 저장
			int head = start;
			int secondHead = mid + 1;
			int index = head;//복수 후 저장해야 하는 값의 기준을 처음(start)인덱스로 설정			
			//첫번째 분할시 값 가져오기
			//동시 종료가 안될 수 있기에 ||로 while문 조건 검사
			//앞부분 배열이 끝까지 혹은 뒷 부분 배열이 끝까지 갈때까지 반복
			while (head <= mid || secondHead <= end) {
				//두번째 분할 요소를 이미 다 가져온 경우(secondHead > end) if문으로 확인
				//1.secondHead > end
				//2.head <= mid && sortReady[head] < sortReady[secondHead]
				//두 조건 중 하나 이상 만족하면 첫 번째 분할에서 원소를 가져오므로 두 조건 사이에 or을 사용한다.
				if (secondHead > end || (head <= mid && sortReady[head] < sortReady[secondHead])) {
					//임시 배열에 값 넣기
					tmpArray[index++] = sortReady[head++];//반으로 나눈 앞부분 배열의 첫 인덱스 값을 임시 배열에 넣기
					//다시 반복 될때 증가된 인덱스에 저장 된다.
				} else {
					tmpArray[index++] = sortReady[secondHead++];//반으로 나눈 뒷부분 배열의 첫 인덱스에 값 넣기 
					//다시 반복 될때 증가된 인덱스에 저장 된다.
				}
			}
			//임시 배열에 저장한 값을 기존배열에 순서대로 대입하기
			for (int i = start; i <= end; i++) {
				sortReady[i] = tmpArray[i];
			}
		}
	}
}