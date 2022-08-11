package com.spring.javagreenS_pjh;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javagreenS_pjh.common.MsgProcess;
import com.spring.javagreenS_pjh.pagination.PageProcess;
import com.spring.javagreenS_pjh.pagination.PageVO;
import com.spring.javagreenS_pjh.service.BoardService;
import com.spring.javagreenS_pjh.service.LogService;
import com.spring.javagreenS_pjh.service.MemService;
import com.spring.javagreenS_pjh.service.ProductService;
import com.spring.javagreenS_pjh.vo.BoReVO;
import com.spring.javagreenS_pjh.vo.BoVO;
import com.spring.javagreenS_pjh.vo.LogVO;
import com.spring.javagreenS_pjh.vo.MsgVO;
import com.spring.javagreenS_pjh.vo.ProductVO;

@Controller
@RequestMapping(value = "/board")
public class BoardController {
	
	@Autowired
	BoardService boService;
	
	@Autowired
	MemService memService;
	
	@Autowired
	LogService logService;
	
	@Autowired
	ProductService prdService;
	
	@Autowired
	MsgProcess msg;
	
	@Autowired
	PageProcess pageProcess;
	
	@RequestMapping(value = "/content",method = RequestMethod.GET)
	public String contentGet(
			Model model,
			HttpSession session,
			@RequestParam("boIdx") int boIdx,
			@RequestParam("memIdx") int memIdx) throws Exception {
		
		String mid = session.getAttribute("sMid")==null ? "" : (String) session.getAttribute("sMid");
		int sIdx = session.getAttribute("sIdx")==null ? 0 : (int) session.getAttribute("sIdx");
		
		LogVO svo = memService.getUserInfo(mid);
		BoVO bvo = boService.getBoardContent(boIdx);
		if(bvo.getBo_val() == 99) {
			return "redirect:/msg/noBoard";
		}
		else if(bvo.getUserDel().equals("OK")){
			return "redirect:/msg/userDel";
		}
		BoVO mvo = boService.getBoardUserInfo(memIdx);
		ArrayList<BoVO> blvos = boService.getBoardLikeList(sIdx);
		String strtime = getTime(bvo.getBo_date());
		
		LogVO fvo = memService.getfollowUse(sIdx,memIdx);
		
		model.addAttribute("strtime",strtime);
		model.addAttribute("fvo",fvo);
		model.addAttribute("blvos",blvos);
		model.addAttribute("bvo",bvo);
		model.addAttribute("mvo",mvo);
		model.addAttribute("svo",svo);
		return "board/content";
	}
	
	@ResponseBody
	@RequestMapping(value = "/boardReplyInput",method = RequestMethod.POST)
	public void boardReplyInputPost(BoReVO vo,HttpSession session,String msg_url,int memIdx) {
		
		
		int idx = (int) session.getAttribute("sIdx");
		int res = 0;
		vo.setBoRe_memIdx(idx);
		boService.setReplyInput(vo);
		
		if(vo.getBoRe_boReIdx() == 0) {
			BoReVO rvo = boService.getReplyLastIndex(idx);
			res = rvo.getBoReIdx();
		}
		else {
			res = vo.getBoRe_boReIdx();
		}
		
		if(vo.getBoRe_forMemIdx() != 0) {
			LogVO svo =  logService.getUserInfo(idx);
			MsgVO mvo = new MsgVO();
			mvo.setMsg_memIdx(vo.getBoRe_forMemIdx());
			mvo.setMsg_url(msg_url);
			mvo.setMsg_flag("ReplyTag");
			mvo.setMsg_forMemIdx(idx);
			mvo.setMsg_forMemNick(svo.getNickName());
			msg.setMsgBox(mvo);
		}
		boService.setReplyReInput(res);
	}
	@ResponseBody
	@RequestMapping(value =  "/boardLikeUp",method = RequestMethod.POST)
	public void boardLikeUp(MsgVO mvo,BoVO vo,HttpSession session) {
		int sIdx = (int) session.getAttribute("sIdx");
		LogVO lvo =  logService.getUserInfo(sIdx);
		
		mvo.setMsg_flag("boardLike");
		mvo.setMsg_forMemIdx(sIdx);
		mvo.setMsg_forMemNick(lvo.getNickName());
		vo.setBl_memIdx(sIdx);

		
	  msg.setMsgBox(mvo);
	  boService.setBoardLikeUp(vo);
	  boService.setBoardLikeCntUp(vo.getBl_boardIdx());
	 
		
	}
	@ResponseBody
	@RequestMapping(value = "/boardLikeDown",method = RequestMethod.POST)
	public void boardLikeDown(@RequestParam("boIdx") int boIdx,HttpSession session) {
		int sIdx = (int) session.getAttribute("sIdx");
		boService.setBoardLikeDown(boIdx,sIdx);
		boService.setBoardLikeCntDown(boIdx);
	}
	
