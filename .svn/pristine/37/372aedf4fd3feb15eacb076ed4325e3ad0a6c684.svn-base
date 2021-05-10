package com.petboard.controller;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.petboard.email.emailRan;
import com.petboard.interceptor.LoginCommand;
import com.petboard.repository.BoardVo;
import com.petboard.repository.MemberVo;
import com.petboard.service.BoardService;
import com.petboard.service.MemberService;

//Random random = new Random();
//String key = "";
//
//for(int i=0;i<3;i++) {
//	int index=random.nextInt(25)+65;
//	key+=(char)index;
//}
//int numIndex=random.nextInt(9999)+1000;
//key+=numIndex;

@Controller
public class MemberController {

	@Autowired
	JavaMailSenderImpl mailSender;
	private MemberService memberService;
	private BoardService boardService;

	public MemberController(MemberService memberService, BoardService boardService) {
		this.memberService = memberService;
		this.boardService = boardService;
	}

	// 회원가입페이지 이동
	@RequestMapping("/joinPage")
	public String joinPage(Model model) {
		model.addAttribute("member", new MemberVo());
		return "/member/Joinpage";
	}

	// 이메일 중복검사
	@RequestMapping(value = "checkEmail/{email}")
	@ResponseBody
	public String checkEmail(@PathVariable String email) {
		int emaildupl = memberService.emailCheck(email);
		boolean emaildup;
		if (emaildupl == 1)
			emaildup = false; // 사용할 수 없음
		else
			emaildup = true; // 사용할 수 있음

		return emaildup + "";
	}

	// 이메일 인증
	@RequestMapping(value = "/joinPw", method = RequestMethod.POST)
	public ModelAndView sendEmail(@RequestParam Map<String, Object> paramMap, ModelMap model) throws Exception {

		Map<String, Object> map = new HashMap<>();
		String ran = new emailRan().getKey(6, true);
		System.out.println(ran);
		model.addAttribute("emailran", ran);

		// String USERNAME = (String) paramMap.get("username");
		String EMAIL = (String) paramMap.get("email");
		// String PASSWORD = emailran.numberGen(6, 1);
		String PASSWORD = ran;

		try {
			MimeMessage msg = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(msg, true, "UTF-8");

			// messageHelper.setSubject(USERNAME+"님 인증메일입니다.");
			messageHelper.setSubject("인증메일입니다.");
			messageHelper.setText("인증번호는 " + PASSWORD + " 입니다.");
			messageHelper.setTo(EMAIL);
			msg.setRecipients(MimeMessage.RecipientType.TO, InternetAddress.parse(EMAIL));
			mailSender.send(msg);

		} catch (MessagingException e) {
			System.out.println("MessagingException");
			e.printStackTrace();
		}
//	        mv.setViewName("redirect:/emailSuccess");
		ModelAndView mv = new ModelAndView("member/Joinpage");
		// mv.addObject("message", "인증되었습니다.");
		mv.addObject("key", PASSWORD);
		mv.addObject("email", EMAIL);
		mv.addObject("emailCheck", 0);
		mv.addObject("emailMessage", "사용가능한 이메일 입니다.");
		return mv;
		// return map;
	}

	// 닉네임 중복검사
	@RequestMapping(value = "checkNickName/{nickName}")
	@ResponseBody
	public boolean checkNickName(@PathVariable String nickName) {
		int nickNamedup = memberService.nickNameCheck(nickName);
		boolean nickdup;
		if (nickNamedup == 1)
			nickdup = false; // 사용할 수 없음
		else
			nickdup = true; // 사용할 수 있음

		return nickdup;
	}

	// 회원가입
	@RequestMapping(value = "/joinUser", method = RequestMethod.POST)
	public String joinUser(Model model, @ModelAttribute("member") MemberVo member, HttpSession session) {
		member.setMemberLevel(1);
		member.setMemberStatus('n');
		int join = memberService.insertMember(member);

		if (join == 1) {
			session.setAttribute("password", member);
			return "/main";
		} else
			return "redirect:/joinPage";

	}

