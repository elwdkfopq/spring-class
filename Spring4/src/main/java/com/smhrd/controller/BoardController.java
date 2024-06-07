package com.smhrd.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.smhrd.entity.Board;
import com.smhrd.entity.Member;
import com.smhrd.entity.Reply;
import com.smhrd.mapper.BoardMapper;

@Controller // 해당 클래스가 Controller가 되기위한 명시
public class BoardController {
	
	@Autowired
	private BoardMapper mapper;
	
	@Autowired
	private PasswordEncoder pwEnc;
	
	@RequestMapping("/")
	public String home() {
		return "main";
	}
	
	@RequestMapping("/boardList.do")
	public @ResponseBody List<Board> boardList(){
		System.out.println("게시글 전체보기 기능");
		List<Board> list = mapper.boardList();
		return list;
	}
	// 비동기 방식. 보여주고싶은 데이터를 반환, 웹으로 뿌려줌
	
//	@RequestMapping("/boardList.do") // Client가 요청한 url 맵핑
//	public String boardList(Model model) {
//		System.out.println("게시글 전체보기 기능");
//	
//		
//		// 게시글 정보 - 번호(꼭있어야함), 제목, 내용, 작성자, 작성일, 조회수
//		List<Board> list = mapper.boardList();
//		
//		model.addAttribute("list", list);
//		
//		
//		return "boardList";
//		
//		// view의 이름만 받음
//	}
//	
	@RequestMapping("/boardCount.do/{idx}")
	public @ResponseBody void boardContent(@PathVariable("idx") int idx) {
		System.out.println("게시글 조회수 기능");
		
		
		mapper.boardCount(idx);
		
	}
//	
//	

//	
	@RequestMapping("/boardInsert.do")
			//비동기로 하기위해
	public @ResponseBody void boardInsert(HttpServletRequest request) {
		// Board vo = new Board();
		// String title = request.getParameter("title")
		// String content = request.getParameter("content")
		// String writer = request.getParameter("writer")
		
		// vo.setTitle(title);
	      // vo.setContent(content);
	      // vo.setWriter(writer);
		System.out.println("게시글 입력 기능");
		
		// 파일을 서버 폴더에 저장하는 객체
		MultipartRequest multi = null;
		
		int fileMaxSize = 10 * 1024 * 100000;
		String savePath = request.getRealPath("resources/board");
		
		System.out.println(savePath);
		
		try {
			multi = new MultipartRequest(request, savePath, fileMaxSize, "UTF-8", new DefaultFileRenamePolicy());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		String title = multi.getParameter("title");
		String content = multi.getParameter("content");
		String writer = multi.getParameter("writer");
		String imgpath = multi.getFilesystemName("imgpath");
		
		Board vo = new Board();
		vo.setTitle(title);
		vo.setContent(content);
		vo.setWriter(writer);
		vo.setImgpath(imgpath);
		
		System.out.println(vo.toString());
		
		
		mapper.boardInsert(vo);
		
	
	}
//	
	@RequestMapping("/boardDelete.do/{idx}")
	public @ResponseBody void boardDelete(@PathVariable("idx") int idx) {
		System.out.println("게시글 삭제기능");
		// 번호를 넘겨줘야 삭제할 수 있다.
		mapper.boardDelete(idx);
	}

	
	@RequestMapping("/boardUpdate.do")
	// 4개 쓸 필요 없이 Board 하면 알아서 4개 사용할 수 있음
	public @ResponseBody void boardUpadate(Board vo) {
		mapper.boardUpdate(vo);
		
	}
	
	@RequestMapping("/joinForm.do")
	// 회원가입 페이지로 이동만시키는 거
	// 비동기 아님
	public String joinForm() {
		return "joinForm";
	}
	
	@RequestMapping("/join.do")
	public String join(Member vo) {
		
		String enPw = pwEnc.encode(vo.getPw());
		vo.setPw(enPw);
		
		mapper.join(vo);
		
		return "redirect:/";
	}
	
	@RequestMapping("/loginForm.do")
	public String loginForm() {
		return "loginForm";
	}
	
	@RequestMapping("login.do")
	public String login(Member vo, HttpSession session) {
		Member info = mapper.login(vo);
		
		if(info != null) {
			
			if(pwEnc.matches(vo.getPw(), info.getPw()))
			session.setAttribute("info", info);
		}
		
		return "redirect:/";
	}
	
	
	@RequestMapping("/logout.do")
	public String logout(HttpSession session) {
		session.invalidate();
		
		return "redirect:/";
	}
//	
//	@RequestMapping("/replyInsert.do")
//	public String replyInsert(Reply vo) {
//		System.out.println("댓글 작성 기능");
//		mapper.replyInsert(vo);
//		
//		return "redirect:/boardContent.do#view?idx="+vo.getBoardnum();
//	}
}
