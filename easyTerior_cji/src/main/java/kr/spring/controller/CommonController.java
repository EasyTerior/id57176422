package kr.spring.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
		@GetMapping("/colorChangeShowPlus.do")
		public ResponseEntity<String> colorChangeShowPlus(@RequestParam("object") String object, @RequestParam("color") String color) throws IOException {

		    // Parse color from the input color string
		    int r = Integer.valueOf(color.substring(0, 2), 16);
		    int g = Integer.valueOf(color.substring(2, 4), 16);
		    int b = Integer.valueOf(color.substring(4, 6), 16);

		    // Read the object data from the text file
		    List<String> lines = Files.readAllLines(Paths.get("D:/id57176422/yolov5/runs/predict-seg/exp22/labels/processed_image.txt"));

		    // Iterate over each line (object)
		    for (String line : lines) {
		        // Parse object name and coordinates from the line
		        String[] parts = line.split(" ");
		        String objectName = parts[0];
		        List<Integer> coordinates = new ArrayList<>();
		        for (int i = 1; i < parts.length; i++) {
		            coordinates.add(Integer.parseInt(parts[i]));
		        }

		        // If the object name matches the input object, change its color in the image
		        if (objectName.equals(object)) {
		            changeColorForObjectInImage("C:/test123/processed_image.jpg", coordinates, new int[]{r, g, b});
		        }
		    }

		    String newImagePath = "http://127.0.0.1:5000/images/processed_image.jpg"; // replace with the actual new image path
		    return ResponseEntity.ok(newImagePath);
		}

		// This method should change the color of the specified object in the image
		private void changeColorForObjectInImage(String imagePath, List<Integer> coordinates, int[] color) {
		    // TODO: implement this method using OpenCV, ImageJ, or another image manipulation library
		}
}
