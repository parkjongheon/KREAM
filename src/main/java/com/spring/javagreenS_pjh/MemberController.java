package com.spring.javagreenS_pjh;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;

import com.mysql.cj.x.protobuf.MysqlxDatatypes.Array;
import com.spring.javagreenS_pjh.common.MsgProcess;
import com.spring.javagreenS_pjh.pagination.PageProcess;
import com.spring.javagreenS_pjh.pagination.PageVO;
import com.spring.javagreenS_pjh.service.BoardService;
import com.spring.javagreenS_pjh.service.MemService;
import com.spring.javagreenS_pjh.vo.BoVO;
import com.spring.javagreenS_pjh.vo.LogVO;
import com.spring.javagreenS_pjh.vo.MsgVO;
import com.spring.javagreenS_pjh.vo.OrderVO;
import com.spring.javagreenS_pjh.vo.ProductVO;
import com.spring.javagreenS_pjh.vo.ReturnVO;

@Controller
@RequestMapping("/mem")
public class MemberController {
	
	@Autowired
	MemService memService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	PageProcess pageProcess;
	
	@Autowired
	MsgProcess msgProcess;
	
	@Autowired
	BoardService boServcie;
	
	@RequestMapping(value = "/myPage",method = RequestMethod.GET)
	public String myPageGet(HttpSession session,Model model) {
		String mid = (String) session.getAttribute("sMid");
		int sIdx = (int) session.getAttribute("sIdx");
		LogVO vo = memService.getUserInfo(mid);
		int ordercnt = memService.getOrderCnt(sIdx);
		int dlvcnt = memService.getDlvcnt(sIdx);
		int confirmcnt = memService.getConfirmcnt(sIdx);
		int returncnt = memService.getReturnCnt(sIdx);
		
		
		int returnAllcnt = memService.returnAllcnt(sIdx);
		int returncnt1 = memService.returncnt1(sIdx);
		int returncnt2 = memService.returncnt2(sIdx);
		int returnClearcnt = memService.returnClearcnt(sIdx);
		
		model.addAttribute("returnAllcnt",returnAllcnt);
		model.addAttribute("returncnt1",returncnt1);
		model.addAttribute("returncnt2",returncnt2);
		model.addAttribute("returnClearcnt",returnClearcnt);
		
		model.addAttribute("ordercnt",ordercnt);
		model.addAttribute("confirmcnt",confirmcnt);
		model.addAttribute("dlvcnt",dlvcnt);
		model.addAttribute("returncnt",returncnt);
		model.addAttribute("vo",vo);
		
		return "member/myPage";
	}
	@RequestMapping(value = "/myPage/profile",method = RequestMethod.GET)
	public String myPageProfileGet(HttpSession session,Model model) {
		String mid = (String) session.getAttribute("sMid");
		LogVO vo = memService.getUserInfo(mid);
		
		model.addAttribute("vo",vo);
		return "member/myProfile";
	}

	
	@ResponseBody
	@RequestMapping(value = "/emailChange",method = RequestMethod.POST)
	public String emailChangePost(String email,HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		memService.setEmailChange(email,mid);
		return "1";
	}
	
	@ResponseBody
	@RequestMapping(value = "/pwdCheck",method = RequestMethod.POST)
	public String pwdCheckPost(String pwd,HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		
		LogVO vo = memService.getUserInfo(mid);
		if(vo != null && passwordEncoder.matches(pwd, vo.getPwd())) {
			return "1";			
		}
		else {			
			return "0";			
		}
	}
	@ResponseBody
	@RequestMapping(value = "/pwdChange",method = RequestMethod.POST)
	public String pwdChangePost(String pwd,HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		pwd = passwordEncoder.encode(pwd);
		memService.setpwdChange(pwd,mid);
		session.invalidate();
		return "1";
	}
	
	@ResponseBody
	@RequestMapping(value = "/nameChange",method = RequestMethod.POST)
	public String nameChangePost(String name,HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		memService.setNameChange(name,mid);
		return "1";
	}
	
