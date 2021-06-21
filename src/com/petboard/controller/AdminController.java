package com.petboard.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.petboard.repository.BoardVo;
import com.petboard.repository.MemberVo;
import com.petboard.service.BoardServiceImpl;
import com.petboard.service.MemberService;
import com.petboard.service.MemberServiceImpl;
import com.petboard.util.BoardPager;

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
		/*
		 * BoardPager pager = new BoardPager(count, curPage); int start
		 * =pager.getPageBegin(); int end = pager.getPageEnd(); ModelAndView mav =new
		 * ModelAndView(); List<BoardVo> showNewStatus =
		 * boardService.showNewStatus(start,end); mav.setViewName("member/Adminpage");
		 * Map<String,Object> map =new HashMap<String,Object>(); map.put("count",count);
		 * map.put("showNewStatus",showNewStatus); map.put("pager",pager);
		 * mav.addObject("map", map);
		 * 
		 * BoardPager pager2 = new BoardPager(count, curPage); int start2
		 * =pager2.getPageBegin(); int end2 = pager2.getPageEnd(); List<BoardVo>
		 * showNewDelect = boardService.showNewDelect(start2,end2); Map<String,Object>
		 * map2 =new HashMap<String,Object>(); map2.put("count",count);
		 * map2.put("showNewDelect",showNewDelect); map2.put("pager",pager);
		 * mav.addObject("map", map);
		 * 
		 * return mav;
		 */
		
		
		
		/* showNewDelect */
		/* return "member/Adminpage"; */

	@RequestMapping(value="/admin/memberList")
    public String showNewOption(Model model,MemberVo memberVo ,BoardVo boardVo) {

        List<MemberVo> showNewOption = memberService.showNewOption(memberVo);
        model.addAttribute("showNewOption",showNewOption);

        return "jsonView";
    }
	
}
