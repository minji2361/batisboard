package com.petboard.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.text.AttributeSet.ParagraphAttribute;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.style.DefaultValueStyler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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

import com.fasterxml.jackson.databind.ser.std.StdKeySerializers.Default;
import com.petboard.repository.BoardVo;
import com.petboard.repository.LikeCountVo;
import com.petboard.repository.ReplyVo;
import com.petboard.service.BoardServiceImpl;
import com.petboard.util.BoardPager;



@Controller
public class HospitalController {
	
	private BoardServiceImpl boardService;
	static Logger log =LoggerFactory.getLogger(HospitalController.class);
	
	public HospitalController(BoardServiceImpl boardService) {
		this.boardService = boardService;
	}

	
	/** 애견치료소게시판 리스트 조회
	 * @param model
	 * @param boardVo
	 * @return
	 */
	//40~ 58 컨트롤러 복사 , String type = "각자 게시판 종류"	
	@RequestMapping(value="/Hospitalboard")
	public ModelAndView HospitalBoard(Model model,BoardVo boardVo,@RequestParam(defaultValue="1") int curPage,HttpServletRequest requst) {
		String type="hospital";
		int count=boardService.showNewListCount(type);
		BoardPager pager = new BoardPager(count, curPage);
		int start =pager.getPageBegin();
		int end = pager.getPageEnd();
		String oder=requst.getParameter("oder");
		ModelAndView mav =new ModelAndView();
		List<BoardVo> showNewList = boardService.showNewList(type,oder,start,end);
		mav.setViewName("board/hospitalboard/HospitalBoard");
		Map<String,Object> map =new HashMap<String,Object>();
		
		map.put("count",count);
		map.put("showNewList",showNewList);
		map.put("pager",pager);
		mav.addObject("map", map);
		return mav;
	}
	
	// 글 작성 페이지로 이동
	@RequestMapping(value= "/HospitalWritePage")
	public String writePage(Model model, HttpServletRequest request, HttpSession session) {
		String loginNick = (String) session.getAttribute("nickName");
		
		if(loginNick != null) {
			int memberLevel = (int) session.getAttribute("memberLevel"); // 관리자 레벨 확인	

				model.addAttribute("board", new BoardVo());
				model.addAttribute("loginNick", loginNick);
				model.addAttribute("memberLevel", memberLevel);
			return "/board/hospitalboard/HospitalWrite";
		} else {
			return "redirect:/Hospitalboard";
		}
		
	}
	
	// 글 작성 (insert)
	@RequestMapping(value= "/HospitalInsert", method=RequestMethod.POST)
	public String writeInsert(Model model, @ModelAttribute("board")BoardVo board, 
			HttpServletRequest request, HttpServletResponse response, MultipartHttpServletRequest upload,
			HttpSession session) {
		
				int userNum = (int)session.getAttribute("memberNumber");
				board.setMemberNumber(userNum);
				String email = (String)session.getAttribute("email");
				board.setEmail(email);
				board.setArea("");
				String notice = request.getParameter("notice");
				if(notice == null) board.setNotice('n');
				else board.setNotice('y');
				board.setFileName("");
				board.setFileOriName("");
				board.setFilePath("");
				board.setFileType("");
				board.setFileSize(0);
				board.setLatitude(0);
				board.setLongitude(0);
				board.setMapPlace("");
				board.setBoardStatus('n');
				
				
				boardService.write(board); 
				System.out.println(toString());
					return "redirect:/Hospitalboard";
	}
	
	@Autowired
	ServletContext context;
	

	@RequestMapping(value="/HospitalimageUpload.do", method = RequestMethod.POST)
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
        String uploadPath = "C:\\study\\petboard\\HospitalBoard\\webapp\\resources\\imgstorage\\"; 
        
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
	