	@ResponseBody
	@RequestMapping(value = "/nickNameChange",method = RequestMethod.POST)
	public String nickNameChangePost(String nickName,HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		memService.setNickNameChange(nickName,mid);
		return "1";
	}
	@ResponseBody
	@RequestMapping(value = "/telChange",method = RequestMethod.POST)
	public String telChangePost(String tel,HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		memService.setTelChange(tel,mid);
		return "1";
	}
	@ResponseBody
	@RequestMapping(value = "/nickNameCheck",method = RequestMethod.POST)
	public String nickNameCheckPost(String nickName) {
		LogVO vo = memService.getNickNameCheck(nickName);
		if(vo != null) {
			return "0";			
		}
		else {
			return "1";
		}
	}
	@ResponseBody
	@RequestMapping(value = "/imgProfile",method = RequestMethod.POST)
	public String imgProfileChangePost(
			MultipartHttpServletRequest imgProfile,
			HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		LogVO vo = memService.getUserInfo(mid);
		if(!vo.getPhoto().equals("noimage.png")) {
			memService.setProfileDelete(vo);
		}
		memService.setProfileImg(imgProfile,mid);
		
		
		return "1";
	}
	@ResponseBody
	@RequestMapping(value = "/imgProfileDelete",method = RequestMethod.POST)
	public String imgProfileDeletePost(HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		LogVO vo = memService.getUserInfo(mid);
		if(!vo.getPhoto().equals("noimage.png")) {
			memService.setProfileDelete(vo);
		}
		return "";
	}
	
	@RequestMapping(value = "/myOrderList",method = RequestMethod.GET)
	public String myOrderListGet(HttpSession session,Model model,
			@RequestParam(name = "pag",defaultValue = "1",required = false)int pag,
			@RequestParam(name = "pageSize",defaultValue = "10",required = false)int pageSize,
			@RequestParam(name = "sort",defaultValue = "desc",required = false) String sort,
			@RequestParam(name = "date",defaultValue = "",required = false)String date,		
			@RequestParam(name = "orderDate",defaultValue = "1" ,required = false)int orderDate,
			@RequestParam(name = "search",defaultValue = "",required = false)String search,
			@RequestParam(name = "btdate",defaultValue = "",required = false)String btdate,			
			@RequestParam(name = "val",defaultValue = "99",required = false) int val		
			) throws Exception {
		Calendar calendar = Calendar.getInstance();
		calendar.set(Calendar.DAY_OF_MONTH, 1);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String startDate = sdf.format(calendar.getTime());
		model.addAttribute("startDate",startDate);
		int memIdx = (int) session.getAttribute("sIdx");
		ArrayList<ReturnVO> revos = memService.getMemReturn(memIdx);
		int ordercnt = memService.getOrderCnt(memIdx);
		int dlvcnt = memService.getDlvcnt(memIdx);
		int returncnt = memService.getReturnCnt(memIdx);
		int confirmcnt = memService.getConfirmcnt(memIdx);
		
		PageVO pagevo = pageProcess.getOrderPage(memIdx,pag,pageSize,sort,date,orderDate,btdate,search,val,"");
		ArrayList<OrderVO> vos = pageProcess.getMemOrderList(memIdx,pagevo.getStartIndexNo(),pagevo.getPageSize(),sort,date,orderDate,search,btdate,val);
		
		model.addAttribute("startDate",startDate);
		model.addAttribute("confirmcnt",confirmcnt);
		model.addAttribute("pagevo",pagevo);
		model.addAttribute("sort",sort);
		model.addAttribute("vos",vos);
		model.addAttribute("revos",revos);
		model.addAttribute("ordercnt",ordercnt);
		model.addAttribute("returncnt",returncnt);
		model.addAttribute("dlvcnt",dlvcnt);
		return "member/myOrderList";
	}
	@RequestMapping(value = "/myReturnList",method = RequestMethod.GET)
	public String myReturnListGet(HttpSession session,Model model,
			@RequestParam(name = "pag",defaultValue = "1",required = false)int pag,
			@RequestParam(name = "pageSize",defaultValue = "10",required = false)int pageSize,
			@RequestParam(name = "sort",defaultValue = "desc",required = false) String sort,
			@RequestParam(name = "date",defaultValue = "",required = false)String date,		
			@RequestParam(name = "orderDate",defaultValue = "1" ,required = false)int orderDate,
			@RequestParam(name = "search",defaultValue = "",required = false)String search,
			@RequestParam(name = "btdate",defaultValue = "",required = false)String btdate,			
			@RequestParam(name = "val",defaultValue = "99",required = false) int val		
			) throws Exception {
		
		Calendar calendar = Calendar.getInstance();
		calendar.set(Calendar.DAY_OF_MONTH, 1);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String startDate = sdf.format(calendar.getTime());
		model.addAttribute("startDate",startDate);
		int memIdx = (int) session.getAttribute("sIdx");
//		ArrayList<ReturnVO> revos = memService.getMemReturn(memIdx);
		
		PageVO pagevo = pageProcess.getReturnPage(memIdx,pag,pageSize,sort,date,orderDate,btdate,search,val,"");
		
		int returnAllcnt = memService.returnAllcnt(memIdx);
		int returncnt1 = memService.returncnt1(memIdx);
		int returncnt2 = memService.returncnt2(memIdx);
		int returnClearcnt = memService.returnClearcnt(memIdx);
		
		model.addAttribute("returnAllcnt",returnAllcnt);
		model.addAttribute("returncnt1",returncnt1);
		model.addAttribute("returncnt2",returncnt2);
		model.addAttribute("returnClearcnt",returnClearcnt);
		
		ArrayList<ReturnVO> revos = pageProcess.getMemReturnList(memIdx,pagevo.getStartIndexNo(),pagevo.getPageSize(),sort,date,orderDate,search,btdate,val);
		model.addAttribute("startDate",startDate);
		model.addAttribute("pagevo",pagevo);
		model.addAttribute("sort",sort);
		model.addAttribute("revos",revos);
//		model.addAttribute("revos",revos);

		return "member/myReturnList";
	}
	
