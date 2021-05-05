package com.petboard.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.petboard.repository.BoardVo;
import com.petboard.repository.MemberVo;
import com.petboard.service.BoardServiceImpl;
import com.petboard.service.MemberService;
import com.petboard.service.MemberServiceImpl;

@Controller
public class AdminController {
	
	private BoardServiceImpl boardService;
	
	@Autowired
    private MemberService memberService;
	
	
	  public AdminController(BoardServiceImpl boardService) { this.boardService =
	  boardService; }
	 

	@RequestMapping(value="/Adminpage")
	public String Adminpage(Model model,MemberVo memberVo ,BoardVo boardVo) {

		
		List<MemberVo> showNewOption = memberService.showNewOption(memberVo);
		model.addAttribute("showNewOption",showNewOption);
		
		boardVo.setBoardStatus('n');
		List<BoardVo> showNewStatus = boardService.showNewStatus(boardVo);
		model.addAttribute("showNewStatus",showNewStatus);
		
		boardVo.setBoardStatus('y');
		List<BoardVo> showDelectStatus = boardService.showNewStatus(boardVo);
		model.addAttribute("showNewDelect",showDelectStatus);

		
		return "member/Adminpage";
	}
	
}
