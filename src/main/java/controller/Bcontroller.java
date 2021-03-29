package controller;


import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;
import javax.annotation.Resources;
import javax.servlet.ServletContext;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import repository.BboardVo;
import repository.Criteria;
import repository.PageMaker;
import service.BboardService;

@Controller("bcontroller")
public class Bcontroller {
	
	private BboardService boardService;
	
	public Bcontroller(BboardService boardService) {
		this.boardService = boardService;
	}

	@RequestMapping(value="/main")
	public String main(Model model, HttpSession session, Criteria cri) {
		List<BboardVo> content = boardService.showList();
		if (content != null) {
			//model.addAttribute("list", boardService.boardPaging(cri));
			model.addAttribute("content", content);
			
//			PageMaker pageMaker = new PageMaker();
//			pageMaker.setCri(cri);
//			pageMaker.setTotalCount(boardService.listCount());
//			
//			model.addAttribute("pageMaker", pageMaker);
		} 
		session.invalidate();
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
	
	
	@Autowired
	ServletContext context;
	
	@RequestMapping(value="/insert", method=RequestMethod.POST)
	public String insert(Model model, @ModelAttribute("board")BboardVo board, 
			@RequestParam("file") MultipartFile file,
			HttpServletRequest request) throws Exception {
		
		//String savePath = "/board/upload/";
		String uploadFilePath = request.getServletContext().getRealPath("/");
		String attachPath = "view/board/upload";
		String fileOriName = file.getOriginalFilename();
		File upFile = new File(uploadFilePath + attachPath, fileOriName);
//		int size = 5 * 1024 * 1024;
//		String encoding = "UTF-8";
		String fileName = request.getParameter("file");
		
		try {
			file.transferTo(upFile);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		if((file!=null) && (!file.isEmpty())) {
			board.setFileName(fileName);
			board.setFileType(file.getContentType());
			board.setFilePath("/board/upload");
			board.setFileOriginalName(fileOriName);
		}
		
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
	
	@RequestMapping(value="/info", method=RequestMethod.GET)
	public String info(Model model, HttpServletRequest request, HttpSession session) {
		String id = request.getParameter("id");
		session.setAttribute("id", id);
		BboardVo board = boardService.getContentInfo(id);
		model.addAttribute("board", board);
		return "/board/bbinfo";
	}
	
	@RequestMapping(value="/update", method=RequestMethod.POST)
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
	
	@RequestMapping(value="/delete", method=RequestMethod.POST)
	public String delete(Model model, HttpServletRequest request, HttpSession session) {
		String id = (String) session.getAttribute("id");
		boolean delete = boardService.deleteContent(id);
		if(delete) 	{
			session.invalidate();
			return "redirect:/main";
		}
		else return "/board/bbinfo";
	}
	
	@RequestMapping(value="/search", method=RequestMethod.POST)
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
