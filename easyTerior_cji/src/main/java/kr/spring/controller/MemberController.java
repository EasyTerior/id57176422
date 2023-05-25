package kr.spring.controller; // 해당 controller 아래서만 사용한다고 servlet-context.xml에 명시함

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.spring.entity.Member;
import kr.spring.mapper.MemberMapper;

@Controller // controller 기능을 위해 annotation 처리
public class MemberController {
	@Autowired
	private MemberMapper memberMapper;
	
	@Autowired
	private PasswordEncoder pwEncoder; // 비밀번호 인코딩

	// 회원가입 페이지 이동 : 요청 URL - /joinForm.do
	@RequestMapping("/joinForm.do")
	public String joinForm() {
		return "member/joinForm"; // do 뺄 것.
	}

	// 아이디 중복 확인 기능 요청 URL - /registerCheck.do
	@RequestMapping("/registerCheck.do")
	public @ResponseBody int registerCheck(@RequestParam("memID") String memID) {
		// System.out.println(memID);
		Member mem = memberMapper.registerCheck(memID);

		if (mem != null || memID.equals("")) {
			return 0;
		} else {
			return 1;
		}
	}

	// 회원가입 기능 : 요청 URL - /join.do
	@RequestMapping("/join.do") // RedirectAttributes 로서 리다이렉트 이동 시 데이터를 들고 가되 한 번만 사용 가능.
	public String join(Member mem, RedirectAttributes rttr) { // 매개변수로 id, pwd, 이름, 나이, 성별, 이메일 등 Member 정보가 들어옴
		mem.setMemProfile(""); // MemProfile에 null 이 되어있으면 not null인 경우 에러가 있을 수 있음.
		int cnt = 0;
		try {
			// 암호화 하기
			String encyPw = pwEncoder.encode(mem.getMemPassword());
			mem.setMemPassword(encyPw);
			
			// 실질 DB에 비밀번호 넣기
			cnt = memberMapper.join(mem);
		} catch (Exception e) {
			// 회원 가입 실패
			rttr.addFlashAttribute("msgType", "실패 메세지");
			rttr.addFlashAttribute("msg", "회원가입에 실패하셨습니다. 다시 시도해주세요.");
			return "redirect:/joinForm.do"; // member/joinForm
		} finally {
			if (cnt == 1) {
				// 회원 가입 성공 -> index.jsp 로 이동하면서 성공했다는 메세지를 띄우고 싶음 -> 성공이라는 정보를 전달
				rttr.addFlashAttribute("msgType", "성공 메세지");
				rttr.addFlashAttribute("msg", "회원가입에 성공하셨습니다. 환영합니다. " + mem.getMemID() + " 님!");
				return "redirect:/"; // 1. session 쓰기 2. key=value식으로 전달 3. pathVariable 형식
				// redirect attribute
			}
		}
		return null;
	}

	// 로그인 페이지로 이동 요청 URL - /loginForm.do
	@RequestMapping("/loginForm.do")
	public String loginForm() {
		return "member/loginForm";
	}

	// 로그인 기능 요청 URL - /login.do
	@RequestMapping("/login.do")
	public String login(Member mem, HttpSession session, RedirectAttributes rttr) {
		Member memInfo = memberMapper.getMember(mem.getMemID());
		boolean isMatches = pwEncoder.matches(memInfo.getMemPassword(), mem.getMemPassword());
		System.out.println(memInfo.getMemPassword());
		System.out.println(mem.getMemPassword());
		System.out.println(isMatches);

		// Member memResult = memberMapper.login(mem); // 로그인 성공 시 해당 존재하는 로그인 된 회원의 정보 받기
		// 회원 없으면 null 반환 -> 로그인 실패시 nullPointerException
		// System.out.println(m.toString()); // .toString() -> 500 NullPointerException
		// if (memResult == null) {
		if ((!isMatches) || (memInfo == null)) {
			// login failure
			rttr.addFlashAttribute("msgType", "실패 메세지");
			rttr.addFlashAttribute("msg", "로그인에 실패하셨습니다. 아이디와 비밀번호를 확인해주세요.");
			return "redirect:/loginForm.do";
		} else {
			// login success
			rttr.addFlashAttribute("msgType", "성공 메세지");
			rttr.addFlashAttribute("msg", "로그인에 성공하셨습니다. 안녕하세요. " + memInfo.getMemName() + " 님!");
			session.setAttribute("memResult", memInfo);
			return "redirect:/";
		}
	}

	// 로그아웃 기능 : 요청 URL - /logout.do
	@RequestMapping("/logout.do")
	public String logout(HttpSession session, RedirectAttributes rttr) {
		// session.removeAttribute("memResult"); // memResult 만 지우기
		session.invalidate(); // session(서버) 자체 날리기 쿠키 만드는 건 서버임. 다만 쿠키로 세션의 key가 발급됨. 주의
		rttr.addFlashAttribute("msgType", "성공 메세지");
		rttr.addFlashAttribute("msg", "성공적으로 로그아웃 되었습니다.");
		return "redirect:/";
	}

	// 회원정보 수정 form으로 이동 기능 : 요청 URL - /updateForm.do
	@RequestMapping("/updateForm.do")
	public String updateForm() {
		return "member/updateForm";
	}

