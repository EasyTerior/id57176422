package kr.spring.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Update;

import kr.spring.entity.Board;

@Mapper
public interface BoardMapper {
	// 게시글 리스트 가져오는 기능
	public List<Board> boardList(); // 반환 타입 List<Board> 명시 하고 id로서 쓸 메서드명
	
	// 게시글 입력 기능
	public void boardInsert(Board board);
	
	// 게시글 상세 보기 기능
	public Board boardContent(int idx);

	// 게시글 삭제 기능
	public void boardDelete(int idx);

	// 게시글 업데이트 기능
	public void boardUpdate(Board board);

	// 게시글 조회수 +1 기능
	// public void boardCount(int idx);
	@Update("UPDATE board SET count = count + 1 WHERE idx = #{idx}") // 여기에 SQL 해놨으므로 BoardMapper.xml 에서는 삭제. 중복되어 에러남.
	public void boardCount(int idx);
}
