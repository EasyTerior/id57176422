package kr.spring.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.spring.entity.Board;
import kr.spring.mapper.BoardMapper;

// controller 자체에다가 surfix를 추가해주는 셈
@RequestMapping("/board") // board 기능들이므로
@RestController // 비동기 요청을 받는 controller이고, 상태 서버의 고유한 리소스를 접근하는 대표 상태 전송 가능. @RestController만 가능
public class BoardRestController {
	
	@Autowired
	private BoardMapper boardMapper;
	
	// 게시글 전체 리스트 보기 (비동기) 요청 URL - /boardList.do
	// 비동기 메서드 -> js 작동
	// @GetMapping("/boardList.do")
	@GetMapping("/all")
	public List<Board> boardList(){  // RestController 에서 @ResonseBody 삭제
		List<Board> list = boardMapper.boardList();
		return list; // JSON Object → JSON Array로 return
	} 
	
	// 게시글 입력 기능 : (비동기) 요청 URL - /boardInsert.do
	// @PostMapping("/boardInsert.do")
	@PostMapping("/new")
	public void boardInsert(Board b){  // RestController 에서 @ResonseBody 삭제
	// data 돌려줄 필요 없으므로 void 입력으로 끝나므로.
	// 	비동기 방식을 위해 반드시 필수
		boardMapper.boardInsert(b);
		
	}
	
	// 게시글 상세보기 : (비동기) 요청 URL - /boardContent.do
	// @GetMapping("/boardContent.do")
	@GetMapping("/{idx}")
	//public Board boardContent(@RequestParam("idx") int idx) {
	public Board boardContent(@PathVariable("idx") int idx) { // BoardRestController
		Board board = boardMapper.boardContent(idx);
		return board;
	}
	
	// 게시글 삭제 기능 : (비동기) 요청 URL - /boardDelete.do
	// @GetMapping("/boardDelete.do") // type을 GET 에서 DELETE로 바꿨으니 맞춰야 함.
	@DeleteMapping("/{idx}")
	// public void boardDelete(@RequestParam("idx") int idx) {  // RestController 에서 @ResonseBody 삭제
	public void boardDelete(@PathVariable("idx") int idx) {
		boardMapper.boardDelete(idx);
	}
	
	// 게시글 수정하기 기능 : (비동기) 요청 URL - /boardUpdate.do
	// @PostMapping("/boardUpdate.do")  // RestController 에서 @ResonseBody 삭제
	// public void boardUpdate(Board b) { // 기본 생성자가 있어야 하고 setter 있어야 함.
	@PutMapping("/update")
	public void boardUpdate(@RequestBody Board b) { // Board 객체로 묶기 위해 @RequestBody 필수
		boardMapper.boardUpdate(b);
	}
	
	// 게시글 조회수 올리는 기능 : (비동기) 요청 URL - /boardCount.do
	// @GetMapping("/boardCount.do")  // RestController 에서 @ResonseBody 삭제
	// public void boardCount(@RequestParam("idx") int idx) {
	@PutMapping("/count/{idx}")
	public void boardCount(@PathVariable("idx") int idx) {
		boardMapper.boardCount(idx);
	} 
	
}
