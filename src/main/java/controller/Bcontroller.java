package controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import repository.BboardVo;
import service.BboardService;

@Controller("bcontroller")
public class Bcontroller {
	
	private BboardService boardService;
	
	public Bcontroller(BboardService boardService) {
		this.boardService = boardService;
	}

	@RequestMapping(value="/main" )
	public String main(Model model) {
		List<BboardVo> content = boardService.showList();
		if (content != null) {
			model.addAttribute("content", content);
		} 
		return "/board/bbmain";
	}
	
	@RequestMapping("/write")
	public String write(Model model, HttpServletRequest request) {
		String id = request.getParameter("id");
		if(id == null) {
			model.addAttribute("board", new BboardVo());			
		} else {
			BboardVo board = boardService.getContentInfo(id);
			model.addAttribute("board", board);
			model.addAttribute("id", id);
		}
		return "/board/bbwrite";
		
	}
	
	@RequestMapping("/insert")
	public String insert(Model model, @ModelAttribute("board")BboardVo board) {
		boolean insert = boardService.insertContent(board);
		if (insert) {
			List<BboardVo> content = boardService.showList();
			if (content != null) {
				model.addAttribute("content", content);
			} 
			return "redirect:/main";
		}
		else return "/board/bbwrite";
	}
	
//	@RequestMapping(value="/main/list")
//	public String list(Model model) {
//		List<BboardVo> content = boardService.showList();
//		model.addAttribute("board", content);
//		return "/board/bbmain";
//	}
	
	@RequestMapping("/info")
	public String info(Model model, HttpServletRequest request, HttpSession session) {
		String id = request.getParameter("id");
		session.setAttribute("id", id);
		BboardVo board = boardService.getContentInfo(id);
		model.addAttribute("board", board);
		return "/board/bbinfo";
	}
	
	@RequestMapping("/update")
	public String update(Model model, @ModelAttribute("board")BboardVo board, HttpServletRequest request,
			HttpSession session) {
		String id = (String) session.getAttribute("id");
		boolean update = boardService.updateContent(board, id);
		if (update) {
			List<BboardVo> content = boardService.showList();
			if (content != null) {
				model.addAttribute("content", content);
			} 
			session.invalidate();
			return "redirect:/main";
		}
		else return "/board/bbwrite";
	}
	
	@RequestMapping("/delete")
	public String delete(Model model, HttpServletRequest request, HttpSession session) {
		String id = (String) session.getAttribute("id");
		boolean delete = boardService.deleteContent(id);
		if(delete) 	{
			session.invalidate();
			return "redirect:/main";
		}
		else return "/board/bbinfo";
	}
	
	@RequestMapping("/search")
	public String search(Model model, HttpServletRequest request) {
		String search = request.getParameter("searchWr");
		List<BboardVo> searchRs = boardService.searchWriter(search);
		if(searchRs != null) {
			model.addAttribute("searchWrs", searchRs);
			model.addAttribute("search", search);
			return "/board/bbmain";
		}
		else return "redirect:/main";
	}
	
}