	@RequestMapping(value = "/orderCancle",method = RequestMethod.POST)
	public String orderCancle(ReturnVO vo,HttpSession session) {
		int memIdx = (int) session.getAttribute("sIdx");
		vo.setMem_Idx(memIdx);
		vo.setReturn_indexcnt(vo.getOrder_prdIdx().length);
		memService.setReturn(vo);
		int resub_reIdx = memService.getReturnIdx(memIdx);
		for(int i = 0; i<vo.getOrder_prdCount().length; i++) {
			int prdIdx = Integer.parseInt(vo.getOrder_prdIdx()[i]);
			int subIdx = Integer.parseInt(vo.getOrder_subIdx()[i]);
			String prdOption = vo.getOrder_prdOption()[i];
			int prdCount = Integer.parseInt(vo.getOrder_prdCount()[i]);
			int prdPrice = Integer.parseInt(vo.getOrder_prdPrice()[i]);
			double delPoint = (prdPrice * prdCount) * 0.01;
			
			memService.setReturnSub(resub_reIdx,subIdx,prdIdx,prdOption,prdPrice,prdCount,(int)delPoint);
		}
		return "redirect:/msg/orderReturnOk";
	}
	// 구매확정
	@RequestMapping(value = "/orderConfirm",method = RequestMethod.POST)
	public String orderConfirm(int[] subIdx) {
		for(int i = 0; i<subIdx.length; i++) {
			memService.setOrderConfirm(subIdx[i]);
			OrderVO vo = memService.getorderSubInfo(subIdx[i]);
			memService.setMemPoint(vo.getOrder_memIdx(),vo.getOrder_prdPoint());
		}
		return "redirect:/msg/orderConfirmOk";
	}
	
	@RequestMapping(value = "/myFeedInput",method = RequestMethod.GET)
	public String myFeedInputGet(HttpSession session,Model model) {
		String mid = (String) session.getAttribute("sMid");
		LogVO vo = memService.getUserInfo(mid);
		
		model.addAttribute("vo",vo);
		return "member/myFeedInput";
	}
	@RequestMapping(value = "/myFeedUpdate",method = RequestMethod.GET)
	public String myFeedUpdateGet(HttpSession session,Model model,
			@RequestParam(name = "boIdx",defaultValue = "0",required = false)int boIdx) {
		String mid = (String) session.getAttribute("sMid");
		LogVO vo = memService.getUserInfo(mid);
		BoVO bvo = boServcie.getBoardContent(boIdx);
		String cnts[] = bvo.getBo_fName().split("/");
		String tags[] = bvo.getBo_tag().split("#");
		int cnt = cnts.length -1;
		int tagCnt = tags.length;
		
		model.addAttribute("tagCnt",tagCnt);
		model.addAttribute("cnt",cnt);
		model.addAttribute("vo",vo);
		model.addAttribute("bvo",bvo);
		return "member/myFeedUpdate";
	}
	
	@PostMapping(value = "/myFeedInput")
	public String myFeedInputPost(MultipartHttpServletRequest file ,HttpSession session,BoVO vo)throws IOException {
		int memIdx = (int) session.getAttribute("sIdx");
		vo.setBo_memIdx(memIdx);
		memService.setMyFeedInput(file,vo);
		String tags[] = vo.getBo_tag().split("#");
		for(int i=0; i<tags.length-1; i++) {
			BoVO tagvo = memService.getTag(tags[i]);
			if(tagvo == null) {
				memService.setTag(tags[i]);
			}
			else if(!tags[i].equals("")) {
				memService.setTagCnt(tags[i]);				
			}
		}
		
		return "redirect:/msg/myFeedInputOk";
	}
	
