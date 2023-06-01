package kr.spring.controller;

import java.awt.Point;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.io.FileReader;
import java.io.BufferedReader;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.entity.PointDTO;

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
	// 스타일 색상 결과 보여주고 저장
		@RequestMapping("/colorChangeShowSave.do")
		public String colorChangeshowing(@RequestParam("data") String jsonData, Model model) {
			model.addAttribute("JsonData",jsonData);
			return "style/colorChangeShowSave";
		}
		
		
		
		
		
		
}
