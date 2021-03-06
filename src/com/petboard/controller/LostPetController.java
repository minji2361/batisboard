package com.petboard.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.petboard.repository.BoardVo;
import com.petboard.repository.LikeCountVo;
import com.petboard.repository.ReplyVo;
import com.petboard.service.BoardServiceImpl;
import com.petboard.util.BoardPager;

@Controller
public class LostPetController {
	
	private BoardServiceImpl boardService;
	public LostPetController(BoardServiceImpl boardService) {
		this.boardService = boardService;
	}
	
	@RequestMapping(value="/lostpetboard")
	public ModelAndView LostpetBoard(Model model,BoardVo boardVo,@RequestParam(defaultValue="1") int curPage,
			HttpServletRequest request) {
		String type="lostpet";
		List<BoardVo> lostpetNotice = boardService.noticeList(type);
		int count=boardService.showNewListCount(type);
		BoardPager pager = new BoardPager(count, curPage);
		int start =pager.getPageBegin();
		int end = pager.getPageEnd();
		String oder=request.getParameter("oder");
		ModelAndView mav =new ModelAndView();
		List<BoardVo> showNewList = boardService.showNewList(type,oder,start,end);
		mav.setViewName("board/lostpetboard/Lostpetboard");
		Map<String,Object> map =new HashMap<String,Object>();
		
		map.put("lostpetNotice", lostpetNotice);
		map.put("count",count);
		map.put("showNewList",showNewList);
		map.put("pager",pager);
		mav.addObject("map", map);
		return mav;
	}

	
	//???????????? ?????????
	@RequestMapping(value="/lostpetWrite")
	public String writePage(Model model, HttpServletRequest request, 
			HttpSession session) {
		String loginNick = (String) session.getAttribute("nickName");
				
		if(loginNick != null) {
			int memberLevel = (int) session.getAttribute("memberLevel"); // ????????? ?????? ??????	

				model.addAttribute("board", new BoardVo());
				model.addAttribute("loginNick", loginNick);
				model.addAttribute("memberLevel", memberLevel);

			return "/board/lostpetboard/LostpetWrite";
		} else {
			return "redirect:/lostpetboard";
		}
		
	}
	
	
	
//	//???????????? ?????????
//	@RequestMapping(value="/lostpetWrite", method=RequestMethod.GET)
//	public String write(Model model, HttpSession session) {
//		
//		String email = (String)session.getAttribute("email");
//		
//		if(email != null) {
//			model.addAttribute("board", new BoardVo());
//			return "/board/lostpetboard/LostpetWrite";
//		}
//		else {
//			return "redirect:/lostpetboard";
//		}
//	}
//	
	
	
	//?????? ??????
		@RequestMapping(value="/lostpetWrite", method=RequestMethod.POST)
		public String write(@ModelAttribute("boardVo")BoardVo boardVo, Model model, 
				HttpServletRequest request, HttpServletResponse response, MultipartHttpServletRequest upload,
				HttpSession session) {	

			int memberNumber = (int)session.getAttribute("memberNumber");
			String email = (String)session.getAttribute("email");		
			boardVo.setMemberNumber(memberNumber);
			boardVo.setEmail(email);			
			String notice = request.getParameter("notice");
			if(notice == null) boardVo.setNotice('n');
			else boardVo.setNotice('y');
			boardVo.setFileName("");
			boardVo.setFileOriName("");
			boardVo.setFilePath("");
			boardVo.setFileType("");
			boardVo.setFileSize(0);
			String placeLa = upload.getParameter("latitude");
			String placeMa = upload.getParameter("longitude");
			String mapPlace = upload.getParameter("mapPlace");
			if(placeLa == null || placeMa == null || mapPlace == null) {
				boardVo.setLatitude(0);
				boardVo.setLongitude(0);
				boardVo.setMapPlace("");
			}else {
				float latitude = Float.parseFloat(placeLa);
				float longitude = Float.parseFloat(placeMa);
				boardVo.setLatitude(latitude);
				boardVo.setLongitude(longitude);
				boardVo.setMapPlace(mapPlace);
			}
			
			
			boardVo.setBoardStatus('n');
			
			
			boardService.write(boardVo); 
			System.out.println(toString());
				return "redirect:/lostpetboard";
	}
		
