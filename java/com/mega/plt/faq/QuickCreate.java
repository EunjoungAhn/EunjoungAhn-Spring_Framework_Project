package com.mega.plt.faq;

public class QuickCreate {
	public static void quicksort(int[] a) {
		quicksort(a, 0, a.length-1); // 0부터 (배열 길이-1 =)마지막 인덱스까지 돌림
	}
	
	public static int[] quicksort(int[] a, int left, int right) {
		int p2 = partiton(a, left, right); // 가져온 값들로 partiton메서드
		
		if (left < p2-1) {
			quicksort(a, left, p2-1); // 자기 자신을 부름(재귀함수)
		}
		if (p2 < right) { // 
			quicksort(a, p2, right);// 자기 자신을 부름(재귀함수)
		}
		return a;
	}
	
	public static int partiton(int[] a, int pl, int pr) {
		int pivot = a[(pl + pr) / 2]; // 첫번째와 마지막 인덱스의 중간 값
		
		while(pl <= pr) { // pl이 pr보다 작거나 같을 경우에만 돌아감
			while(a[pl] < pivot) { // 배열의 a[pl]값이 pivot보다 작으면 무시하면서
				pl++; // pl을 하나씩 증가(점점 뒤로)
			}
			while(a[pr] > pivot) { // 배열의 a[pr]값이 pivot보다 크면 무스하면서
				pr--; // pr을 하나씩 감소(점점 앞으로)
			}
			if (pl <= pr) { // pl이 pr보다 작거나 같으면
				swap(a, pl, pr); // 값을 서로 바꿈
				pl++; pr--; // 나와서 하나씩 증가, 감소
			}
		}// pl이 pr보다 크면 무한루프를 빠져나옴
		return pl;  // pl값 출력
	}
	
	private static void swap(int[] a, int x, int y) {
		int tmp = a[x]; // 임시 공간을 하나 만들어서 값을 바꿈
		a[x] = a[y];
		a[y] = tmp;
	}
	
	// test해본 것
//	public static void main(String[] args) {
//		int[] a = {2, 6, 3, 5, 8, 1, 4};
//		quicksort(a);
//		for (int i = 0; i < a.length; i++) {
//			System.out.println(a[i]);
//		}
//	}
	
}
