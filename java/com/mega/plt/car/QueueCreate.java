package com.mega.plt.car;

public class QueueCreate {
	private int max; // 큐 용량
	private int front; // 첫번째 요소 커서
	private int rear; // 마지막 요소 커서
	private int num; // 현재 데이터 수
	private String[] que; // 큐
	
	public QueueCreate() {
	}
	
	public QueueCreate(int capacity) {
		num = front = rear = 0;
		max = capacity;
		try {
			que = new String[max]; 
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public String enque(String x) throws RuntimeException{
		if (num >= max) { // 현재 데이터가 최대 용량을 넘을 경우 예외처리
			throw new RuntimeException();
		}
		que[rear++] = x; // 마지막 요소 커서에 값 넣음
		num++; // 넣었으니까 현재 데이터 수 1증가
		
		if (rear == max) { // 마지막 요소 커서와 최대 용량이 같으면 큐가 가득 찼다는 소리
			rear = 0; // 링버퍼이므로 마지막 요소 커서를 0으로 변경
		}
		
		return x;
	}
	
	public String deque() throws RuntimeException {
		String x = "";
		
		if (num <= 0) { // 현재 데이터가 하나도 없을 경우 예외처리
			throw new RuntimeException(); 
		}
		x = que[front++]; // 첫번째 요소 커서에서 하나 꺼냄
		System.out.println(front + "!!!!!!!!!!!!!!!!!!!!!!!!!!");
		num--; // 꺼냈으니까 현재 데이터 수 1 감소
		
		if(front == max) { // 첫번째 요소 커서가 0이되면
			front = 0; // 링버퍼이므로 첫번재 요소 커서를 큐의 마지막번재로 바꿈
		}
		
		return x;
	}
	
	public void clear() {
		num = front = rear = 0; // 큐 비움
	}
	
	public int size() { // 현재 있는 데이터 수
		return num;
	}
	
	public String dump() {
		String result = null;
		if (num <= 0) { // 안에 아무것도 없을 경우
			result = "큐 비어있음";
		}else {
			for (int i = 0; i < num; i++) {
				result = que[i+front % max];
			}
		}
		return result;
	}
	
	public int front() {
		return front; // 첫번째 커서
	}
	
	public int rear() {
		return rear; // 마지막 커서
	}
	public String q_front() {
		System.out.println(front + "!!!!!!!!!!!!!!!!!!!!!!!!!!");
		return que[front]; // 첫번째 값 가져옴
	}
}