	@RequestMapping(value="/lostpetImageUpload.do", method = RequestMethod.POST)
    public void lostpetImageUpload(HttpServletRequest request,
            HttpServletResponse response, MultipartHttpServletRequest multiFile
            , @RequestParam MultipartFile upload) throws Exception{
		// ??????????????? ?????????????????? ????????? ??????
        response.setCharacterEncoding("utf-8");
 
        // ??????????????? ??????????????? ???????????? response ????????? ?????? ??????
        response.setContentType("text/html; charset=utf-8");
 
        // ???????????? ?????? ??????
        String fileName = upload.getOriginalFilename();
 
        // ????????? ????????? ????????? ??????
        byte[] bytes = upload.getBytes();
 
        // ???????????? ???????????? ????????????(?????? ??????????????? ??????)
        String savePath = "/resources/imgstorage/";
//	        String uploadFile = context.getRealPath(savePath);
//	        System.out.println("??????" + uploadFile);
        String uploadPath = "D:\\study\\workspaceproject\\petBoard\\webapp\\resources\\imgstorage\\"; 
        
        OutputStream out = new FileOutputStream(new File(uploadPath + fileName));
 
        // ????????? ?????????
        // write???????????? ??????????????? ????????? ??? ???????????? ??????????????? ??????.
        // ????????? ???????????? ?????? ???????????? ?????? (???????????? ?????????)
        out.write(bytes);
 
        // ?????????????????? ?????? ??????
        String callback = request.getParameter("CKEditorFuncNum");
 
        // ??????=>?????????????????? ????????? ??????(?????????????????? ??????)
        PrintWriter printWriter = response.getWriter();
        String fileUrl = request.getContextPath() + "/resources/imgstorage/" + fileName;
        printWriter.println("{\"filename\" : \""+fileName+"\", \"uploaded\" : 1, \"url\":\""+fileUrl+"\"}");
        printWriter.flush();
    }
	
	
//	//?????? ??????
//	@RequestMapping(value="/lostpetWrite", method=RequestMethod.POST)
//	public String write(@ModelAttribute("boardVo")BoardVo boardVo, Model model, 
//			HttpServletRequest request, HttpServletResponse response, MultipartHttpServletRequest upload,
//			HttpSession session) {	
//
//		int memberNumber = (int)session.getAttribute("memberNumber");
//		String email = (String)session.getAttribute("email");
//		
//		boardVo.setMemberNumber(memberNumber);
//		boardVo.setEmail(email);
//		
//		boardService.write(boardVo); 
//		System.out.println(toString());
//			return "redirect:/board/lostpetboard/Lostpetboard";
//}

	
	//??? ?????? ??????
	@RequestMapping(value="/lostpetContent/{boardNumber}")
	public String contentPage(Model model, @PathVariable int boardNumber, HttpSession session) {
		model.addAttribute("boardVo", boardService.select(boardNumber));
		String loginNick = (String)session.getAttribute("nickName");
		
		int memberNumber;
		int memberLevel;
		if (loginNick == null) {
			memberLevel=1; loginNick="null";  memberNumber=-1;
			model.addAttribute("memberNumber", memberNumber);
			model.addAttribute("memberLevel", memberLevel);
			
		}
		else { 
			memberLevel = (int) session.getAttribute("memberLevel");
			memberNumber = (int)session.getAttribute("memberNumber");
			model.addAttribute("loginNick", loginNick);
			model.addAttribute("memberLevel", memberLevel);
			model.addAttribute("replyVo", new ReplyVo());
		}
		
				return "/board/lostpetboard/LostpetContent";
	}	
	
//	//??? ????????????
//	@RequestMapping(value="/lostpetContent/{boardNumber}")
//	public String read(Model model,@PathVariable int boardNumber) {
//		model.addAttribute("boardVo", boardService.select(boardNumber));
//	
//		model.addAttribute("replyVo", new ReplyVo());
//		return "/board/lostpetboard/LostpetContent";
//	}
	
	//????????????
	@RequestMapping(value = "/lostpetLike/{boardNumber}")
	@ResponseBody
	public String updateLike(@PathVariable int boardNumber,Model model,HttpSession session,
			LikeCountVo likeCountVo, HttpServletRequest request) {
		System.out.println("????");
		
		String email = (String)session.getAttribute("email"); 
		int memberNumber = (int)session.getAttribute("memberNumber");
		
		System.out.println("????????????"+boardNumber);
		System.out.println("?????????:"+ email);
		System.out.println("????????????"+memberNumber);
		
		Map<String, Object> m = new HashMap<>();
        m.put("boardNumber", boardNumber);
        m.put("email",email);
		
        
		int result = boardService.checkLike(m);
//				model.addAttribute(likeCountVo);
//				likeCountVo.setBoardNumber(boardNumber);
//				likeCountVo.setEmail(email);
//				likeCountVo.setMemberNumber(memberNumber);
		System.out.println("???:"+result);
		if(result == 0 ) {
			boardService.updateLike(m);
			boardService.plusLikecount(boardNumber);
			System.out.println("?????? ???");
		}else {
			boardService.deleteLike(m);
			boardService.minusLikecount(boardNumber);
			System.out.println("?????? ?????? ???");
		}
		return null;
			
		
	}
	
	//????????? 
	@RequestMapping(value = "/lostpetlikeCount/{boardNumber}")
	@ResponseBody
	public int likeCount(Model model, HttpSession session,@PathVariable int boardNumber) {
			  
		  int count=boardService.countLike(boardNumber); 
		  System.out.println("??????????????????:"+count);
		  return count;
		
       
      }
	
