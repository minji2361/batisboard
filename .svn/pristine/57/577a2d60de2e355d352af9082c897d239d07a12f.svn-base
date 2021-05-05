package com.petboard.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.petboard.repository.BoardVo;
import com.petboard.repository.LikeCountVo;
import com.petboard.service.BoardServiceImpl;

@Controller
public class ItemBoardController {
	
	private BoardServiceImpl boardService;
	public ItemBoardController(BoardServiceImpl boardService) {
		this.boardService = boardService;
		
	}
	//게시판 리스트
	@RequestMapping(value="/itemboard")
	public String itemBoard(Model model) {
		String type = "item";
		List<BoardVo> itemList = boardService.showList(type);
		List<BoardVo> itemNotice = boardService.noticeList(type);
		model.addAttribute("itemList", itemList);
		model.addAttribute("itemNotice", itemNotice);
		
		return "board/itemboard/itemboard";
	}
	//글작성페이지
	@RequestMapping(value="/itemboardWrite", method = RequestMethod.GET)
	public String itemboardWrite(Model model, HttpServletRequest request, HttpSession session) {
		/* model.addAttribute("boardVo", new BoardVo()); */
		return "board/itemboard/itemboardWrite";
	}
	
	//글 등록 
	@RequestMapping(value="/itemboardUpload", method = RequestMethod.POST)
	public String itemboardwrite(BoardVo boardVo, BindingResult bindingResult) {
		if(bindingResult.hasErrors()) {
			return "board/itemboard/itemboardWrite";
		}
		return "redirect:/board/itemboard/itemboard";
	}
	
	
	//글보기 페이지
	@RequestMapping(value = "/itemboardContent/{boardNumber}")
	public String itemboardcontent(Model model,@PathVariable int boardNumber) {
		BoardVo vo = boardService.select(boardNumber);
		System.out.println("추천수:"+vo.getLikeCount());
		model.addAttribute("boardVo", vo);
		return "board/itemboard/itemboardContent";
	}
	//글 수정
	@RequestMapping(value = "/itemboardupdate")
	public String itemboardupdate(Model model) {
		return "board/itemboard/itemboardupdate";
	}
	
	//추천하기
	@RequestMapping(value = "/updateLike/{boardNumber}")
	@ResponseBody
	public String updateLike(@PathVariable int boardNumber,Model model,HttpSession session,LikeCountVo likeCountVo, HttpServletRequest request) {
		System.out.println("????");
		
		String email = (String)session.getAttribute("email"); 
		int memberNumber = (int)session.getAttribute("memberNumber");
		
		System.out.println("보드넘버"+boardNumber);
		System.out.println("이메일:"+ email);
		System.out.println("멤버넘버"+memberNumber);
		
		Map<String, Object> m = new HashMap<>();
        m.put("boardNumber", boardNumber);
        m.put("email",email);
		
        
		int result = boardService.checkLike(m);
//		model.addAttribute(likeCountVo);
//		likeCountVo.setBoardNumber(boardNumber);
//		likeCountVo.setEmail(email);
//		likeCountVo.setMemberNumber(memberNumber);
		System.out.println("값:"+result);
		if(result == 0 ) {
			boardService.updateLike(m);
			boardService.plusLikecount(boardNumber);
			System.out.println("추천 됨");
		}else {
			boardService.deleteLike(m);
			boardService.minusLikecount(boardNumber);
			System.out.println("추천 취소 됨");
		}
		return null;
			
		
	}
	
	//추천수 
	@RequestMapping(value = "/likeCount/{boardNumber}")
	@ResponseBody
	public int likeCount(Model model, HttpSession session,@PathVariable int boardNumber) {
			  
		  int count=boardService.countLike(boardNumber); 
		  System.out.println("추천카운트값:"+count);
		  return count;
		
       
      }
		
		
	 
	
}
