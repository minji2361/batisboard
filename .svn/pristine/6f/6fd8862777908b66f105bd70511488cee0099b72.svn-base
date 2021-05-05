package com.petboard.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.petboard.repository.BoardVo;
import com.petboard.service.BoardServiceImpl;

@Controller
public class PetPlaceController {

	private BoardServiceImpl boardService;

	public PetPlaceController(BoardServiceImpl boardService) {
		this.boardService = boardService;
	}

	// 게시판 페이지
	@RequestMapping(value = "/petplaceboard")
	public String petchatBoard(Model model, HttpSession session) {
		String type = "petplace";
		List<BoardVo> petplaceList = boardService.showList(type);
		List<BoardVo> petplaceNotice = boardService.noticeList(type);
		// int countReply = boardService.countReply(boardNumber);
		session.setAttribute("petplaceList", petplaceList);
		session.setAttribute("petplaceNotice", petplaceNotice);
		return "/board/petplaceboard/petplaceboard";
	}

	// 글 내용 보기
	@RequestMapping(value = "petplaceContent/{boardNumber}")
	public String contentPage(Model model, @PathVariable int boardNumber, HttpSession session) {
		model.addAttribute("boardVo", boardService.select(boardNumber));
		String loginNick = (String) session.getAttribute("nickName");
		int memberLevel;
		if (loginNick == null) {
			memberLevel = 1;
			loginNick = "null";
		} else {
			memberLevel = (int) session.getAttribute("memberLevel");
			model.addAttribute("loginNick", loginNick);
			model.addAttribute("memberLevel", memberLevel);
		}

		return "/board/petplaceboard/petplaceContent";
	}

}