	//??? ?????? ?????????
	@RequestMapping(value="/lostpetUpdate/{boardNumber}&{writerNickName}")
	public String updatePage(Model model, @PathVariable int boardNumber, @PathVariable String writerNickName, 
			HttpSession session, HttpServletRequest request) {
		int memberLevel = (int) session.getAttribute("memberLevel");
		String loginNick = (String) session.getAttribute("nickName");	
		
		if(writerNickName.equals(loginNick) || memberLevel == 0) {
			model.addAttribute("boardVo", boardService.select(boardNumber));
			model.addAttribute("memberLevel", memberLevel);
			return "/board/lostpetboard/LostpetEdit";			
		} else {
			return "redirect:/board/lostpetboard/LostpetContent/${boardNumber}";
		}
		
	}
	
	//??? ????????????(update)
		@RequestMapping(value="/lostpetUpdate/editContent", method=RequestMethod.POST)
		public String petchatUpdate(Model model, HttpSession session, HttpServletRequest request,
				@ModelAttribute("boardVo")BoardVo board) {
			board.setFileName("");
			board.setFileOriName("");
			board.setFilePath("");
			board.setFileType("");
			board.setFileSize(0);
			String placeLa = request.getParameter("latitude");
			String placeMa = request.getParameter("longitude");
			String placeName = request.getParameter("mapPlace");
			if(placeLa == null || placeMa == null || placeName == null) {
				System.out.println("request : " + placeLa);
				board.setLatitude(0);
				board.setLongitude(0);
				board.setMapPlace("");
			} else {
				System.out.println("request : " + placeLa);
				float latitude = Float.parseFloat(placeLa);
				float longitude = Float.parseFloat(placeMa);
				board.setLatitude(latitude);
				board.setLongitude(longitude);
				board.setMapPlace(placeName);
			}
			int boardNumber = Integer.parseInt(request.getParameter("boardNumber"));
			board.setBoardNumber(boardNumber);
			int update = boardService.updateWrite(board);
			if(update == 1) {
				return "redirect:/lostpetboard";
			}
			else {
				System.out.println(board.getContent());
				System.out.println(board.getTitle());
				return "/board/petchatboard/lostpetUpdate";
			}
		}
	
	//??? ????????????(update)
	@RequestMapping(value="/lostpetDelete/{boardNumber}", method=RequestMethod.GET)
	public String deletePopup(Model model, @PathVariable String boardNumber) {
		int boardNum = Integer.parseInt(boardNumber);
		int delete = boardService.deleteWrite(boardNum);
		System.out.println("??????" + delete);
		if(delete == 1) return "redirect:/lostpetboard";
		else return "redirect:/board/lostpetboard/LostpetContent/&{boardNumber}";
	}	
	
	
//	//??? ??????????????? ????????????
//	@RequestMapping(value="/lostpetEdit/{boardNumber}", method=RequestMethod.GET)
//	public String edit(@PathVariable int boardNumber, Model model) {
//		BoardVo boardVo = boardService.select(boardNumber);
//		model.addAttribute("boardVo", boardVo);
//		return "/board/lostpetboard/LostpetWrite";
//	}
//	
//	//??? ?????? 
//	@RequestMapping(value="/lostpetEdit/{boardNumber}", method=RequestMethod.POST)
//	public String edit(BoardVo boardVo, Model model) {
//		boardService.updateWrite(boardVo);
//		return "redirect:/lostpetboard";
//	}



//	//??? ?????? 
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
	
	//?????? ????????? ??????
		@ResponseBody
		@RequestMapping(value = "/getReplyList", method = RequestMethod.POST)
		public List<ReplyVo> getReplyList(@RequestParam("boardNumber") int boardNumber) throws Exception {
			return boardService.selectReply(boardNumber);

		}

		@ResponseBody
		@RequestMapping(value = "/saveReply", method = RequestMethod.POST)
		public Map<String, Object> saveReply(@RequestBody ReplyVo replyVo, HttpSession session) throws Exception {

			Map<String, Object> result = new HashMap<>();

			try {
				String email = (String)session.getAttribute("email");
				int memberNumber = (int)session.getAttribute("memberNumber");
				String nickName = (String)session.getAttribute("nickName");
				replyVo.setEmail(email);
				replyVo.setMemberNumber(memberNumber);
				replyVo.setNickName(nickName);
				boardService.insertReply(replyVo);
				result.put("status", "OK");
				System.out.println("??????!");
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
			System.out.println("??????:"+replyText);
			System.out.println(replyVo.getReplyNumber());
		} catch (Exception e) {
			e.printStackTrace();
			result.put("status", "False");
			System.out.println(replyText);
			System.out.println("??????:"+replyText);
			
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
			System.out.println("?????? ????????? ?????? ??????:"+replyNumber);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("status", "False");
			System.out.println("?????? ????????? ?????? ??????:"+replyNumber);
		}
		return result;
	}


	
}
