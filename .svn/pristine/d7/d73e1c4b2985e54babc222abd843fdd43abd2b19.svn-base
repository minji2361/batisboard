package com.petboard.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.servlet.ModelAndView;

import com.petboard.repository.BoardVo;
import com.petboard.repository.LikeCountVo;
import com.petboard.service.BoardServiceImpl;
import com.petboard.util.BoardPager;

@Controller
//@RequestMapping("/board/petchatboard/")
//method=RequestMethod.POST
public class PetChatController {
	
	private BoardServiceImpl boardService;
	public PetChatController(BoardServiceImpl boardService) {
		this.boardService = boardService;
	}
	
	// 게시판 페이지
	@RequestMapping(value="/petchat")
	public ModelAndView petchatBoard(Model model,BoardVo boardVo,
			@RequestParam(defaultValue="1") int curPage,HttpServletRequest request) {
		String type="petchat";
		int count=boardService.showNewListCount(type);
		BoardPager pager = new BoardPager(count, curPage);
		int start =pager.getPageBegin();
		int end = pager.getPageEnd();
		String oder=request.getParameter("oder");
		ModelAndView mav =new ModelAndView();
		List<BoardVo> showNewList = boardService.showNewList(type,oder,start,end);
		mav.setViewName("board/petchatboard/PetchatBoard");
		Map<String,Object> map =new HashMap<String,Object>();
		
		map.put("count",count);
		map.put("showNewList",showNewList);
		map.put("pager",pager);
		mav.addObject("map", map);
		return mav;
	}
	
	// 글 작성 페이지로 이동
	@RequestMapping(value="/petchatWritePage")
	public String writePage(Model model, HttpServletRequest request, 
			HttpSession session) {
		String loginNick = (String) session.getAttribute("nickName");
		
//		int boardNumber = (int) session.getAttribute("boardNumber");
				
		if(loginNick != null) {
			int memberLevel = (int) session.getAttribute("memberLevel"); // 관리자 레벨 확인	
//			if(boardNumber == null) {
				model.addAttribute("board", new BoardVo());
				model.addAttribute("loginNick", loginNick);
				model.addAttribute("memberLevel", memberLevel);
//			} else {
//				model.addAttribute("boardVo", boardService.select(boardNumber));
//			}
			return "/board/petchatboard/PetchatWrite";
		} else {
			return "redirect:/petchat";
		}
		
	}
	
//	@Autowired
//	ServletContext context;
	
	// 글 작성 (insert)
	@RequestMapping(value="/petchatInsert", method=RequestMethod.POST)
	public String writeInsert(Model model, @ModelAttribute("board")BoardVo board, 
			HttpServletRequest request, HttpServletResponse response, MultipartHttpServletRequest upload,
			HttpSession session) {
		
//		String savePath = "/resources/imgstorage";
//		int uploadFileSizeLimit = 5 * 1024 * 1024;
//		String encType = "UTF-8";
//		String uploadFilePath = 
//		MultipartRequest multi = new MultipartRequest();
				int userNum = (int)session.getAttribute("memberNumber");
				board.setMemberNumber(userNum);
				String email = (String)session.getAttribute("email");
				board.setEmail(email);
				board.setArea("");
				String notice = request.getParameter("notice");
				if(notice == null) board.setNotice('n');
				else board.setNotice('y');
//				board.setType("lostpet");
//				String placeLa = request.getParameter("latitude");
//				String placeMa = request.getParameter("longitude");
//				String placeName = request.getParameter("mapPlace");
				String placeLa = upload.getParameter("latitude");
				String placeMa = upload.getParameter("longitude");
				String placeName = upload.getParameter("mapPlace");
				board.setFileName("");
				board.setFileOriName("");
				board.setFilePath("");
				board.setFileType("");
				board.setFileSize(0);
				float latitude = Float.parseFloat(placeLa);
				float longitude = Float.parseFloat(placeMa);
				board.setLatitude(0);
				board.setLongitude(0);
				board.setMapPlace("");
				board.setBoardStatus('n');
				
				
				boardService.write(board); 
				System.out.println(toString());
					return "redirect:/petchat";
	}
	
	@Autowired
	ServletContext context;
	