	// 로그인페이지 이동
		@RequestMapping("/loginPage")
		public String loginPage(@CookieValue(value = "REMEMBER", required = false) Cookie rCookie,
				LoginCommand loginCommand) {
			// 쿠키생성
			if (rCookie != null) {
				loginCommand.setEmail(rCookie.getValue());
				loginCommand.setRememberEmail(true);
				System.out.println("쿠키ㅜ키쿠");
			}

			return "/member/Login";
		}

		// 로그인
		@RequestMapping(value = "/enterLogin", method = RequestMethod.POST)
		public String checkLogin(Model model, HttpServletRequest request, HttpSession session, 
				HttpServletResponse response, LoginCommand loginCommand) {

			String email = request.getParameter("email");
			String password = request.getParameter("password");
			String nickName = memberService.selectNick(email);
			int memberNumber = memberService.selectMemberNum(email);
			int memberLevel = memberService.selectLevel(memberNumber);

			// 쿠키
			Cookie rememberCookie = new Cookie("REMEMBER", loginCommand.getEmail());
			String eee = (String) loginCommand.getEmail();
			System.out.printf("email:", eee);
			rememberCookie.setPath("/");
			if (loginCommand.isRememberEmail()) {
				rememberCookie.setMaxAge(60 * 60 * 24 * 30);
				System.out.println("쿠키 만들어짐");
			} else {
				rememberCookie.setMaxAge(0);
				System.out.println("쿠키 없어짐");
			}

			int login = memberService.loginCheck(email, password);
			// login -1 아이디 비밀번호 오류
			// login 0 유저 로그인
			// login 1 관리자 로그인
			if (login == -1) {
				session.setAttribute("message", "아이디, 비밀번호를 다시 입력해 주세요.");
				return "/loginPage";
			} else if (login == 1) {
				session.setAttribute("email", email);
				session.setAttribute("message", "집사님");
				session.setAttribute("nickName", nickName);
				session.setAttribute("memberNumber", memberNumber);
				session.setAttribute("memberLevel", memberLevel);
				response.addCookie(rememberCookie);
				return "/main";
			} else {
				session.setAttribute("email", email);
				session.setAttribute("message", "관리자님");
				//session.setAttribute("nickName", nickName);
				session.setAttribute("memberNumber", memberNumber);
				session.setAttribute("memberLevel", memberLevel);
				response.addCookie(rememberCookie);
				return "/main";
			}

		}

	// 로그아웃
	@RequestMapping(value = "/logout")
	public String logout(Model model, HttpSession session) {
		session.invalidate();
		return "/main";
	}

	// 마이페이지 접근 페이지
	@RequestMapping(value = "/mypageaccess", method = RequestMethod.GET)
	public String mypageaccess() {
		return "/member/MypageAccess";
	}

	// 마이페이지 요청
    @RequestMapping(value = "/mypageaccess.do", method = RequestMethod.POST)
    public String enterUserpage(MemberVo memberVo, HttpSession session, HttpServletRequest request, Model model,RedirectAttributes rttr)
            throws Exception {
        int memberNumber = (int) session.getAttribute("memberNumber");
        String enterpassword = request.getParameter("enterpassword");
        String email = (String) session.getAttribute("email");
        String dbpassword = memberService.checkPwd(email);
        int memberLevel = (int) session.getAttribute("memberLevel");

        System.out.println("enterpassword:" + enterpassword);
        System.out.println("이메일:" + email);
        System.out.println("db비밀번호:" + dbpassword);

        if (dbpassword.equals(enterpassword)) {
            if (memberLevel != 0) {
                rttr.addAttribute("memberNumber", memberNumber);
                return "redirect:/memberpage/{memberNumber}";
            } else {
                return "redirect:/adminpage";
            }

        } else {
			 rttr.addFlashAttribute("msg", "비밀번호가 일치하지 않습니다.");
			 
            return "redirect:/mypageaccess";
        }
    }

