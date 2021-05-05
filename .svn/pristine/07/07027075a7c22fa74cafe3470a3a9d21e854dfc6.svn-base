package com.petboard.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.petboard.repository.BoardVo;
import com.petboard.repository.ReplyVo;
import com.petboard.service.BoardServiceImpl;

@Controller
public class LostPetController {
	
	private BoardServiceImpl boardService;
	public LostPetController(BoardServiceImpl boardService) {
		this.boardService = boardService;
	}
	
	@RequestMapping(value="/lostpetboard")
	public String lostpetBoard(Model model) {	
		String type = "lostpet";	
		List<BoardVo> lostpetList = boardService.showList(type);
		List<BoardVo> lostpetNotice = boardService.noticeList(type);
		model.addAttribute("lostpetList", lostpetList);
		model.addAttribute("lostpetNotice", lostpetNotice);
//		String writer = boardService.showWriter(5);
//		System.out.println(writer);
		return "/board/lostpetboard/Lostpetboard";
	}
	
	//새글작성 페이지
//	@RequestMapping(value="/lostpetWrite", method=RequestMethod.GET)
//	public String write(Model model) {
//		model.addAttribute("boardVo", new BoardVo());
//		return "/board/lostpetboard/LostpetWrite";
//	}
	
	
	//새글작성 페이지
	@RequestMapping(value="/lostpetWrite", method=RequestMethod.GET)
	public String write(HttpSession session) {
		
		String email = (String)session.getAttribute("email");
		
		if(email != null) {
			return "/board/lostpetboard/LostpetWrite";
		}
		else {
			return "redirect:/lostpetboard";
		}
	}
	
	
	//새글 등록
	@RequestMapping(value="/lostpetWrite", method=RequestMethod.POST)
	public String write(BoardVo boardVo) {	
		boardService.write(boardVo);
		return "redirect:/board/lostpetboard/Lostpetboard";
	}
	
	
	//새글 등록

//	@RequestMapping(value="/lostpetWrite", method=RequestMethod.POST)
//	public String write(BoardVo boardVo, BindingResult bindingResult) {	
//		if(bindingResult.hasErrors()) {
//			return "/board/lostpetboard/LostpetWrite";
//		}
//		boardService.write(boardVo);
//		return "redirect:/board/lostpetboard/Lostpetboard";
//	}

	
	
	
	//글 읽어오기
	@RequestMapping(value="lostpetContent/{boardNumber}")
	public String read(Model model,@PathVariable int boardNumber) {
		model.addAttribute("boardVo", boardService.select(boardNumber));
	
		model.addAttribute("replyVo", new ReplyVo());
		return "/board/lostpetboard/LostpetContent";
	}
	
	//글 수정페이지 불러오기
	@RequestMapping(value="/lostpetEdit/{boardNumber}", method=RequestMethod.GET)
	public String edit(@PathVariable int boardNumber, Model model) {
		BoardVo boardVo = boardService.select(boardNumber);
		model.addAttribute("boardVo", boardVo);
		return "/board/lostpetboard/LostpetWrite";
	}
	
	//글 수정 
	@RequestMapping(value="/lostpetEdit/{boardNumber}", method=RequestMethod.POST)
	public String edit(BoardVo boardVo, Model model) {
		boardService.updateWrite(boardVo);
		return "redirect:/lostpetboard";
	}



//	//글 수정 
//	@RequestMapping(value="/lostpetEdit/{boardNumber}", method=RequestMethod.POST)
//	public String edit(BoardVo boardVo, BindingResult result) {
//		if(result.hasErrors()) {
//			return "/board/lostpetboard/LostepetWrite";
//		}
//		else {
//				boardService.updateWrite(boardVo);
//				return "redirect:/board/lostpetboard/Lostpetboard";
//	
//		}
//		
//	}
	
	//댓글 리스트 출력
	@ResponseBody
	@RequestMapping(value = "/getReplyList", method = RequestMethod.POST)
	public List<ReplyVo> getReplyList(@RequestParam("boardNumber") int boardNumber, ReplyVo replyVo) throws Exception {
		String nickName = replyVo.getNickName();
		
		return boardService.selectReply(boardNumber);

	}

	@ResponseBody
	@RequestMapping(value = "/saveReply", method = RequestMethod.POST)
	public Map<String, Object> saveReply(@RequestBody ReplyVo replyVo, HttpSession session, int replyNumber) throws Exception {

		Map<String, Object> result = new HashMap<>();
		String email = (String)session.getAttribute("email");
		int memberNumber = (int)session.getAttribute("memberNumber");
		String nickName = (String)session.getAttribute("nickName");

		try {
			
			replyVo.setEmail(email);
			replyVo.setMemberNumber(memberNumber);
			replyVo.setNickName(nickName);
			boardService.insertReply(replyVo);
			result.put("status", "OK");
			System.out.println("성공!");
			session.setAttribute("replyNumber", replyNumber);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("status", "False");
			
			
		}	
		return result;
	}

	@ResponseBody
	@RequestMapping(value = "/updateReply")
	public Map<String, Object> updateReply(@RequestBody Map<String, String> params,  
			@ModelAttribute("replyVo")ReplyVo replyVo, HttpServletRequest request, HttpSession session) throws Exception {

		Map<String, Object> result = new HashMap<>();
		//String replyText = request.getParameter("replyText");
		String replyText = params.get("replyText");
		//int replyNumber = (int) session.getAttribute("replyNumber");
		String replyNum = params.get("replyNumber");
		int replyNumber = Integer.parseInt(replyNum);
		
		try {
			replyVo.setReplyNumber(replyNumber);
			replyVo.setReplyText(replyText);
			boardService.updateReply(replyVo);
			result.put("status", "OK");
			System.out.println("성공:"+replyText);
			System.out.println(replyVo.getReplyNumber());
		} catch (Exception e) {
			e.printStackTrace();
			result.put("status", "False");
			System.out.println(replyText);
			System.out.println("실패:"+replyText);
			
		}
		return result;
	}

	@ResponseBody
	@RequestMapping(value = "/deleteReply")
	public Map<String, Object> deleteReply(HttpSession session, @RequestBody  Map<String, String> params,
			@ModelAttribute("replyVo")ReplyVo replyVo) throws Exception {

		Map<String, Object> result = new HashMap<>();
		//String replyText = request.getParameter("replyText");
		int replyNumber = Integer.parseInt(params.get("replyNumber"));
		
		try {
			replyVo.setReplyNumber(replyNumber);
			boardService.deleteReply(replyNumber);
			result.put("status", "OK");
			System.out.println("삭제 성공한 댓글 번호:"+replyNumber);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("status", "False");
			System.out.println("삭제 실패한 댓글 번호:"+replyNumber);
		}
		return result;
	}


	
}
