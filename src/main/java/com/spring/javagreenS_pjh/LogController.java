package com.spring.javagreenS_pjh;

import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.javagreenS_pjh.service.LogService;
import com.spring.javagreenS_pjh.vo.LogVO;


@Controller
@RequestMapping("/log")
public class LogController {
	
	@Autowired
	JavaMailSender mailSender;
	
	@Autowired
	LogService logService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	
	@RequestMapping(value = "/login",method = RequestMethod.GET)
	public String loginGet(HttpServletRequest request,Model model) {
		Cookie[] cookies = request.getCookies();
		String mid = "";
		for(int i =0; i<cookies.length; i++){
			if(cookies[i].getName().equals("cMid")) {
				mid = cookies[i].getValue();
				request.setAttribute("mid", mid);
				break;
			}
		}
//		String url = request.getParameter("url") == null ? "" : request.getParameter("url");
//		String tag = request.getParameter("tag") == null ? "" : request.getParameter("tag");
		return "log/login";
	}
	@RequestMapping(value = "/login",method = RequestMethod.POST)
	public String loginPost(LogVO vo,@RequestParam(name="idSave",defaultValue = "off",required = false) String idSave,HttpServletResponse response,HttpServletRequest request,
			HttpSession session,Model model, @RequestParam(name="url",defaultValue = "",required = false)String url,
			@RequestParam(name = "tag",defaultValue = "",required = false)String tag,
			RedirectAttributes re) {
		LogVO memvo = logService.getIdInfor(vo.getMid());
		logService.setLastDay(vo.getMid());
		String strGrade = "";
		if(memvo.getGrade() == 0) strGrade = "관리자";
		else if(memvo.getGrade() == 1) strGrade = "운영자";
		else if(memvo.getGrade() == 2) strGrade = "우수회원";
		else if(memvo.getGrade() == 3) strGrade = "정회원";
		else if(memvo.getGrade() == 4) strGrade = "일반회원";
		
		if(idSave.equals("on")) {
			Cookie cookie = new Cookie("cMid", memvo.getMid());
			cookie.setMaxAge(60*60*24*7); // 쿠키 만료시간
			response.addCookie(cookie);
		}
		else {
			Cookie[] cookies = request.getCookies();
			for(int i =0; i<cookies.length; i++){
				if(cookies[i].getName().equals("cMid")) {
					cookies[i].setMaxAge(0);
					break;
				}
			}
		}
		session.setAttribute("sIdx", memvo.getIdx());
		session.setAttribute("sMid", memvo.getMid());
		session.setAttribute("sNickName", memvo.getNickName());
		session.setAttribute("sGrade", memvo.getGrade());
		session.setAttribute("sStrGrade", strGrade);
		
		if(url.equals("product")) {
			re.addAttribute("prdIdx",tag);
			return "redirect:/product/productInfo";						
		}
		else if(url.equals("productMain")){
			re.addAttribute("pag",1);
			re.addAttribute("pageSize",16);
			re.addAttribute("sort", "desc");
			return "redirect:/product/productMain";	
		}
		else {
			return "redirect:/";			
		}
		
	}
	@ResponseBody
	@RequestMapping(value = "/loginCheck",method = RequestMethod.POST)
	public String loginCheckPost(String mid,String pwd) {
		LogVO vo = logService.getIdInfor(mid);
		if(vo != null && passwordEncoder.matches(pwd, vo.getPwd()) && vo.getUserDel().equals("NO")) {
			return "1";			
		}
		else {			
			return "0";			
		}
	}
	@RequestMapping(value = "/logout",method = RequestMethod.GET)
	public String logoutGet(HttpSession session, Model model) {
		String mid = (String) session.getAttribute("sMid");
		model.addAttribute("mid",mid);
		session.invalidate();
		return "redirect:/";
	}
	
