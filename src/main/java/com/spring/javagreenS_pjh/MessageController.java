package com.spring.javagreenS_pjh;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MessageController {
	
	
	
	@RequestMapping(value = "/msg/{msgFlag}", method = RequestMethod.GET)
	public String msgGet(@PathVariable String msgFlag,Model model,
			@RequestParam(value="name" , defaultValue = "" ,required = false) String name,
			@RequestParam(value="mid" , defaultValue = "" ,required = false) String mid,
			@RequestParam(value="idx" , defaultValue = "0" ,required = false) int idx,
			HttpSession session
			) {
		
		
		if(msgFlag.equals("joinOk")) {
			model.addAttribute("msg","회원가입이 완료되었습니다.");
			model.addAttribute("url","log/login");
			model.addAttribute("flag","success");
		}
		else if(msgFlag.equals("joinNo")) {
			model.addAttribute("msg","회원가입이 실패했습니다. 관리자 요망");
			model.addAttribute("url","log/login");
			model.addAttribute("flag","error");
		}
		else if(msgFlag.equals("pwdChangeOk")) {
			model.addAttribute("msg", "비밀번호가 변경되어 로그아웃합니다");
			model.addAttribute("url","log/login");
			model.addAttribute("flag","success");
		}
		else if(msgFlag.equals("getOut")) {
			model.addAttribute("msg", "로그인후 이용해주세요");
			model.addAttribute("url","log/login");
			model.addAttribute("flag","warning");
		}
		else if(msgFlag.equals("adgetOut")) {
			model.addAttribute("msg", "관리자 외 접근제한");
			model.addAttribute("url","log/login");
			model.addAttribute("flag","error");
		}
		else if(msgFlag.equals("orderReturnOk")) {
			model.addAttribute("msg", "상품 취소 신청이 정상 처리되었습니다.");
			model.addAttribute("url","mem/myOrderList");
			model.addAttribute("flag","success");
		}
		else if(msgFlag.equals("noBoard")) {
			model.addAttribute("msg", "삭제된 게시물 입니다.");
			model.addAttribute("url","board/feedAll?pag=1&pageSize=16");
			model.addAttribute("flag","error");
		}
		else if(msgFlag.equals("myFeedUpdateOk")) {
			int sIdx = (int) session.getAttribute("sIdx");
			model.addAttribute("msg", "게시물이 수정되었습니다");
			model.addAttribute("url","board/userFeed?memIdx="+sIdx);
			model.addAttribute("flag","success");
		}
		else if(msgFlag.equals("myFeedInputOk")) {
			int sIdx = (int) session.getAttribute("sIdx");
			model.addAttribute("msg", "게시물이 등록되었습니다.");
			model.addAttribute("url","board/userFeed?memIdx="+sIdx);
			model.addAttribute("flag","success");
		}
		else if(msgFlag.equals("boardDelete")) {
			int sIdx = (int) session.getAttribute("sIdx");
			model.addAttribute("msg", "게시물이 삭제되었습니다.");
			model.addAttribute("url","board/userFeed?memIdx="+sIdx);
			model.addAttribute("flag","success");
		}
		else if(msgFlag.equals("userDel")) {
			model.addAttribute("msg", "탈퇴한 회원입니다.");
			model.addAttribute("url","board/feedAll?pag=1&pageSize=16");
			model.addAttribute("flag","error");
		}
		else if(msgFlag.equals("userDelOk")) {
			model.addAttribute("msg", "탈퇴처리 되었습니다 로그아웃합니다");
			model.addAttribute("url","/");
			model.addAttribute("flag","success");
		}
		else if(msgFlag.equals("orderConfirmOk")) {
			model.addAttribute("msg", "구매확정이 완료되었습니다.");
			model.addAttribute("url","mem/myOrderList");
			model.addAttribute("flag","success");
		}
		

		return "message/message";
	}
}