	@RequestMapping(value = "/userFeed",method = RequestMethod.GET)
	public String userFeedGet(Model model,
			@RequestParam(value = "memIdx") int memIdx,HttpSession session,
			@RequestParam(name = "pag",defaultValue = "1",required = false)int pag,
			@RequestParam(name = "pageSize",defaultValue = "8",required = false)int pageSize) {
		int sIdx = session.getAttribute("sIdx")==null ? 0 :(int) session.getAttribute("sIdx");
		
		BoVO vo = boService.getBoardUserInfo(memIdx);
		if(vo.getUserDel().equals("OK")){
			return "redirect:/msg/userDel";
		}
		PageVO pagevo = pageProcess.getUserContentTot(pag,pageSize,memIdx);
		ArrayList<BoVO> vos = boService.getUserContentList(pagevo.getStartIndexNo(),pagevo.getPageSize(),memIdx);
		
		ArrayList<BoVO> blvos = boService.getBoardLikeList(sIdx);
		int forcnt = boService.getforcnt(memIdx);
		int whocnt = boService.getwhocnt(memIdx);
		LogVO fvo = memService.getfollowUse(sIdx,memIdx);
		
		ArrayList<LogVO> fwvos = memService.getFollowerUserList(memIdx);
		ArrayList<LogVO> fgvos = memService.getFollowingUserList(memIdx);
		
		ArrayList<LogVO> sfwvos = memService.getSessionFollowList(sIdx);
		
		int totSize = vos.size();
		model.addAttribute("pagevo",pagevo);
		model.addAttribute("sfwvos",sfwvos);
		model.addAttribute("fgvos",fgvos);
		model.addAttribute("fwvos",fwvos);
		model.addAttribute("fvo",fvo);
		model.addAttribute("whocnt",whocnt);
		model.addAttribute("forcnt",forcnt);
		model.addAttribute("totSize",totSize);
		model.addAttribute("blvos",blvos);
		model.addAttribute("vo",vo);
		model.addAttribute("vos",vos);
		return "board/userFeed";
	}
	
