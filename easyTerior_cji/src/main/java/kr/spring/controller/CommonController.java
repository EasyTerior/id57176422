package kr.spring.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CommonController {
// 	main - 요청 URL /
	@RequestMapping("/")
	public String main() {
		// return "main";
		return "index";
	}
	
	// 스타일 분석 게시판 이동
	@RequestMapping("/styleRoom.do")
	public String styleRoom() {
		return "style/styleRoom";
	}
	
	// 스타일 분석 이미지 등록
		@RequestMapping("/colorChange.do")
		public String colorChange() {
			return "style/colorChange";
		}
	// 스타일 분석 이미지 보여주기
		@RequestMapping("/colorChangeShow.do")
		public String colorChangeshow() {
			return "style/colorChangeShow";
		}
	
}
