package kr.spring.mapper;

import org.apache.ibatis.annotations.Mapper;

import kr.spring.entity.Member;

@Mapper
public interface MemberMapper {
	public int registerCheck();

	public Member registerCheck(String memID);

	public int join(Member mem);

	public Member login(Member mem);

	public int update(Member mem);

	public void imageUpload(Member mem);

	public Member getMember(String memID);
	
	
}
