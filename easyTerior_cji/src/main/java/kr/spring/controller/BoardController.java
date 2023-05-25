package kr.spring.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;  // public String boardList (Model model)
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping; // @RequestMapping("/boardList.do")
import org.springframework.web.bind.annotation.RequestParam;  // @RequestParam 을 통해서 Board 의 하나 혹은 해당에 없는 걸 받을 때 request로 받아서 매개변수 처리
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.entity.Board;
import kr.spring.mapper.BoardMapper;

@Controller
public class BoardController { // 서버 기능들
	
	// 게시판 이동
	@RequestMapping("/boardMain.do")
	public String boardMain() {
		return "board/main";
	}
	
}
