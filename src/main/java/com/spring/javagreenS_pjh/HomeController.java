package com.spring.javagreenS_pjh;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javagreenS_pjh.common.Common;
import com.spring.javagreenS_pjh.common.MsgProcess;
import com.spring.javagreenS_pjh.service.BoardService;
import com.spring.javagreenS_pjh.service.LogService;
import com.spring.javagreenS_pjh.service.MemService;
import com.spring.javagreenS_pjh.service.ProductService;
import com.spring.javagreenS_pjh.vo.BoVO;
import com.spring.javagreenS_pjh.vo.MsgVO;
import com.spring.javagreenS_pjh.vo.ProductVO;


@Controller
public class HomeController {
	
	@Autowired
	Common com;
	
	@Autowired
	LogService logService;
	
	@Autowired
	MsgProcess msgProcess;
	
	@Autowired
	ProductService prdService;
	
	@Autowired
	BoardService boService;
	
	@Autowired
	MemService memService;
	
	@ResponseBody
	@RequestMapping(value = "/msg/getUserMsgList", method = RequestMethod.POST)
	public ArrayList<MsgVO> getUserMsgList(HttpSession session) {
		int idx = (int) session.getAttribute("sIdx");
		ArrayList<MsgVO> vos = msgProcess.getUserMsgList(idx);
		return vos;
	}
	@ResponseBody
	@RequestMapping(value = "/msg/msgRead", method = RequestMethod.POST)
	public void setMsgRead(@RequestParam("msgIdx") int msgIdx) {
		msgProcess.setMsgRead(msgIdx);
	}
	
	@ResponseBody
	@RequestMapping(value = "/msg/msgGoUrl", method = RequestMethod.POST)
	public String getMsgGoUrl(@RequestParam("msgIdx") int msgIdx) {
		msgProcess.setMsgRead(msgIdx);
		String url = msgProcess.getMsgGoUrl(msgIdx);
		return url;
	}
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
		ArrayList<ProductVO> vos = prdService.getBestProductList();
		ArrayList<ProductVO> nvos = prdService.getNewProductList();
		ArrayList<BoVO> bvos = boService.getBestFeed();
		ArrayList<BoVO> tvos = boService.getTagList();
		
		model.addAttribute("bvos",bvos);
		model.addAttribute("tvos",tvos);
		model.addAttribute("nvos",nvos);
		model.addAttribute("vos",vos);
		return "home";
	}
	@ResponseBody
	@RequestMapping(value = "/msgBoxCnt",method = RequestMethod.POST)
	public int msgBoxCnt(HttpSession session) {
		int sIdx = session.getAttribute("sIdx") == null ? 0 : (int) session.getAttribute("sIdx");
		int cnt = logService.getMsgCnt(sIdx);
		return cnt;
	}
	
	@ResponseBody
	@PostMapping(value = "/msgDelete")
	public void msgDelete(@RequestParam("msgIdx")int msgIdx) {
		memService.setMsgDelete(msgIdx);
	}
	
	@ResponseBody
	@RequestMapping("/imageUpload")
	public void imageUploadGet(HttpServletRequest request,HttpServletResponse response,
			MultipartFile upload) throws Exception {
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String originalFilename = upload.getOriginalFilename();
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		originalFilename = sdf.format(date)+"_"+originalFilename;
		
		byte[] bytes = upload.getBytes();
		
		
		com.setFolder();
		
		// 서버 파일시스템에 실제로 파일을 저장시킨다.
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/admin/temp/");
		OutputStream outStr = new FileOutputStream(new File(uploadPath+originalFilename));
		outStr.write(bytes);
		
		// 서버 파일시스템 에저장된 파일을 한번에 보여주기위한 작업.
		PrintWriter out = response.getWriter();
		String fileUrl = request.getContextPath() +"/admin/temp/" + originalFilename;
		// "atom" : 12.jpg,"변수":값
		out.println("{\"originalFilename\":\""+originalFilename+"\",\"uploaded\":1,\"url\":\""+fileUrl+"\"}");
		out.flush();
		outStr.close();
	}
	
}