	@PostMapping(value = "/myFeedUpdate")
	public String myFeedUpdatePost(MultipartHttpServletRequest file,BoVO vo,
			@RequestParam(value = "hImage") String[] hImage)throws IOException {
		BoVO orivo = boServcie.getBoardContent(vo.getBoIdx());
		
		memService.setMyFeedUpdate(file,vo,orivo,hImage);
		
		String tags[] = vo.getBo_tag().split("#");
		for(int i=0; i<tags.length-1; i++) {
			BoVO tagvo = memService.getTag(tags[i]);
			if(tagvo == null) {
				memService.setTag(tags[i]);
			}
			else if(!tags[i].equals("")) {
				memService.setTagCnt(tags[i]);				
			}
		}
		
		return "redirect:/msg/myFeedUpdateOk";
	}
	
	@ResponseBody
	@RequestMapping(value = "/searchProduct",method = RequestMethod.POST)
	public ArrayList<ProductVO> searchProduct(
			@RequestParam(name = "key",defaultValue = "",required = false) String key){
		ArrayList<ProductVO> vos = memService.getSearchProduct(key);
		return vos;
	}
	@ResponseBody
	@RequestMapping(value = "/chooseItem",method = RequestMethod.POST)
	public ProductVO chooseItem(
			@RequestParam(name = "prdIdx",defaultValue = "0",required = false) int prdIdx){
		ProductVO vo = memService.chooseItem(prdIdx);
		return vo;
	}
	@ResponseBody
	@PostMapping("/setfollow")
	public void setfollow(HttpSession session,@RequestParam("for_Idx") int for_Idx) {
		int who_Idx = (int) session.getAttribute("sIdx");
		String nick = (String) session.getAttribute("sNickName");
		memService.setfollow(who_Idx,for_Idx);
		MsgVO vo = new MsgVO();
		vo.setMsg_memIdx(for_Idx);
		vo.setMsg_forMemIdx(who_Idx);
		vo.setMsg_forMemNick(nick);
		vo.setMsg_url("/board/userFeed?memIdx="+who_Idx);
		vo.setMsg_flag("follow");
		msgProcess.setMsgBox(vo);
	}
	@ResponseBody
	@PostMapping("/setUnfollow")
	public void setUnfollow(HttpSession session,@RequestParam("for_Idx") int for_Idx) {
		int who_Idx = (int) session.getAttribute("sIdx");
		memService.setUnfollow(who_Idx,for_Idx);
	}
	
	@RequestMapping(value = "/myWishList",method = RequestMethod.GET)
	public String myWishListGet(HttpSession session,Model model,
			@RequestParam(name = "pag",defaultValue = "1",required = false)int pag,
			@RequestParam(name = "pageSize",defaultValue = "6",required = false)int pageSize
			) {
		int sIdx = session.getAttribute("sIdx")==null ? 0 : (int) session.getAttribute("sIdx");
		PageVO pagevo = pageProcess.getWishPage(sIdx,pag,pageSize);
		ArrayList<ProductVO> vos = pageProcess.getWishList(pagevo.getStartIndexNo(),pagevo.getPageSize(),sIdx);
		
		model.addAttribute("pagevo",pagevo);
		model.addAttribute("vos",vos);
		
		return "member/myWishList";
	}
	