	// 유저페이지에 유저 정보 담아오기
	@RequestMapping(value = "/memberpage/{memberNumber}", method = RequestMethod.GET)
	public String memberpage(@PathVariable int memberNumber, Model model, HttpSession session) {
		MemberVo memberVo = memberService.selectUser(memberNumber);
		model.addAttribute("memberVo", memberVo); // 유저 정보 vo

		String nickName = (String) session.getAttribute("nickName");
		List<BoardVo> boardVo = boardService.myWriteList(nickName);
		model.addAttribute("boardVo", boardVo); // 내가 쓸 글 리스트

		int countWrite = boardService.countWrite(memberNumber);
		model.addAttribute("countWrite", countWrite); // 내가 쓴 글 갯수
		return "/member/Memberpage";
	}

	// 어드민페이지
	@RequestMapping(value = "/adminpage", method = RequestMethod.GET)
	public String adminpage(Model model, String email, String boardStatus, HttpSession session) {
		int memberNumber = (int) session.getAttribute("memberNumber");
		model.addAttribute("memberNumber", memberNumber);
		return "/member/Adminpage";
	}

	// 회원정보 수정 페이지 불러오기
	@RequestMapping(value = "/updateMember/{memberNumber}", method = RequestMethod.GET)
	public String EnterUpdateMember(Model model, HttpSession session) {
		int memberNumber = (int) session.getAttribute("memberNumber");
		MemberVo memberVo = memberService.selectUser(memberNumber);
		model.addAttribute("memberNumber", memberNumber);
		model.addAttribute("memberVo", memberVo);
		return "/member/MemberUpdate";

	}

	// 회원정보수정
	@RequestMapping(value = "/updateMember/{memberNumber}", method = RequestMethod.POST)
	public String updateMember(@ModelAttribute("memberVo") MemberVo memberVo, Model model, HttpSession session,
			HttpServletRequest request) {
		int memberNumber = (int) session.getAttribute("memberNumber");
		System.out.println("멤버넘버" + memberNumber);
		memberVo = memberService.selectUser(memberNumber);

		// input창에 입력되는 parameter들 가져오기
		String nickName = request.getParameter("nickName");
		String pet = request.getParameter("pet");

		memberVo.setNickName(nickName);
		memberVo.setPet(pet);
		memberVo.setMemberNumber(memberNumber);
		int update = memberService.updateUser(memberVo);
		// true = 1 , false = 0;
		if (update == 1) {
			System.out.println("수정성공");
			System.out.println("유저닉넴:" + memberVo.getNickName());
			System.out.println("유저펫:" + memberVo.getPet());
			return "redirect:/memberpage/{memberNumber}";
		} else {
			System.out.println("수정실패");
			System.out.println("유저닉넴:" + memberVo.getNickName());
			System.out.println("유저펫:" + memberVo.getPet());
			return "/member/updateMember/{memberNumber}";
		}
	}

	// 탈퇴 비밀번호 작성 페이지 요청
	@RequestMapping(value = "/memberdeletecheck", method = RequestMethod.GET)
	public String memberdeletecheck(Model model) {
		return "/member/MemberDeleteCheck";
	}

	// 탈퇴 요청
	@RequestMapping(value = "/memberdelete", method = {RequestMethod.GET, RequestMethod.POST})

	public String memberDelete(HttpSession session, HttpServletRequest request, Model model,RedirectAttributes rttr) throws Exception {
		int memberNumber = (int) session.getAttribute("memberNumber");
		String enterpassword = request.getParameter("enterpassword");
		String email = (String) session.getAttribute("email");
		String dbpassword = memberService.checkPwd(email);

		System.out.println("enterpassword:" + enterpassword);
		System.out.println("이메일:" + email);
		System.out.println("db비밀번호:" + dbpassword);

		if (dbpassword.equals(enterpassword)) {
			memberService.deleteUser(memberNumber);
			session.invalidate();
			return "redirect:/memberDeleteEnd";
		} else {
			rttr.addFlashAttribute("msg","비밀번호가 일치하지 않습니다.");
			return "redirect:/memberdeletecheck";
		}

	}
	