	@RequestMapping(value = "/feedAll",method = RequestMethod.GET)
	public String feedAllGet(Model model,HttpSession session,
			@RequestParam(name = "pag",defaultValue = "1",required = false)int pag,
			@RequestParam(name = "pageSize",defaultValue = "16",required = false)int pageSize) {
		int sIdx = session.getAttribute("sIdx")==null ? 0 :(int) session.getAttribute("sIdx");
		PageVO pagevo = pageProcess.getFeedtot(pag,pageSize);
		ArrayList<BoVO> vos = pageProcess.getFeedAll(pagevo.getStartIndexNo(),pageSize);
		ArrayList<BoVO> blvos = boService.getBoardLikeList(sIdx);
		ArrayList<BoVO> tvos = boService.getTagList();
		
		
		int totSize = vos.size();
		model.addAttribute("tvos",tvos);
		model.addAttribute("blvos",blvos);
		model.addAttribute("pagevo",pagevo);
		model.addAttribute("totSize",totSize);
		model.addAttribute("vos",vos);
		return "board/feedAll";
	}
	@RequestMapping(value = "/feedPapular",method = RequestMethod.GET)
	public String feedPapularGet(Model model,HttpSession session,
			@RequestParam(name = "pag",defaultValue = "1",required = false)int pag,
			@RequestParam(name = "pageSize",defaultValue = "16",required = false)int pageSize) {
		
		int sIdx = session.getAttribute("sIdx")==null ? 0 :(int) session.getAttribute("sIdx");
		PageVO pagevo = pageProcess.getFeedtot(pag,pageSize);
		ArrayList<BoVO> vos = pageProcess.getfeedPapular(pagevo.getStartIndexNo(),pageSize);
		ArrayList<BoVO> blvos = boService.getBoardLikeList(sIdx);
		ArrayList<BoVO> tvos = boService.getTagList();
		
		
		
		int totSize = vos.size();
		model.addAttribute("tvos",tvos);
		model.addAttribute("blvos",blvos);
		model.addAttribute("pagevo",pagevo);
		model.addAttribute("totSize",totSize);
		model.addAttribute("vos",vos);
		return "board/feedPapular";
	}
	@ResponseBody
	@PostMapping("/tagSearch")
	public ArrayList<BoVO> tagSearch(@RequestParam("tags")String tags){
		ArrayList<BoVO> vos = boService.getTagSearch(tags);
		return vos;
	}
	
	@RequestMapping(value = "/feedTag",method = RequestMethod.GET)
	public String feedTagGet(Model model,HttpSession session,
			@RequestParam(name = "pag",defaultValue = "1",required = false)int pag,
			@RequestParam(name = "pageSize",defaultValue = "16",required = false)int pageSize,
			@RequestParam(name = "tags",defaultValue = "",required = false)String tags
			) {
		
		int sIdx = session.getAttribute("sIdx")==null ? 0 :(int) session.getAttribute("sIdx");
		PageVO pagevo = pageProcess.getFeedTagtot(pag,pageSize,tags);
		ArrayList<BoVO> vos = pageProcess.getFeedTagPapular(pagevo.getStartIndexNo(),pageSize,tags);
		ArrayList<BoVO> blvos = boService.getBoardLikeList(sIdx);
		ArrayList<BoVO> tvos = boService.getTagList();
		
		
		
		int totSize = vos.size();
		model.addAttribute("tvos",tvos);
		model.addAttribute("blvos",blvos);
		model.addAttribute("pagevo",pagevo);
		model.addAttribute("totSize",totSize);
		model.addAttribute("vos",vos);
		return "board/feedTag";
	}
	