	@RequestMapping(value = "/join",method = RequestMethod.GET)
	public String joinGet() {
		return "log/join";
	}
	@RequestMapping(value = "/join",method = RequestMethod.POST)
	public String joinPost(LogVO vo) {
		vo.setPwd(passwordEncoder.encode(vo.getPwd()));
		vo.setContent("자기소개가 없습니다");
		
		
		
		int res = logService.setMemInput(vo);
		if(res == 1) {
			return "redirect:/msg/joinOk";			
		}
		else {
			return "redirect:/msg/joinNo";			
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "/codeCheck",method = RequestMethod.POST)
	public String[] codeCheckPost(String toMail) {
		LogVO vo = logService.getEmail(toMail);
		String[] result = new String[2];
		if(vo != null) {
			result[0] = "3";
			result[1] = vo.getMid();
			return result;
		}
		else {
			String title = "인증코드발급";
			UUID uid = UUID.randomUUID();
			String code = uid.toString().substring(0,6);
			String res = mailSend(toMail,code,title);
			
			result[0] = "1";
			result[1] = code;
			return result;
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "/idCheck",method = RequestMethod.POST)
	public String idCheckPost(String mid) {
		LogVO vo = logService.getIdInfor(mid);
		if(vo == null) {
			return "1";			
		}
		else {
			return "0";
		}
	}
	@RequestMapping(value = "/idSearch", method = RequestMethod.GET)
	public String idSearchGet() {
		return "log/idSearch";
	}
	@ResponseBody
	@RequestMapping(value = "/emailCheck", method = RequestMethod.POST)
	public String emailCheckPost(String email) {
		LogVO vo = logService.getEmail(email);
		if(vo == null) {
			return "1";
		}
		else {
			return vo.getMid();			
		}
	}
	@RequestMapping(value = "/pwdSearch", method = RequestMethod.GET)
	public String pwdSearchGet() {
		return "log/pwdSearch";
	}
	@ResponseBody
	@RequestMapping(value = "/pwdCheck", method = RequestMethod.POST)
	public String pwdSearchPost(String mid, String email) {
		LogVO vo = logService.getMidEmail(mid,email);
		if(vo != null) {
			String title = "임시비밀번호 발급";
			UUID uid = UUID.randomUUID();
			String code = uid.toString().substring(0,8);
			
			mailSend(email,code,title);
			
			code = passwordEncoder.encode(code);
			
			logService.setUserPwd(code,mid);
			return email;
		}
		return "1";
	}
	
	@RequestMapping(value = "/test",method = RequestMethod.GET)
	public String test(Model model) {
		String pwd = passwordEncoder.encode("1234");
		model.addAttribute("pwd",pwd);
		return "admin/test";
	}
	
	//인증코드 메일
	public String mailSend(String toMail,String code, String title) {
		try {
			
			String content = code;
			
			// 메세지를 변환시켜서 보관함에 저장하여 준비한다.
			MimeMessage message =  mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true , "UTF-8");
			
			// 메일보관함에 회원이 보내오는 베세지를 모두저장시켜둥다
			messageHelper.setTo(toMail);
			
			messageHelper.setSubject(title);
			messageHelper.setText(content);
			
			//메세지 보관함의 내용을 편집해서 다시 보관함에 담아둔다.
			content = "<hr/>인증번호는 : <font color='red'><b>"+content+"</b></font>";
			
			content += "<br/><hr>페이지에서 인증코드를 입력해주세요<hr/><br/>";
			
			content += "<p><img src=\"cid:logo2.jpg\"></p><br/>";
			
			content += "<hr/>";
			
			FileSystemResource file = new FileSystemResource("C:\\JavaGreen\\LastProject\\works\\javagreenS_pjh\\src\\main\\webapp\\resources\\logo\\logo2.png");
			messageHelper.setText(content, true);
			messageHelper.addInline("logo2.jpg", file);
			
			//본문에 기재된 그림파일의 경로를 따로 표시시켜준다.
			mailSender.send(message);
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		
		
		return "1";
	}
}
