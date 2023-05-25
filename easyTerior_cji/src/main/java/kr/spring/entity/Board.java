package kr.spring.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data // 롬복이라는 API가 알아서 getter/setter를 만들도록.
@NoArgsConstructor // 기본 생성자 없으면 에러 나므로 만들어줘야 함. 필수
@AllArgsConstructor // 전체 argument를 받는 constructor 만들어줌 -> 필요에 의해
@ToString // 값을 빠르게 확인하는 메서드 -> printInfo 같은 느낌
public class Board {
	private int idx;
	private String memID;
	private String title;
	private String content;
	private String writer;
	private String indate;
	private int count;
	
}