	@RequestMapping(value = "/myAddressList",method = RequestMethod.GET)
	public String myAddressListGet(HttpSession session,Model model) {
		int sIdx = session.getAttribute("sIdx")==null ? 0 : (int) session.getAttribute("sIdx");
		LogVO vo = memService.getUserInfor(sIdx);
		ArrayList<LogVO> adrvos = memService.getUserAddressList(sIdx);
		
		model.addAttribute("vo",vo);
		model.addAttribute("adrvos",adrvos);
		return "member/myAddressList";
	}
	@ResponseBody
	@PostMapping("/addressInput")
	public void addressInputPost(LogVO vo,HttpSession session) {
		int sIdx = session.getAttribute("sIdx")==null ? 0 : (int) session.getAttribute("sIdx");
		vo.setAdr_memIdx(sIdx);
		memService.setAddressInput(vo);
	}
	@ResponseBody
	@PostMapping("/getUserAddress")
	public LogVO getUserAddress(
			@RequestParam(value = "flag")String flag,
			@RequestParam(value = "idx") int idx) {
		
		LogVO vo = new LogVO();
		if(flag.equals("main")) {
			vo = memService.getUserInfor(idx);
		}
		else {
			vo = memService.getUserAddress(idx);			
		}
		
		return vo;
	}
	@ResponseBody
	@PostMapping("/addressUpdate")
	public void getUserAddress(LogVO vo,
			@RequestParam(value = "flag")String flag,
			@RequestParam(value = "idx") int idx) {
		
		if(flag.equals("main")) {
			memService.getUserInfoAdrUpdate(idx,vo);
		}
		else {
			memService.getUserAddressUpdate(idx,vo);			
		}
		
	}
	@ResponseBody
	@PostMapping("/addressChange")
	public void getUserAddress(@RequestParam(value = "adr_Idx")int adr_Idx,HttpSession session) {
		int sIdx = (int) session.getAttribute("sIdx");
		
		LogVO orivo = memService.getUserInfor(sIdx);
		LogVO chvo = memService.getUserAddress(adr_Idx);
		
		memService.userAddressChange(chvo,sIdx);
		memService.userAddressboxChange(orivo,adr_Idx);
	}
	@ResponseBody
	@PostMapping("/addressDelete")
	public void addressDelete(@RequestParam(value = "adr_Idx")int adr_Idx) {
		memService.addressDelete(adr_Idx);
	}
	
	@ResponseBody
	@PostMapping("/setUserContent")
	public void setUserContent(
			@RequestParam(value = "content")String content,HttpSession session) {
		int sIdx = (int) session.getAttribute("sIdx");
		memService.setUserContent(sIdx,content);
	}
	
	@GetMapping("/userDel")
	public String userDel() {
		return "member/userDel";
	}
	@GetMapping("/userDelOk")
	public String userDelOk(HttpSession session) {
		int sIdx = (int) session.getAttribute("sIdx");
		memService.setUserDelOk(sIdx);
		session.invalidate();
		return "redirect:/msg/userDelOk";
	}
	
	@ResponseBody
	@PostMapping("/getAdrInfo")
	public ArrayList<LogVO> getAdrInfo(HttpSession session){
		int sIdx = (int) session.getAttribute("sIdx");
		ArrayList<LogVO> vos = memService.getUserAddressList(sIdx);
		return vos;
	}
	@ResponseBody
	@PostMapping("/getAdrCheck")
	public LogVO getAdrCheck(
			@RequestParam("flag")String flag,
			@RequestParam("idx")int idx){
		LogVO vo = new LogVO();
		if(flag.equals("main")) {
			vo = memService.getUserInfor(idx);
		}
		else {
			vo = memService.getUserAddress(idx);						
		}
		return vo;
	}
	
	@RequestMapping(value = "/myDeclaration",method = RequestMethod.GET)
	public String myDeclarationGet(HttpSession session,Model model,
			@RequestParam(name = "pag",defaultValue = "1",required = false)int pag,
			@RequestParam(name = "pageSize",defaultValue = "10",required = false)int pageSize
			) {
		int sIdx = (int) session.getAttribute("sIdx");
		PageVO pagevo = pageProcess.getMyDeclarationTot(sIdx,pag,pageSize);
		ArrayList<BoVO> vos = pageProcess.getMyDeclarationList(pagevo.getStartIndexNo(),pagevo.getPageSize(), sIdx);
		
		model.addAttribute("vos",vos);
		model.addAttribute("pagevo",pagevo);
		return "member/myDeclaration";
	}
	@RequestMapping(value = "/myHistory",method = RequestMethod.GET)
	public String myHistoryGet(HttpSession session,Model model,
			@RequestParam(name = "pag",defaultValue = "1",required = false)int pag,
			@RequestParam(name = "pageSize",defaultValue = "10",required = false)int pageSize
			) {
		int sIdx = (int) session.getAttribute("sIdx");
		PageVO pagevo = pageProcess.getMyHistoryTot(sIdx,pag,pageSize);
		ArrayList<MsgVO> vos = pageProcess.getMyHistoryList(pagevo.getStartIndexNo(),pagevo.getPageSize(), sIdx);
		
		model.addAttribute("vos",vos);
		model.addAttribute("pagevo",pagevo);
		
		return "member/myHistory";
	}
}
