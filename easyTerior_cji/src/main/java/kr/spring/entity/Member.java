package kr.spring.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;


@Data
@AllArgsConstructor
@NoArgsConstructor // 기본 생서자 없으면 mybatis 쓸 수 없으니 필수.
@ToString
public class Member {
	private int memIdx;
	private String memID;
	private String memPassword;
	private String memName;
	private String memNickname;
	private String memPhone;
	private String memEmail;
	private String memAddress;
	private String memProfile;
	
}