	//글 내용 보기 o
	@RequestMapping(value="HospitalContent")
	public String contentPage(Model model, HttpSession session , HttpServletRequest request) {
		Integer.parseInt(request.getParameter("boardNumber"));
		model.addAttribute("boardVo", boardService.select(Integer.parseInt(request.getParameter("boardNumber"))));
		String loginNick = (String)session.getAttribute("nickName");
		
		int memberNumber;
		int memberLevel;
		if (loginNick == null) { 
			memberLevel=1; loginNick="null"; memberNumber=-1;
			model.addAttribute("memberNumber", memberNumber);
			model.addAttribute("memberLevel", memberLevel);
			}
		else { 
			memberLevel = (int) session.getAttribute("memberLevel");
			memberNumber = (int)session.getAttribute("memberNumber");
			model.addAttribute("memberNumber", memberNumber);
			model.addAttribute("loginNick", loginNick);
			model.addAttribute("memberLevel", memberLevel);
			model.addAttribute("replyVo", new ReplyVo());
		}
		
				return "/board/hospitalboard/HospitalContent";
	}	
	
	
	//추천하기 o
		@RequestMapping(value = "/HospitalupdateLike/{boardNumber}")
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

		
		//추천수 o
		@RequestMapping(value = "/HospitallikeCount/{boardNumber}")
		@ResponseBody
		public int likeCount(Model model, HttpSession session,@PathVariable int boardNumber) {
				  
			  int count=boardService.countLike(boardNumber); 
			  System.out.println("추천카운트값:"+count);
			  return count;
			
	       
	      }		
		
		//댓글 리스트 출력 o
		@ResponseBody
		@RequestMapping(value = "/HospitalgetReplyList", method = RequestMethod.POST)
		public List<ReplyVo> getReplyList(@RequestParam("boardNumber") int boardNumber) throws Exception {
			int replyCount = boardService.countReply(boardNumber);
			return boardService.selectReply(boardNumber);

		}

		@ResponseBody
		@RequestMapping(value = "/HospitalsaveReply", method = RequestMethod.POST)
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
				System.out.println("성공!");
			} catch (Exception e) {
				e.printStackTrace();
				result.put("status", "False");
				
			}	
			return result;
		}

	//댓글업뎃 o
	@ResponseBody
	@RequestMapping(value = "/HospitalupdateReply")
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

	//댓글삭제 o
	@ResponseBody
	@RequestMapping(value = "/HospitaldeleteReply")
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

	//글 수정 페이지 o
	@RequestMapping(value="HospitalUpdatePage/{boardNumber}&{writerNickName}")
	public String updatePage(Model model, @PathVariable int boardNumber, @PathVariable String writerNickName, 
			HttpSession session, HttpServletRequest request) {
		int memberLevel = (int) session.getAttribute("memberLevel");
		String loginNick = (String) session.getAttribute("nickName");	
		
		if(writerNickName.equals(loginNick) || memberLevel == 0) {
			model.addAttribute("boardVo", boardService.select(boardNumber));
			model.addAttribute("memberLevel", memberLevel);
			return "/board/hospitalboard/HospitalUpdate";			
		} else {
			return "redirect:HospitalContent/${boardNumber}";
		}		
	}
	
	//글 수정하기(update) o
	@RequestMapping(value="/HospitalUpdatePage/HospitalUpdate", method=RequestMethod.POST)
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
		if(update == 1) return "redirect:/hospital";
		else return "/board/hospitalboard/HospitalUpdate";
	}		
	
	//글 삭제하기(update) o
	@RequestMapping(value="/HospitalDelete/{boardNumber}", method=RequestMethod.GET)
	public String deletePopup(Model model, @PathVariable String boardNumber) {
		int boardNum = Integer.parseInt(boardNumber);
		int delete = boardService.deleteWrite(boardNum);
		System.out.println("삭제" + delete);
		if(delete == 1) return "redirect:/main";
		else return "redirect:/HospitalContent/&{boardNumber}";
	}
}

