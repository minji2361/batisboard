package com.petboard.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.petboard.repository.BoardVo;
import com.petboard.service.BoardServiceImpl;

@Controller
public class MainController {
	
	private BoardServiceImpl boardService;
	public MainController(BoardServiceImpl boardService) {
		this.boardService = boardService;
	}
	
	
	
	
	  @RequestMapping(value="/main") 
	  public String main() {
	  
	  

	  
	  return "/main";
	  
	  }
	  @RequestMapping(value="/search") 
	 public String mainsearch(Model model, BoardVo boardVo) {
		 

			  List<BoardVo> showNewsearchType = boardService.showNewsearchType(boardVo);
			  model.addAttribute("showNewsearchType",showNewsearchType);
			
		 
		 return "/include/mainsearch";
	 }


}