	//탈퇴 완료 페이지
	@RequestMapping(value = "/memberDeleteEnd")
	public String memberDeleteEnd(Model model) {
		return "member/MemberDeleteEnd";
	}
	


	private String passwordcheck(String password, HttpSession session) {
		// TODO Auto-generated method stub
		return null;
	}

	// 비밀번호 변경 페이지 접근
	@RequestMapping(value = "/memberpage/updatePassword", method = RequestMethod.GET)
	public String passwordEdit(Model model) {

		return "member/Updatepwd";
	}

	// 기존 비밀번호 확인
	@ResponseBody
	@RequestMapping(value = "/memberpage/checkpwd", method = RequestMethod.POST)
	public String checkPwd(HttpSession session, @RequestParam(value = "authpassword") String authpassword)
			throws Exception {
		String email = (String) session.getAttribute("email");
		String dbpassword = memberService.checkPwd(email);

		System.out.println("dbpassword" + dbpassword);
		System.out.println("authpassword" + authpassword);

		boolean checkPwd;
		if (dbpassword.equals(authpassword))
			checkPwd = true;
		else
			checkPwd = false;

		return checkPwd + "";
	}

	// 비밀번호 변경
	@RequestMapping(value = "/memberpage/editPassword", method = RequestMethod.POST)
	public String editPassword(HttpSession session, // HttpServletRequest request
			String password, MemberVo memberVo) throws Exception {
		String email = (String) session.getAttribute("email");
		// String password = (String)request.getAttribute("password");

		// System.out.println("password:"+password);
		// System.out.println("email:"+email);
		memberVo.setEmail(email);
		memberVo.setPassword(password);
		int editPwd = memberService.updatePwd(memberVo);

		if (editPwd == 1) {
			session.invalidate();
			return "redirect:/main";
		} else {

		}
		return "";
	}
	//비밀번호 변경페이지 이동
	@RequestMapping(value = "/FindPwd", method= RequestMethod.GET)
	public String FindPwd(@RequestParam Map<String, Object> paramMap, ModelMap model,HttpServletRequest request,String password, MemberVo memberVo){
		
		
		return "member/FindPwd";
		
	}
	//비밀번호 찾기 & 난수로 변경
	@RequestMapping(value = "/FindPwd",method = RequestMethod.POST)
	public String pwdChange(@RequestParam Map<String, Object> paramMap, ModelMap model,HttpServletRequest request,String password, MemberVo memberVo) {
		Map<String, Object> map = new HashMap<>();
		String ran = new emailRan().getKey(6, true);
		System.out.println(ran);
		model.addAttribute("emailran", ran);

		String EMAIL = request.getParameter("email");
		String PASSWORD = ran;
		int result = memberService.emailCheck(EMAIL);
		
		if(result == 1) {

		try {
			MimeMessage msg = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(msg, true, "UTF-8");

			// messageHelper.setSubject(USERNAME+"님 인증메일입니다.");
			messageHelper.setSubject("비밀번호변경메일입니다.");
			messageHelper.setText("비밀번호는 " + PASSWORD + " 입니다."
					+"로그인 후 비밀번호를 꼭 변경해주세요."+"감사합니다.");
			messageHelper.setTo(EMAIL);
			msg.setRecipients(MimeMessage.RecipientType.TO, InternetAddress.parse(EMAIL));
			mailSender.send(msg);

		} catch (MessagingException e) {
			System.out.println("MessagingException");
			e.printStackTrace();
		}
		memberVo.setEmail(EMAIL);
		memberVo.setPassword(PASSWORD);
			memberService.updatePwd(memberVo);
		
		}
		return "/main";
	}
	
	
	

}