	@RequestMapping(value = "/feedFollow",method = RequestMethod.GET)
	public String feedFollowGet(Model model,HttpSession session,
			@RequestParam(name = "pag",defaultValue = "1",required = false)int pag,
			@RequestParam(name = "pageSize",defaultValue = "16",required = false)int pageSize) {
		
		int sIdx = session.getAttribute("sIdx")==null ? 99 :(int) session.getAttribute("sIdx");
		
		PageVO pagevo = pageProcess.getFeedFollowtot(pag,pageSize,sIdx,"");
		
		ArrayList<BoVO> vos = pageProcess.getFeedFollow(pagevo.getStartIndexNo(),pageSize,sIdx,"");
		
		ArrayList<BoVO> blvos = boService.getBoardLikeList(sIdx);
		ArrayList<BoVO> tvos = boService.getTagList();
		
		
		
		int totSize = vos.size();
		model.addAttribute("tvos",tvos);
		model.addAttribute("blvos",blvos);
		model.addAttribute("pagevo",pagevo);
		model.addAttribute("totSize",totSize);
		model.addAttribute("vos",vos);
		return "board/feedFollow";
	}
	@RequestMapping(value = "/feedProduct",method = RequestMethod.GET)
	public String feedProductGet(Model model,HttpSession session,
			@RequestParam(name = "pag",defaultValue = "1",required = false)int pag,
			@RequestParam(name = "pageSize",defaultValue = "16",required = false)int pageSize,
			@RequestParam(name = "prdIdx",defaultValue = "0",required = false)int prdIdx) {
		int sIdx = session.getAttribute("sIdx")==null ? 0 :(int) session.getAttribute("sIdx");
		
		ProductVO pvo = prdService.GetProductInfo(prdIdx);
		PageVO pagevo = pageProcess.getPrdFeedtot(pag,pageSize,prdIdx);
		ArrayList<BoVO> vos = pageProcess.getFeedProduct(pagevo.getStartIndexNo(),pageSize,prdIdx);
		ArrayList<BoVO> blvos = boService.getBoardLikeList(sIdx);
		
		
		int totSize = vos.size();
		model.addAttribute("pvo",pvo);
		model.addAttribute("blvos",blvos);
		model.addAttribute("pagevo",pagevo);
		model.addAttribute("totSize",totSize);
		model.addAttribute("vos",vos);
		return "board/feedProduct";
	}
	@ResponseBody
	@PostMapping(value = "/getReplyList")
	public ArrayList<BoReVO> getReplyListPost(@RequestParam("boRe_boIdx") int boRe_boIdx) throws Exception{
		ArrayList<BoReVO> vos = boService.getReplyList(boRe_boIdx);
		for(int i = 0; i<vos.size(); i++) {
			vos.get(i).setStrBoRe_date(getTime(vos.get(i).getBoRe_date()));
		}
		return vos;
	}
	@ResponseBody
	@RequestMapping(value = "/getReplyUserInfor",produces = "application/text; charset=utf8", method = RequestMethod.POST)
	public String getReplyUserInfor(@RequestParam("memIdx") int memIdx) {
		BoVO vo = boService.getBoardUserInfo(memIdx);
		String nick = vo.getNickName();
		System.out.println(nick);
		return nick;
	}
	
	@ResponseBody
	@RequestMapping(value = "/userSearch",method = RequestMethod.POST)
	public ArrayList<LogVO> userSearchPost(@RequestParam("userSearch")String userSearch) {
		ArrayList<LogVO> vos = memService.userSearchNick(userSearch);
		return vos;
	}
	@ResponseBody
	@PostMapping("/boardDelete")
	public void boardDeletePost(@RequestParam("boIdx")int boIdx) {
		boService.setBoardDelete(boIdx);
	}
	@ResponseBody
	@PostMapping("/replyDelete")
	public void replyDeletePost(@RequestParam("boReIdx")int boReIdx) {
		boService.setReplyDelete(boReIdx);
	}
	@ResponseBody
	@PostMapping("/replyUpdate")
	public void replyUpdatePost(
			@RequestParam("boReIdx")int boReIdx,
			@RequestParam("coment")String coment) {
		boService.setReplyUpdate(boReIdx,coment);
	}
	@ResponseBody
	@RequestMapping(value = "/replyInfo", produces = "application/text; charset=UTF-8",method = RequestMethod.POST)
	public String replyInfoPost(@RequestParam("boReIdx")int boReIdx) {
		String text = boService.getReplyInfo(boReIdx);
		return text;
	}
	
	public String getTime(String day) throws Exception {
		String todayNow = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date(System.currentTimeMillis()));
		
    Date format1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(todayNow);
    Date format2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(day);
    
    long diffSec = (format1.getTime() - format2.getTime()) / 1000; //초 차이
    long diffMin = (format1.getTime() - format2.getTime()) / 60000; //분 차이
    long diffHor = (format1.getTime() - format2.getTime()) / 3600000; //시 차이
    long diffDays = diffSec / (24*60*60); //일자수 차이
    
    String strTime = "";
    if(diffDays > 0) {
    	strTime = diffDays+"일 전";
    }
    else if(diffHor > 0) {
    	strTime = diffHor+"시간 전";
    }
    else if(diffMin > 0) {
    	strTime = diffMin+"분 전";
    }
    else {
    	strTime = "방금전";
    }
		return strTime;
	}
	@ResponseBody
	@PostMapping("/declaration")
	public void declaration(BoVO vo,HttpSession session) {
		int sIdx = (int) session.getAttribute("sIdx");
		vo.setD_memIdx(sIdx);
		boService.setDeclaration(vo);
	}
}