	@RequestMapping(value="/imageUpload.do", method = RequestMethod.POST)
    public void imageUpload(HttpServletRequest request,
            HttpServletResponse response, MultipartHttpServletRequest multiFile
            , @RequestParam MultipartFile upload) throws Exception{
		// 한글깨짐을 방지하기위해 문자셋 설정
        response.setCharacterEncoding("utf-8");
 
        // 마찬가지로 파라미터로 전달되는 response 객체의 한글 설정
        response.setContentType("text/html; charset=utf-8");
 
        // 업로드한 파일 이름
        String fileName = upload.getOriginalFilename();
 
        // 파일을 바이트 배열로 변환
        byte[] bytes = upload.getBytes();
 
        // 이미지를 업로드할 디렉토리(배포 디렉토리로 설정)
        String savePath = "/resources/imgstorage/";
//        String uploadFile = context.getRealPath(savePath);
//        System.out.println("경로" + uploadFile);
        String uploadPath = "C:\\study\\petboard\\petBoard\\webapp\\resources\\imgstorage\\"; 
        
        OutputStream out = new FileOutputStream(new File(uploadPath + fileName));
 
        // 서버로 업로드
        // write메소드의 매개값으로 파일의 총 바이트를 매개값으로 준다.
        // 지정된 바이트를 출력 스트립에 쓴다 (출력하기 위해서)
        out.write(bytes);
 
        // 클라이언트에 결과 표시
        String callback = request.getParameter("CKEditorFuncNum");
 
        // 서버=>클라이언트로 텍스트 전송(자바스크립트 실행)
        PrintWriter printWriter = response.getWriter();
        String fileUrl = request.getContextPath() + "/resources/imgstorage/" + fileName;
        printWriter.println("{\"filename\" : \""+fileName+"\", \"uploaded\" : 1, \"url\":\""+fileUrl+"\"}");
        printWriter.flush();
    }
	
	//글 내용 보기
	@RequestMapping(value="petchatContent/{boardNumber}")
	public String contentPage(Model model, @PathVariable int boardNumber, HttpSession session) {
		model.addAttribute("boardVo", boardService.select(boardNumber));
		String loginNick = (String)session.getAttribute("nickName");
		int memberLevel;
		if (loginNick == null) { memberLevel=1; loginNick="null";}
		else { 
			memberLevel = (int) session.getAttribute("memberLevel");
			model.addAttribute("loginNick", loginNick);
			model.addAttribute("memberLevel", memberLevel);
		}
		
				return "/board/petchatboard/PetchatContent";
	}
	
	//추천하기
		@RequestMapping(value = "/petchatupdateLike/{boardNumber}")
		@ResponseBody
		public String updateLike(@PathVariable int boardNumber,Model model,HttpSession session,
				LikeCountVo likeCountVo, HttpServletRequest request) {
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
//			model.addAttribute(likeCountVo);
//			likeCountVo.setBoardNumber(boardNumber);
//			likeCountVo.setEmail(email);
//			likeCountVo.setMemberNumber(memberNumber);
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
		@RequestMapping(value = "/petchatlikeCount/{boardNumber}")
		@ResponseBody
		public int likeCount(Model model, HttpSession session,@PathVariable int boardNumber) {
				  
			  int count=boardService.countLike(boardNumber); 
			  System.out.println("추천카운트값:"+count);
			  return count;
			
	       
	      }
	
	//글 수정 페이지
	@RequestMapping(value="petchatUpdatePage/{boardNumber}&{writerNickName}")
	public String updatePage(Model model, @PathVariable int boardNumber, @PathVariable String writerNickName, 
			HttpSession session, HttpServletRequest request) {
		int memberLevel = (int) session.getAttribute("memberLevel");
		String loginNick = (String) session.getAttribute("nickName");	
		
		if(writerNickName.equals(loginNick) || memberLevel == 0) {
			model.addAttribute("boardVo", boardService.select(boardNumber));
			model.addAttribute("memberLevel", memberLevel);
			return "/board/petchatboard/PetchatUpdate";			
		} else {
			return "redirect:petchatContent/${boardNumber}";
		}
		
	}
	
	//글 수정하기(update)
	@RequestMapping(value="/petchatUpdatePage/petchatUpdate", method=RequestMethod.POST)
	public String petchatUpdate(Model model, HttpSession session, HttpServletRequest request,
			@ModelAttribute("boardVo")BoardVo board) {
		board.setArea("");
		board.setFileName("");
		board.setFileOriName("");
		board.setFilePath("");
		board.setFileType("");
		board.setFileSize(0);
		board.setLatitude(0);
		board.setLongitude(0);
		board.setMapPlace("");
		int boardNumber = Integer.parseInt(request.getParameter("boardNumber"));
		board.setBoardNumber(boardNumber);
		int update = boardService.updateWrite(board);
		if(update == 1) return "redirect:/petchat";
		else return "/board/petchatboard/PetchatUpdate";
	}
	
	//글 삭제하기(update)
	@RequestMapping(value="/petchatDelete/{boardNumber}", method=RequestMethod.GET)
	public String deletePopup(Model model, @PathVariable String boardNumber) {
		int boardNum = Integer.parseInt(boardNumber);
		int delete = boardService.deleteWrite(boardNum);
		System.out.println("삭제" + delete);
		if(delete == 1) return "redirect:/main";
		else return "redirect:/petchatContent/&{boardNumber}";
	}

}
