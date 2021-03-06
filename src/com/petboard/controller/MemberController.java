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

	// ????????????????????? ??????
	@RequestMapping("/joinPage")
	public String joinPage(Model model) {
		model.addAttribute("member", new MemberVo());
		return "/member/Joinpage";
	}

	// ????????? ????????????
	@RequestMapping(value = "checkEmail/{email}")
	@ResponseBody
	public String checkEmail(@PathVariable String email) {
		int emaildupl = memberService.emailCheck(email);
		boolean emaildup;
		if (emaildupl == 1)
			emaildup = false; // ????????? ??? ??????
		else
			emaildup = true; // ????????? ??? ??????

		return emaildup + "";
	}

	// ????????? ??????
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

			// messageHelper.setSubject(USERNAME+"??? ?????????????????????.");
			messageHelper.setSubject("?????????????????????.");
			messageHelper.setText("??????????????? " + PASSWORD + " ?????????.");
			messageHelper.setTo(EMAIL);
			msg.setRecipients(MimeMessage.RecipientType.TO, InternetAddress.parse(EMAIL));
			mailSender.send(msg);

		} catch (MessagingException e) {
			System.out.println("MessagingException");
			e.printStackTrace();
		}
//	        mv.setViewName("redirect:/emailSuccess");
		ModelAndView mv = new ModelAndView("member/Joinpage");
		// mv.addObject("message", "?????????????????????.");
		mv.addObject("key", PASSWORD);
		mv.addObject("email", EMAIL);
		mv.addObject("emailCheck", 0);
		mv.addObject("emailMessage", "??????????????? ????????? ?????????.");
		return mv;
		// return map;
	}

	// ????????? ????????????
	@RequestMapping(value = "checkNickName/{nickName}")
	@ResponseBody
	public boolean checkNickName(@PathVariable String nickName) {
		int nickNamedup = memberService.nickNameCheck(nickName);
		boolean nickdup;
		if (nickNamedup == 1)
			nickdup = false; // ????????? ??? ??????
		else
			nickdup = true; // ????????? ??? ??????

		return nickdup;
	}

	// ????????????
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

	// ?????????????????? ??????
		@RequestMapping("/loginPage")
		public String loginPage(@CookieValue(value = "REMEMBER", required = false) Cookie rCookie,
				LoginCommand loginCommand) {
			// ????????????
			if (rCookie != null) {
				loginCommand.setEmail(rCookie.getValue());
				loginCommand.setRememberEmail(true);
				System.out.println("???????????????");
			}

			return "/member/Login";
		}

		// ?????????
		@RequestMapping(value = "/enterLogin", method = RequestMethod.POST)
		public String checkLogin(Model model, HttpServletRequest request, HttpSession session, 
				HttpServletResponse response, LoginCommand loginCommand) {

			String email = request.getParameter("email");
			String password = request.getParameter("password");
			String nickName = memberService.selectNick(email);
			int memberNumber = memberService.selectMemberNum(email);
			int memberLevel = memberService.selectLevel(memberNumber);

			// ??????
			Cookie rememberCookie = new Cookie("REMEMBER", loginCommand.getEmail());
			String eee = (String) loginCommand.getEmail();
			System.out.printf("email:", eee);
			rememberCookie.setPath("/");
			if (loginCommand.isRememberEmail()) {
				rememberCookie.setMaxAge(60 * 60 * 24 * 30);
				System.out.println("?????? ????????????");
			} else {
				rememberCookie.setMaxAge(0);
				System.out.println("?????? ?????????");
			}

			int login = memberService.loginCheck(email, password);
			// login -1 ????????? ???????????? ??????
			// login 0 ?????? ?????????
			// login 1 ????????? ?????????
			if (login == -1) {
				session.setAttribute("message", "?????????, ??????????????? ?????? ????????? ?????????.");
				return "/loginPage";
			} else if (login == 1) {
				session.setAttribute("email", email);
				session.setAttribute("message", "?????????");
				session.setAttribute("nickName", nickName);
				session.setAttribute("memberNumber", memberNumber);
				session.setAttribute("memberLevel", memberLevel);
				response.addCookie(rememberCookie);
				return "/main";
			} else {
				session.setAttribute("email", email);
				session.setAttribute("message", "????????????");
				//session.setAttribute("nickName", nickName);
				session.setAttribute("memberNumber", memberNumber);
				session.setAttribute("memberLevel", memberLevel);
				response.addCookie(rememberCookie);
				return "/main";
			}

		}

	// ????????????
	@RequestMapping(value = "/logout")
	public String logout(Model model, HttpSession session) {
		session.invalidate();
		return "/main";
	}

	// ??????????????? ?????? ?????????
	@RequestMapping(value = "/mypageaccess", method = RequestMethod.GET)
	public String mypageaccess() {
		return "/member/MypageAccess";
	}

	// ??????????????? ??????
    @RequestMapping(value = "/mypageaccess.do", method = RequestMethod.POST)
    public String enterUserpage(MemberVo memberVo, HttpSession session, HttpServletRequest request, Model model,RedirectAttributes rttr)
            throws Exception {
        int memberNumber = (int) session.getAttribute("memberNumber");
        String enterpassword = request.getParameter("enterpassword");
        String email = (String) session.getAttribute("email");
        String dbpassword = memberService.checkPwd(email);
        int memberLevel = (int) session.getAttribute("memberLevel");

        System.out.println("enterpassword:" + enterpassword);
        System.out.println("?????????:" + email);
        System.out.println("db????????????:" + dbpassword);

        if (dbpassword.equals(enterpassword)) {
            if (memberLevel != 0) {
                rttr.addAttribute("memberNumber", memberNumber);
                return "redirect:/memberpage/{memberNumber}";
            } else {
                return "redirect:/adminpage";
            }

        } else {
			 rttr.addFlashAttribute("msg", "??????????????? ???????????? ????????????.");
			 
            return "redirect:/mypageaccess";
        }
    }

	// ?????????????????? ?????? ?????? ????????????
	@RequestMapping(value = "/memberpage/{memberNumber}", method = RequestMethod.GET)
	public String memberpage(@PathVariable int memberNumber, Model model, HttpSession session) {
		MemberVo memberVo = memberService.selectUser(memberNumber);
		model.addAttribute("memberVo", memberVo); // ?????? ?????? vo

		String nickName = (String) session.getAttribute("nickName");
		List<BoardVo> boardVo = boardService.myWriteList(nickName);
		model.addAttribute("boardVo", boardVo); // ?????? ??? ??? ?????????

		int countWrite = boardService.countWrite(memberNumber);
		model.addAttribute("countWrite", countWrite); // ?????? ??? ??? ??????
		return "/member/Memberpage";
	}

	// ??????????????????
	@RequestMapping(value = "/adminpage", method = RequestMethod.GET)
	public String adminpage(Model model, String email, String boardStatus, HttpSession session) {
		int memberNumber = (int) session.getAttribute("memberNumber");
		model.addAttribute("memberNumber", memberNumber);
		return "/member/Adminpage";
	}

	// ???????????? ?????? ????????? ????????????
	@RequestMapping(value = "/updateMember/{memberNumber}", method = RequestMethod.GET)
	public String EnterUpdateMember(Model model, HttpSession session) {
		int memberNumber = (int) session.getAttribute("memberNumber");
		MemberVo memberVo = memberService.selectUser(memberNumber);
		model.addAttribute("memberNumber", memberNumber);
		model.addAttribute("memberVo", memberVo);
		return "/member/MemberUpdate";

	}

	// ??????????????????
	@RequestMapping(value = "/updateMember/{memberNumber}", method = RequestMethod.POST)
	public String updateMember(@ModelAttribute("memberVo") MemberVo memberVo, Model model, HttpSession session,
			HttpServletRequest request) {
		int memberNumber = (int) session.getAttribute("memberNumber");
		System.out.println("????????????" + memberNumber);
		memberVo = memberService.selectUser(memberNumber);

		// input?????? ???????????? parameter??? ????????????
		String nickName = request.getParameter("nickName");
		String pet = request.getParameter("pet");

		memberVo.setNickName(nickName);
		memberVo.setPet(pet);
		memberVo.setMemberNumber(memberNumber);
		int update = memberService.updateUser(memberVo);
		// true = 1 , false = 0;
		if (update == 1) {
			System.out.println("????????????");
			System.out.println("????????????:" + memberVo.getNickName());
			System.out.println("?????????:" + memberVo.getPet());
			return "redirect:/memberpage/{memberNumber}";
		} else {
			System.out.println("????????????");
			System.out.println("????????????:" + memberVo.getNickName());
			System.out.println("?????????:" + memberVo.getPet());
			return "/member/updateMember/{memberNumber}";
		}
	}

	// ?????? ???????????? ?????? ????????? ??????
	@RequestMapping(value = "/memberdeletecheck", method = RequestMethod.GET)
	public String memberdeletecheck(Model model) {
		return "/member/MemberDeleteCheck";
	}

	// ?????? ??????
	@RequestMapping(value = "/memberdelete", method = {RequestMethod.GET, RequestMethod.POST})

	public String memberDelete(HttpSession session, HttpServletRequest request, Model model,RedirectAttributes rttr) throws Exception {
		int memberNumber = (int) session.getAttribute("memberNumber");
		String enterpassword = request.getParameter("enterpassword");
		String email = (String) session.getAttribute("email");
		String dbpassword = memberService.checkPwd(email);

		System.out.println("enterpassword:" + enterpassword);
		System.out.println("?????????:" + email);
		System.out.println("db????????????:" + dbpassword);

		if (dbpassword.equals(enterpassword)) {
			memberService.deleteUser(memberNumber);
			session.invalidate();
			return "redirect:/memberDeleteEnd";
		} else {
			rttr.addFlashAttribute("msg","??????????????? ???????????? ????????????.");
			return "redirect:/memberdeletecheck";
		}

	}
	
	//?????? ?????? ?????????
	@RequestMapping(value = "/memberDeleteEnd")
	public String memberDeleteEnd(Model model) {
		return "member/MemberDeleteEnd";
	}
	


	private String passwordcheck(String password, HttpSession session) {
		// TODO Auto-generated method stub
		return null;
	}

	// ???????????? ?????? ????????? ??????
	@RequestMapping(value = "/memberpage/updatePassword", method = RequestMethod.GET)
	public String passwordEdit(Model model) {

		return "member/Updatepwd";
	}

	// ?????? ???????????? ??????
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

	// ???????????? ??????
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
	//???????????? ??????????????? ??????
	@RequestMapping(value = "/FindPwd", method= RequestMethod.GET)
	public String FindPwd(@RequestParam Map<String, Object> paramMap, ModelMap model,HttpServletRequest request,String password, MemberVo memberVo){
		
		
		return "member/FindPwd";
		
	}
	//???????????? ?????? & ????????? ??????
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

			// messageHelper.setSubject(USERNAME+"??? ?????????????????????.");
			messageHelper.setSubject("?????????????????????????????????.");
			messageHelper.setText("??????????????? " + PASSWORD + " ?????????."
					+"????????? ??? ??????????????? ??? ??????????????????."+"???????????????.");
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