	// 문제 : 회원의 정보를 수정하기. 아이디가 일치하는 회원의 비밀번호, 이름, 성별, 나이, 이메일을 변경하기. 회원정보 수정 이후
	// index.jsp로 이동.
	// 회원정보수정 기능 : 요청 URL - /update.do
	@RequestMapping("/update.do")
	public String update(Member mem, HttpSession session, RedirectAttributes rttr) {
		mem.setMemProfile("");
		int cnt = memberMapper.update(mem);
		if (cnt == 1) { // SQL 실행문 1문이 잘 됨. == 회원정보수정 성공
			session.setAttribute("memResult", mem);
			rttr.addFlashAttribute("msgType", "성공 메세지");
			rttr.addFlashAttribute("msg", "성공적으로 회원정보가 수정되었습니다.");
			return "redirect:/";
		} else { // 회원정보수정 실패
			rttr.addFlashAttribute("msgType", "실패 메세지");
			rttr.addFlashAttribute("msg", "회원정보수정에 실패하셨습니다. 다시 한 번 시도해주세요.");
			return "redirect:/updateForm.do";
		}
		// updateMem = session.setAttribute("memResult", memResult);
	}

	// 프로필 이미지 등록으로 이동 : 요청 URL - /imageForm.do
	@RequestMapping("/imageForm.do")
	public String imageForm() {
		return "member/imageForm";
	}

	// 프로필 이미지 등록 기능 : 요청 URL - /imageUpload.do
	@RequestMapping("/imageUpload.do")
	public String imageUpload(HttpServletRequest request, RedirectAttributes rttr, HttpSession session) {

		// 파일 업로드 DB에 파일을 넣는 것은 업로드가 아니라 Mybatis로 넣는 것이지 서버의 특정 폴더에 넣는 것이 업로드
		// COS 의 multipartRequest 라는 객체를 생성하여 그 객체를 통해서 업로드.
		MultipartRequest multi = null;
		int fileMaxSize = 100 * 1024 * 1024; // 파일 최대 크기 제한 -> 100 MB == 100 * 1024 * 1024

		// 파일 저장될 위치 경로
		String savePath = request.getRealPath("resources/profile"); // resource/profile 에 저장하려는 저장경로 지정
		// webapp 이 contextPath 이므로 해당부터 들어가도록 처리.

		// 인코딩 타입
		String encType = "UTF-8"; // encoding

		// 중복제거 객체 -> 동일한 이름의 image 이름 처리.
		DefaultFileRenamePolicy dfrp = new DefaultFileRenamePolicy();

		// multipart 객체 - 매개변수 : 요청데이터, 저장경로, 최대크기, 인코딩 박식, 파일명중복제거 객체
		try {
			multi = new MultipartRequest(request, savePath, fileMaxSize, encType, dfrp);
		} catch (IOException e) {
			// 확장자 구분
			e.printStackTrace();
		}
		// 파일 자체가 request로 넘겨지므로 request 그대로

		String newProfile = "";
		// 사용자가 업도르한 파일 가져오기
		File file = multi.getFile("memProfile");
		if (file != null) {
			// 사용자가 파일을 올렸을 때.
			String ext = file.getName();
			ext = ext.substring(ext.lastIndexOf(".") + 1);
			ext = ext.toUpperCase(); // 전부 대문자 처리
			// System.out.println(ext);
			boolean isCheck = ext.equals("PNG") || ext.contains("JPG") || ext.contains("JPEG") || ext.equals("GIF");
			if (!isCheck) { // 이미지 파일이 아닐 경우,
				if (file.exists()) {
					// 현재 파일이 경로에 존재하는지 알려주는 메서드
					file.delete();
				}
				rttr.addFlashAttribute("msgType", "실패 메세지");
				rttr.addFlashAttribute("msg", "이미지 업로드에 실패하셨습니다. 확장자가 png, jpg, jpeg, gif 인 이미지 파일만 업로드가 가능합니다.");
				return "redirect:/imageForm.do";
			} else {// 이미지 파일인 경우,
				newProfile = file.getName();
				String memID = multi.getParameter("memID");

				// 저장 전 기존의 이미지 프로필 삭제하기.
				// 업로드 준비가 된 후, 프로필 이미지가 이전에 존재한다면 존재하던 걸 먼저 삭제하기.
				String oldImg = memberMapper.getMember(memID).getMemProfile();
				File oldFile = new File(savePath+"/"+oldImg);
				if (oldFile.exists()) {
					// 기존 파일이 있다면
					oldFile.delete();
				} // 없다면 새로 업로드 하면 될 일.
				
				// 객체로서 DB에 보내기
				Member mem = new Member();
				mem.setMemProfile(newProfile);
				mem.setMemID(memID);

				memberMapper.imageUpload(mem);
				// 방법 1. session에 memResult를 통해서 profile에 저장한 이미지 다시 넣어서 다시 set하기
				// 방법 2. memID에 동일한 정보를 다시 가져와서 다시 set하기 -> 재활용 가능
				// 수정된 회원 정보 다시 가져오기
				Member m = memberMapper.getMember(memID);
				session.setAttribute("memResult", m); // memResult라는 이름으로 session에 넣었으니 엎어치기

				rttr.addFlashAttribute("msgType", "성공 메세지");
				rttr.addFlashAttribute("msg", "이미지 업로드에 성공하셨습니다. 프로필 이미지가 업데이트 됩니다.");

				return "redirect:/";
			}

		} else { // 파일 안 올렸을때
			rttr.addFlashAttribute("msgType", "실패 메세지");
			rttr.addFlashAttribute("msg", "이미지가 업로드 되지 않았습니다. 확장자(png, jpg, jpeg, gif)가 적절한 이미지를 올려주시길 바랍니다.");
			return "redirect:/imageForm.do";
		}

	}

}
