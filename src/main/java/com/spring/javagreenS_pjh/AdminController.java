package com.spring.javagreenS_pjh;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Iterator;
import java.util.List;

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
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.google.gson.Gson;
import com.spring.javagreenS_pjh.common.Common;
import com.spring.javagreenS_pjh.pagination.PageProcess;
import com.spring.javagreenS_pjh.pagination.PageVO;
import com.spring.javagreenS_pjh.service.AdService;
import com.spring.javagreenS_pjh.service.LogService;
import com.spring.javagreenS_pjh.vo.BoVO;
import com.spring.javagreenS_pjh.vo.ChartVO;
import com.spring.javagreenS_pjh.vo.LogVO;
import com.spring.javagreenS_pjh.vo.OrderVO;
import com.spring.javagreenS_pjh.vo.ProductVO;
import com.spring.javagreenS_pjh.vo.ReturnVO;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	AdService adService;
	
	@Autowired
	LogService logService;
	
	@Autowired
	PageProcess pageProcess;
	
	@Autowired
	Common com;
	
	@RequestMapping(value = "/adminMain",method = RequestMethod.GET)
	public String adminMainGet(HttpSession session,Model model) {
		String mid = (String) session.getAttribute("sMid");
		LogVO vo = logService.getIdInfor(mid);
		List<ChartVO> list = adService.getOrderChartTotal();
		List<ChartVO> pie = adService.getBrandTop();
		
		int adordercnt = adService.getOrderCnt();
		int adreturncnt = adService.getReturnCnt();
		model.addAttribute("adordercnt",adordercnt);
		model.addAttribute("adreturncnt",adreturncnt);
		model.addAttribute("list",list);
		model.addAttribute("pie",pie);
		
		model.addAttribute("vo",vo);
		return "admin/adminMain";
	}
	
	@RequestMapping(value = "/adMemberList",method = RequestMethod.GET)
	public String adMemberListGet(HttpSession session,Model model,
			@RequestParam(name = "sort",defaultValue = "desc",required = false) String sort,
			@RequestParam(name = "pag",defaultValue = "1",required = false)int pag,
			@RequestParam(name = "pageSize",defaultValue = "6",required = false)int pageSize
			) {
		
		String mid = (String) session.getAttribute("sMid");
		LogVO vo = logService.getIdInfor(mid);
		PageVO pagevo = pageProcess.getPage(pag, pageSize, "adMem", sort, "", "","",0,"");
		
		ArrayList<LogVO> vos = pageProcess.getMemberList(pagevo.getStartIndexNo(),pagevo.getPageSize(),sort);
		int adordercnt = adService.getOrderCnt();
		int adreturncnt = adService.getReturnCnt();
		model.addAttribute("adordercnt",adordercnt);
		model.addAttribute("adreturncnt",adreturncnt);
		
		model.addAttribute("pagevo",pagevo);
		model.addAttribute("sort",sort);
		model.addAttribute("vo",vo);
		model.addAttribute("vos",vos);
		return "admin/adMemberList";
	}
	
	@ResponseBody
	@RequestMapping(value = "/userInfor",method = RequestMethod.POST)
	public LogVO userInfor(String mid) {
		LogVO vo = logService.getIdInfor(mid);
		return vo;
	}
	
	@RequestMapping(value = "/adProductInput",method = RequestMethod.GET)
	public String adProductInput(HttpSession session,Model model) {
		String mid = (String) session.getAttribute("sMid");
		LogVO vo = logService.getIdInfor(mid);
		
		ArrayList<ProductVO> brvos = adService.getBrandList();
		ArrayList<ProductVO> ctvos = adService.getCategoryList();
		
		int adordercnt = adService.getOrderCnt();
		int adreturncnt = adService.getReturnCnt();
		model.addAttribute("adordercnt",adordercnt);
		model.addAttribute("adreturncnt",adreturncnt);
		
		model.addAttribute("vo",vo);
		model.addAttribute("brvos",brvos);
		model.addAttribute("ctvos",ctvos);
		
		return "admin/adProductInput";
	}
	
	@RequestMapping(value = "/adBrandCateUpdate",method = RequestMethod.GET)
	public String adBrandCateUpdate(HttpSession session,Model model) {
		String mid = (String) session.getAttribute("sMid");
		LogVO vo = logService.getIdInfor(mid);
		
		ArrayList<ProductVO> brvos = adService.getBrandList();
		ArrayList<ProductVO> ctvos = adService.getCategoryList();
		ArrayList<ProductVO> subvos = adService.getSubCategoryList();
		
		int adordercnt = adService.getOrderCnt();
		int adreturncnt = adService.getReturnCnt();
		model.addAttribute("adordercnt",adordercnt);
		model.addAttribute("adreturncnt",adreturncnt);
		
		model.addAttribute("vo",vo);
		model.addAttribute("brvos",brvos);
		model.addAttribute("ctvos",ctvos);
		model.addAttribute("subvos",subvos);
		
		return "admin/adBrandCateUpdate";
	}
	
	@RequestMapping(value = "/adProductList",method = RequestMethod.GET)
	public String adProductList(HttpSession session,Model model,
			@RequestParam(name = "sort",defaultValue = "desc",required = false) String sort,
			@RequestParam(name = "pag",defaultValue = "1",required = false)int pag,
			@RequestParam(name = "pageSize",defaultValue = "6",required = false)int pageSize
			) {
		
		String mid = (String) session.getAttribute("sMid");
		LogVO vo = logService.getIdInfor(mid);
		
		PageVO pagevo = pageProcess.getPage(pag, pageSize, "adPrd", sort, "", "","",0,"");
		
		ArrayList<ProductVO> prdvos = pageProcess.getProductList(pagevo.getStartIndexNo(),pagevo.getPageSize(),sort);
		ArrayList<ProductVO> brvos = adService.getBrandList();
		ArrayList<ProductVO> ctvos = adService.getCategoryList();
		int adordercnt = adService.getOrderCnt();
		int adreturncnt = adService.getReturnCnt();
		model.addAttribute("adordercnt",adordercnt);
		model.addAttribute("adreturncnt",adreturncnt);
		
		model.addAttribute("brvos",brvos);
		model.addAttribute("ctvos",ctvos);
		model.addAttribute("pagevo",pagevo);
		model.addAttribute("sort",sort);
		model.addAttribute("prdvos",prdvos);
		model.addAttribute("vo",vo);
		
		return "admin/adProductList";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/brandInput", method = RequestMethod.POST)
	public String setBrandInput(MultipartHttpServletRequest brandImage,ProductVO vo) {
		adService.setBrandImage(brandImage,vo);
		
		return "1";
	}
	
	//상품등록
	@ResponseBody
	@RequestMapping(value = "/setProductInput", method = RequestMethod.POST)
	public String setProductInput(MultipartHttpServletRequest productImage,ProductVO vo) throws IOException {
		if(!vo.getPrdContent().equals("")) {
			com.imgCheck(vo.getPrdContent(), "/temp/", "/content/", 32);
			com.deleteFoler();
			vo.setPrdContent(vo.getPrdContent().replace("/admin/temp/", "/admin/content/"));			
		}
		if(vo.getPrdNum().equals("")) {
			vo.setPrdNum("-");
		}
		if(vo.getPrdRdate() == null) {
			vo.setPrdRdate("-");
		}
		adService.setProductImage(productImage,vo);
		return "1";
	}
	
	// 상품 업데이트
	@ResponseBody
	@RequestMapping(value = "/setProductUpdate", method = RequestMethod.POST)
	public String setProductUpdate(MultipartHttpServletRequest productImage,ProductVO vo) throws IOException {
			ProductVO orivo = adService.getProductVo(vo.getPrdIdx());
			// ckeditor
			adService.imgDelete(orivo.getPrdContent(),"/resources/admin/content/", 35); //기존 이미지 content 방에서 삭제
			if(vo.getPrdContent().indexOf("src=\"/") != -1) {
				com.imgCheck(vo.getPrdContent(), "/temp/", "/content/", 32);
				vo.setPrdContent(vo.getPrdContent().replace("/admin/temp/", "/admin/content/"));
			}
			com.deleteFoler();
			
			// 기본사진
			if(!vo.getPrdfName().equals(orivo.getPrdfName())) {
				adService.setPrdfNameDelete(orivo);
				adService.setProductImageUpdate(productImage, vo);
			}
			else {
				adService.setProductUpdate(vo);				
			}
		return "1";
	}
	
	@ResponseBody
	@PostMapping(value = "/adBrandUpdate")
	public void adBrandUpdate(MultipartHttpServletRequest brandImage,ProductVO vo)throws IOException {
		ProductVO orivo = adService.getBrandInfo(vo.getBrIdx());
		
		if(!vo.getBrfName().equals(orivo.getBrfName())) {
			
			adService.setbrfNameDelete(orivo);
			
			adService.setBrandImageUpdate(brandImage, vo);
			
		}
		else {
			
			adService.setBrandUpdate(vo);	
			
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "/categoryInput", method = RequestMethod.POST)
	public String setcategoryInput(String category) {
		ProductVO vo = adService.getCategory(category);
		
		if(vo != null) {
			return "0";
		}
		else {
			adService.setCategory(category);
			return "1";			
		}	
	}
	
	@ResponseBody
	@RequestMapping(value = "/cateUpdate", method = RequestMethod.POST)
	public String cateUpdate(@RequestParam("idx") int idx,@RequestParam("category") String category) {

		ProductVO vo = adService.getCategory(category);
		
		if(vo != null) {
			return "0";
		}
		else {
			adService.setCateUpdate(idx,category);
			return "1";			
		}	

	}
	
	@ResponseBody
	@RequestMapping(value = "/subCateUpdate", method = RequestMethod.POST)
	public String subCateUpdate(@RequestParam("idx") int idx,@RequestParam("subcategory") String subcategory) {
		System.out.println(idx+"/"+subcategory);
		ProductVO vo = adService.getSubCategory(subcategory);
		
		if(vo != null) {
			return "0";
		}
		else {
			adService.setSubCateUpdate(idx,subcategory);
			return "1";			
		}	
	}
	@ResponseBody
	@RequestMapping(value = "/subCategoryInput", method = RequestMethod.POST)
	public String setSubCategoryInput(String subCategory ,String category) {
		System.out.println(category+"/"+subCategory);
		ProductVO vo = adService.getSubCategory(subCategory);
		
		if(vo != null) {
			return "0";
		}
		else {
			adService.setSubCategory(category,subCategory);
			return "1";			
		}	
	}
	@ResponseBody
	@RequestMapping(value = "/cateDelete",method = RequestMethod.POST)
	public String cateDelete(@RequestParam("idx") int idx) {
		ProductVO vo = adService.cateDeleteCheck(idx);
		
		if(vo != null) {
			return "0";
		}
		else {
			adService.cateDelete(idx);
			return "1";			
		}	
	}
	@ResponseBody
	@RequestMapping(value = "/subCateDelete",method = RequestMethod.POST)
	public String subCateDelete(@RequestParam("idx") int idx) {
		ProductVO vo = adService.subCateDeleteCheck(idx);
		
		if(vo != null) {
			return "0";
		}
		else {
			adService.subCateDelete(idx);
			return "1";			
		}	
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/getSubCategory",method = RequestMethod.POST)
	public ArrayList<ProductVO> getSubCategory(String category){
		ArrayList<ProductVO> vos = adService.getSubCategories(category);
		return vos;
	}
	
	// (옵션등록) 브랜드선택시 카테고리값 가저오기
	@ResponseBody
	@RequestMapping(value = "/getBrandCategory",method = RequestMethod.POST)
	public ArrayList<ProductVO> getBrandCategory(String brand){
		ArrayList<ProductVO> vos = adService.getBrandCategory(brand);
		return vos;
	}
	// (옵션등록) 카테고리선택시 서브카테고리값 가저오기
	@ResponseBody
	@RequestMapping(value = "/getBCSubCategory",method = RequestMethod.POST)
	public ArrayList<ProductVO> getBCSubCategory(String brand,String category){
		ArrayList<ProductVO> vos = adService.getBCSubCategory(brand,category);
		return vos;
	}
	// (옵션등록) 브랜드선택시 카테고리값 가저오기
	@ResponseBody
	@RequestMapping(value = "/getBCSProduct",method = RequestMethod.POST)
	public ArrayList<ProductVO> getBCSProduct(String brand,String category,String subCategory){
		ArrayList<ProductVO> vos = adService.getBCSProduct(brand,category,subCategory);
		return vos;
	}
	// 옵션등록
	@ResponseBody
	@RequestMapping(value = "/optionInput",method = RequestMethod.POST)
	public String setOptionInput(int prdIdx,String size,int count){
		ProductVO vo = adService.getUseOption(prdIdx,size);
		
		int indexCount = 0;
		
		
		if(vo != null) {
			return "0";
		}
		if(size.equals("230") || size.equals("XL")) {
			indexCount=0;
		}
		else if(size.equals("235") || size.equals("L")){
			indexCount=1;
		}
		else if(size.equals("240") || size.equals("M")){
			indexCount=2;
		}
		else if(size.equals("245") || size.equals("S")){
			indexCount=3;
		}
		else if(size.equals("250")) indexCount=4;
		else if(size.equals("255")) indexCount=5;
		else if(size.equals("260")) indexCount=6;
		else if(size.equals("265")) indexCount=7;
		else if(size.equals("270")) indexCount=8;
		else if(size.equals("275")) indexCount=9;
		else if(size.equals("280")) indexCount=10;
		else indexCount=11;
		
		/* adService.setOptionInput(prdIdx,size,count,indexCount); */
		adService.setOptionInput(prdIdx,size,count,indexCount);
		adService.setPrdSell(prdIdx);
		
		return "1";
	}
	
	@ResponseBody
	@RequestMapping(value = "/prdSell",method = RequestMethod.POST)
	public String prdSellPost(int prdIdx, String flag) {
		if(flag.equals("prdSell")) {
			ProductVO vo =  adService.getOption(prdIdx);
			if(vo == null) {
				return "0";
			}
			else {
				adService.setPrdSell(prdIdx);
				return "1";
			}
		}
		else {
			adService.setPrdSellStop(prdIdx);
			return "1";
		}
	}
	// 수정버튼 누를시 정보값 변동후 출력
	@ResponseBody
	@RequestMapping(value = "/getPrdInfor", method = RequestMethod.POST)
	public ArrayList<ProductVO> getPrdInfor(int prdIdx) throws IOException{
		ArrayList<ProductVO> vos = new ArrayList<ProductVO>();
		ProductVO vo = adService.getOption(prdIdx);
		if(vo == null) {
			vos = adService.getProductInfor(prdIdx);
		}
		else {
			vos = adService.getPrdInfor(prdIdx);			
		}
		com.setFolder();
		com.imgCheck(vos.get(0).getPrdContent(), "/content/", "/temp/", 35);
		
		vos.get(0).setPrdContent(vos.get(0).getPrdContent().replace("/admin/content/", "/admin/temp/"));
		return vos;
	}
	@RequestMapping(value = "/adOrderList", method = RequestMethod.GET)
	public String adOrderListGet(HttpSession session,Model model,
			@RequestParam(name = "sort",defaultValue = "desc",required = false) String sort,
			@RequestParam(name = "pag",defaultValue = "1",required = false)int pag,
			@RequestParam(name = "pageSize",defaultValue = "6",required = false)int pageSize,
			@RequestParam(name = "date",defaultValue = "",required = false)String date,		
			@RequestParam(name = "orderDate",defaultValue = "1" ,required = false)int orderDate,
			@RequestParam(name = "search",defaultValue = "",required = false)String search,
			@RequestParam(name = "part",defaultValue = "",required = false)String part,
			@RequestParam(name = "btdate",defaultValue = "",required = false)String btdate,			
			@RequestParam(name = "val",defaultValue = "99",required = false)int val			
			) throws Exception {
		Calendar calendar = Calendar.getInstance();
		calendar.set(Calendar.DAY_OF_MONTH, 1);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		String startDate = sdf.format(calendar.getTime());
		
		
		String mid = (String) session.getAttribute("sMid");
		LogVO vo = logService.getIdInfor(mid);
		PageVO pagevo = pageProcess.getOrderPage(0,pag,pageSize,sort,date,orderDate,btdate,search,val,part);
		
		ArrayList<OrderVO> vos = pageProcess.getOrderList(pagevo.getStartIndexNo(),pagevo.getPageSize(),sort,date,orderDate,part,search,btdate,val);
		ArrayList<ReturnVO> revos = adService.getReturnCheck();
		int adordercnt = adService.getOrderCnt();
		int adreturncnt = adService.getReturnCnt();
		model.addAttribute("adordercnt",adordercnt);
		model.addAttribute("adreturncnt",adreturncnt);
		
		model.addAttribute("startDate",startDate);
		model.addAttribute("pagevo",pagevo);
		model.addAttribute("revos",revos);
		model.addAttribute("sort",sort);
		model.addAttribute("vo",vo);
		model.addAttribute("vos",vos);
		return "admin/adOrderList";
	}
	@RequestMapping(value = "/adReturnList", method = RequestMethod.GET)
	public String adReturnListGet(HttpSession session,Model model,
			@RequestParam(name = "sort",defaultValue = "desc",required = false) String sort,
			@RequestParam(name = "pag",defaultValue = "1",required = false)int pag,
			@RequestParam(name = "pageSize",defaultValue = "6",required = false)int pageSize,
			@RequestParam(name = "date",defaultValue = "",required = false)String date,		
			@RequestParam(name = "orderDate",defaultValue = "1" ,required = false)int orderDate,
			@RequestParam(name = "search",defaultValue = "",required = false)String search,
			@RequestParam(name = "part",defaultValue = "",required = false)String part,
			@RequestParam(name = "btdate",defaultValue = "",required = false)String btdate,			
			@RequestParam(name = "val",defaultValue = "99",required = false)int val			
			) {
		Calendar calendar = Calendar.getInstance();
		calendar.set(Calendar.DAY_OF_MONTH, 1);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		String startDate = sdf.format(calendar.getTime());
		
		
		String mid = (String) session.getAttribute("sMid");
		LogVO vo = logService.getIdInfor(mid);
		PageVO pagevo = pageProcess.getReturnPage(0,pag,pageSize,sort,date,orderDate,btdate,search,val,part);
		
		ArrayList<ReturnVO> revos = pageProcess.getReturnList(pagevo.getStartIndexNo(),pagevo.getPageSize(),sort,date,orderDate,part,search,btdate,val);
		
		//ArrayList<ReturnVO> revos = adService.getReturnCheck();
		
		int adordercnt = adService.getOrderCnt();
		int adreturncnt = adService.getReturnCnt();
		
		model.addAttribute("adordercnt",adordercnt);
		model.addAttribute("adreturncnt",adreturncnt);
		
		model.addAttribute("startDate",startDate);
		model.addAttribute("pagevo",pagevo);
		model.addAttribute("revos",revos);
		model.addAttribute("sort",sort);
		model.addAttribute("vo",vo);
		return "admin/adReturnList";
	}
	
	@ResponseBody
	@RequestMapping(value = "/getOrderInfo",method = RequestMethod.POST)
	public ArrayList<OrderVO> getOrderInfo(int orderIdx){
		
		ArrayList<OrderVO> vos = adService.getOrderInfo(orderIdx);
		return vos;
	}
	@ResponseBody
	@RequestMapping(value = "/getReturnInfo",method = RequestMethod.POST)
	public ArrayList<ReturnVO> getReturnInfo(int reIdx){
		
		ArrayList<ReturnVO> vos = adService.getReturnInfo(reIdx);
		return vos;
	}
	@ResponseBody
	@RequestMapping(value = "/updateOrderVal",method = RequestMethod.POST)
	public void updateOrderValPost(int orderIdx, int val) {
		adService.updateOrderVal(orderIdx,val);
		if(val == 5) {
			adService.updateOrderLastDate(orderIdx);
		}
		else if(val == 6) {
			OrderVO vo = adService.getOrderSub(orderIdx);
			adService.setMempoint(vo.getOrder_memIdx(),vo.getOrder_prdPoint());
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "/returnOk",method = RequestMethod.POST)
	public void returnOkPost(int reIdx) {
		ArrayList<ReturnVO> vos = adService.getReturnInfo(reIdx);
		// 주문내역
		int orderIdx = vos.get(0).getOrder_Idx();
		int pay_price = vos.get(0).getReturn_totalprice();
		int pay_setPoint = vos.get(0).getReturn_point();
		
		adService.setReturnUpdate(orderIdx,pay_price,pay_setPoint);
		// 주문내역 서브
		for(int i = 0; i<vos.size(); i++) {
			int order_subIdx = vos.get(i).getResub_subIdx();
			int order_prdIdx = vos.get(i).getResub_prdIdx();
			int order_prdCount = vos.get(i).getResub_count();
			int order_prdPoint = vos.get(i).getResub_delPoint();
			String order_prdoption = vos.get(i).getResub_option();
			adService.setReturnsubUpdate(order_subIdx,order_prdCount,order_prdPoint); // 주문내역에서 마이너스
			adService.setProductreCnt(order_prdIdx,order_prdCount,order_prdoption); // 상품갯수 되돌려놓기
			adService.updateReturnOk(vos.get(i).getResubIdx()); // 환불성공 카운트
		}
		int cnt = 0; // 주문했던 상품의 갯수가 0인 수 
		ArrayList<OrderVO> ovos = adService.getOrdery(orderIdx);
		for(int i = 0; i<ovos.size(); i++) {
			System.out.println(ovos.get(i).getOrder_subIdx());
			if(ovos.get(i).getOrder_prdCount() == 0) {
			//	adService.deleteSubOrder(ovos.get(i).getOrder_subIdx());
				cnt ++;
			}
		}
		adService.updateIndexcnt(orderIdx,cnt);
//		if(cnt == ovos.size()) { // 주문내역을 물고있는 서브 주문내역의 모든상품이 0인가
//			adService.deleteOrder(orderIdx);
//		}
//		else { // 그게아니면 rowspan을 위한 카운트를 cnt만큼 마이너스
//			adService.updateIndexcnt(orderIdx,cnt);
//		}
		
	}
	@ResponseBody
	@PostMapping(value = "getBrandInfo")
	public ProductVO getBrandInfo(@RequestParam(value = "brIdx")int brIdx) {
		ProductVO vo = adService.getBrandInfo(brIdx);
		return vo;
	}
	
	@ResponseBody
	@PostMapping(value = "getBrandPrd")
	public String getBrandPrd(@RequestParam(value = "brIdx")int brIdx) {
		String str = "";
		int cnt = adService.getBrandPrdCnt(brIdx);
		
		if(cnt > 0) {
			str = "0";
		}
		else {
			str = "1";
		}
		
		
		return str;
	}
	@ResponseBody
	@PostMapping(value = "deleteBrand")
	public void deleteBrand(@RequestParam(value = "brIdx")int brIdx) {
		ProductVO vo = adService.getBrandInfo(brIdx);
		adService.setbrfNameDelete(vo);
		adService.setBrandDelete(brIdx);
	}
	
	@RequestMapping(value = "/adOrderChart",method = RequestMethod.GET)
	public String adOrderChart(HttpSession session,Model model) {
		String mid = (String) session.getAttribute("sMid");
		LogVO vo = logService.getIdInfor(mid);
		
		model.addAttribute("vo",vo);
		
		return "admin/adOrderChart";
	}
	@ResponseBody
	@RequestMapping(value = "/orderChartTotal",method = RequestMethod.POST)
	public void orderChartTotal(HttpServletResponse response, HttpSession session) {
		List<ChartVO> list = adService.getOrderChartTotal();
		session.setAttribute("list", list);
		Gson gson = new Gson();
		String json = "";
		json = gson.toJson(list);
		response.setContentType("application/json");
		response.setCharacterEncoding("utf-8");
		try {
			response.getWriter().print(json);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value = "/decList",method = RequestMethod.GET)
	public String decList(Model model,HttpSession session,
			@RequestParam(name = "pag",defaultValue = "1",required = false)int pag,
			@RequestParam(name = "pageSize",defaultValue = "6",required = false)int pageSize) {
		PageVO pagevo = pageProcess.getDectot(pag,pageSize);
		ArrayList<BoVO> vos = adService.getDelcList(pagevo.getStartIndexNo(),pagevo.getPageSize());
		String mid = (String) session.getAttribute("sMid");
		LogVO vo = logService.getIdInfor(mid);
		
		int adordercnt = adService.getOrderCnt();
		int adreturncnt = adService.getReturnCnt();
		model.addAttribute("adordercnt",adordercnt);
		model.addAttribute("adreturncnt",adreturncnt);
		
		model.addAttribute("vo",vo);
		model.addAttribute("pagevo",pagevo);
		model.addAttribute("vos",vos);
		return "admin/adDeclaration";
	}
	@ResponseBody
	@PostMapping("/getDeclContent")
	public BoVO getDeclContent(@RequestParam("d_Idx") int d_Idx){
		BoVO vo = adService.getDeclContent(d_Idx);
		return vo;
	}
	@ResponseBody
	@PostMapping("/decOk")
	public void decOk(BoVO vo){
		adService.setDecComent(vo);
	}
	
	@RequestMapping(value = "/feedList",method = RequestMethod.GET)
	public String feedListGet(Model model,HttpSession session,
			@RequestParam(name = "pag",defaultValue = "1",required = false)int pag,
			@RequestParam(name = "pageSize",defaultValue = "10",required = false)int pageSize) {
		String mid = (String) session.getAttribute("sMid");
		LogVO vo = logService.getIdInfor(mid);
		
		PageVO pagevo = pageProcess.getAdFeedAlltot(pag,pageSize);
		ArrayList<BoVO> vos = pageProcess.getAdFeedAll(pagevo.getStartIndexNo(),pagevo.getPageSize());
		
		int adordercnt = adService.getOrderCnt();
		int adreturncnt = adService.getReturnCnt();
		model.addAttribute("adordercnt",adordercnt);
		model.addAttribute("adreturncnt",adreturncnt);
		
		model.addAttribute("pagevo",pagevo);
		model.addAttribute("vo",vo);
		model.addAttribute("vos",vos);
		return "admin/adFeedList";
	}
	
	@ResponseBody
	@PostMapping("/getAdUserContent")
	public BoVO getAdUserContent(@RequestParam("boIdx")int boIdx) throws Exception {
		BoVO vo = adService.getAdUserContent(boIdx);
		
		return vo;
	}
	@ResponseBody
	@PostMapping("/feedBline")
	public void feedBline(@RequestParam("boIdx")int boIdx){
		adService.setFeedBline(boIdx);
	}
	@ResponseBody
	@PostMapping("/feedDel")
	public void feedDel(@RequestParam("boIdx")int boIdx){
		adService.setFeedDel(boIdx);
	}
	
}
