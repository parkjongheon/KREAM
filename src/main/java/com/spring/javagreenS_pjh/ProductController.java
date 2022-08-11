package com.spring.javagreenS_pjh;

import java.util.ArrayList;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javagreenS_pjh.pagination.PageProcess;
import com.spring.javagreenS_pjh.pagination.PageVO;
import com.spring.javagreenS_pjh.service.BoardService;
import com.spring.javagreenS_pjh.service.LogService;
import com.spring.javagreenS_pjh.service.ProductService;
import com.spring.javagreenS_pjh.vo.BoVO;
import com.spring.javagreenS_pjh.vo.LogVO;
import com.spring.javagreenS_pjh.vo.OrderVO;
import com.spring.javagreenS_pjh.vo.ProductVO;

@Controller
@RequestMapping("/product")
public class ProductController {
	
	@Autowired
	ProductService prdService;
	
	@Autowired
	LogService logService;
	
	@Autowired
	PageProcess pageProcess;
	
	@Autowired
	BoardService boardService;
	
	@RequestMapping(value = "/productMain",method = RequestMethod.GET)
	public String productGet(@RequestParam(name = "pag",defaultValue = "1",required = false)int pag,
			@RequestParam(name = "pageSize",defaultValue = "16",required = false)int pageSize,
			@RequestParam(name = "sort",defaultValue = "desc",required = false)String sort,
			@RequestParam(name = "brand",defaultValue = "",required = false)String brand,
			@RequestParam(name = "part",defaultValue = "",required = false)String part,
			@RequestParam(name = "subpart",defaultValue = "",required = false)String subpart,
			@RequestParam(name = "search",defaultValue = "",required = false)String search,
			Model model,HttpSession session) {
		int sIdx = session.getAttribute("sIdx")==null ? 0 : (int) session.getAttribute("sIdx");
//		PageVO pagevo  = pageProcess.getPage(pag, pageSize, "product", sort,part,subpart,search,0,"");
		PageVO pagevo  =  pageProcess.getPrdtot(pag, pageSize,sort,brand,part,subpart,search);
		ArrayList<ProductVO> vos = prdService.getProduct(pagevo.getStartIndexNo(),pageSize,sort,brand,part,subpart,search);
		
		ArrayList<ProductVO> brvos = prdService.getBrand();
		ArrayList<ProductVO> catvos = prdService.getCategory();
		ArrayList<ProductVO> wvos = prdService.getWishList(sIdx);
		
		model.addAttribute("pagevo",pagevo);
		model.addAttribute("wvos",wvos);
		model.addAttribute("vos",vos);
		model.addAttribute("catvos",catvos);
		model.addAttribute("brvos",brvos);
		return "product/productMain";
	}
	
	@RequestMapping(value = "/productInfo",method = RequestMethod.GET)
	public String productInfoGet(Model model,
			@RequestParam(name = "prdIdx") int prdIdx,
			HttpSession session) {
		int sIdx = session.getAttribute("sIdx")==null ? 0 : (int) session.getAttribute("sIdx");
		ProductVO vo = prdService.GetProductInfo(prdIdx);
		ArrayList<ProductVO> vos = prdService.getProductOption(prdIdx);
		ArrayList<ProductVO> wvos = prdService.getWishList(sIdx);
		ArrayList<ProductVO> brvos = prdService.getPrdBrandList(vo.getEbrName(),prdIdx);
		ArrayList<BoVO> bvos = boardService.getPrdBoardList(prdIdx);
		ArrayList<BoVO> blvos = boardService.getBoardLikeList(sIdx);
		
		model.addAttribute("vo",vo);
		model.addAttribute("vos",vos);
		model.addAttribute("bvos",bvos);
		model.addAttribute("blvos",blvos);
		model.addAttribute("brvos",brvos);
		model.addAttribute("wvos",wvos);
		
		return "product/productInfo";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/getSubCategory",method = RequestMethod.POST)
	public ArrayList<ProductVO> getSubCategory(String idx){
		ArrayList<ProductVO> vos = prdService.getSubCategory(idx);
		
		return vos;
	}
	
	@ResponseBody
	@RequestMapping(value = "/cartCheck", method = RequestMethod.POST)
	public String cartCheckPost(@RequestParam(name = "itemSize") String[] size,
			@RequestParam(name = "itemCount") int [] count,
			@RequestParam(name = "prdIdx") int prdIdx,
			HttpSession session) {
		
		int memIdx = (int) session.getAttribute("sIdx");
		
		for(int i = 0; i<count.length; i++) {
			ProductVO vo =  prdService.getSelectCart(memIdx,prdIdx,size[i],count[i]);
			if(vo != null) {
				prdService.setUpdateCart(memIdx,prdIdx,size[i],count[i]);
			}
			else {
				prdService.setCart(memIdx,prdIdx,size[i],count[i]);
			}
		}
		return "1";
	}
	
	@ResponseBody
	@RequestMapping(value = "/cartInput", method = RequestMethod.POST)
	public String cartInputPost(@RequestParam(name = "itemSize") String[] size,
			@RequestParam(name = "itemCount") int [] count,
			@RequestParam(name = "prdIdx") int prdIdx,
			HttpSession session) {
		
		int memIdx = (int) session.getAttribute("sIdx");
		
		for(int i = 0; i<count.length; i++) {
			ProductVO vo =  prdService.getSelectCart(memIdx,prdIdx,size[i],count[i]);
			if(vo != null) {
				prdService.setUpdateCart(memIdx,prdIdx,size[i],count[i]);
			}
			else {
				prdService.setCart(memIdx,prdIdx,size[i],count[i]);
			}
		}
		return "1";
	}
	
	
	@RequestMapping(value = "/productSellPage",method = RequestMethod.POST)
	public String productSellPagePost(
			Model model,HttpSession session,
			@RequestParam(name = "itemSize") String[] size,
			@RequestParam(name = "itemCount") int [] count,
			@RequestParam(name = "prdIdx") int[] prdIdx
			){
		
		int memIdx = (int) session.getAttribute("sIdx");
		String mid = (String) session.getAttribute("sMid");
		ArrayList<ProductVO> vos = new ArrayList<ProductVO>();
		int totCount = 0;
		for(int i = 0; i<count.length; i++) {
			ProductVO vo =  prdService.getSelectCart(memIdx,prdIdx[i],size[i],count[i]);
			totCount = totCount + count[i];
			vos.add(vo);
		}	
		LogVO logvo = logService.getIdInfor(mid);
		
		
		model.addAttribute("totCount", totCount);
		model.addAttribute("vos", vos);
		model.addAttribute("logvo", logvo);
		
		return "product/productSellPage";
	}
	@RequestMapping(value = "/productCartPage", method = RequestMethod.GET)
	public String productCartPageGet(Model model,HttpSession session) {
		int memIdx = (int) session.getAttribute("sIdx");
		ArrayList<ProductVO> vos = prdService.getCartList(memIdx);
		model.addAttribute("vos", vos);
		return "product/productCartPage";
	}
	
	@ResponseBody
	@RequestMapping(value = "/deleteCart", method = RequestMethod.POST)
	public String deleteCartPost(int idx) {
		prdService.deleteCart(idx);
		return "1";
	}
	@ResponseBody
	@RequestMapping(value = "/optionCountUp", method = RequestMethod.POST)
	public String optionCountUpPost(int idx) {
		prdService.setOptionCountUp(idx);
		return "1";
	}
	@ResponseBody
	@RequestMapping(value = "/optionCountDown", method = RequestMethod.POST)
	public String optionCountDownPost(int idx) {
		prdService.setOptionCountDown(idx);
		return "1";
	}
	
	@RequestMapping(value = "/productOrderOk", method = RequestMethod.POST)
	public String productOrderOk(OrderVO vo , HttpSession session) {
		int memIdx = (int) session.getAttribute("sIdx");
		vo.setMemIdx(memIdx);
		vo.setIndexcnt(vo.getPrdPrice().length);
		prdService.setOrder(vo); // 최초 주문테이블에 생성
		int orderIdx = prdService.getOrderIdx(memIdx); // 방금생성한 주문내역 고유번호 가저오기
		for(int i = 0; i<vo.getPrdIdx().length; i++) { 
			// 주문테이블의 고유번호를 물고있는 주문서브내역에 추가
			prdService.setOrderSub(orderIdx,memIdx,vo.getPrdIdx()[i],vo.getPrdCount()[i],vo.getPrdPrice()[i],vo.getPrdOption()[i],vo.getPrdTotalPoint()[i]);
			// 선택한상품의 재고수량파악
			int nowCount = prdService.getOptionCount(vo.getPrdIdx()[i],vo.getPrdOption()[i]);
			// 재고수량과 선택수량을 비교해서 현재상태를 비교하여 -단위 숫자로 안넘어가게 함
			if(nowCount >= vo.getPrdCount()[i]) {
				prdService.setOrderProductCount(vo.getPrdIdx()[i],vo.getPrdCount()[i],vo.getPrdOption()[i]);	
			}
			else {
				prdService.setOrderProductCount(vo.getPrdIdx()[i],0,vo.getPrdOption()[i]);	
			}
			prdService.OrderSetdeleteCart(memIdx,vo.getPrdIdx()[i],vo.getPrdOption()[i]);
		}
		prdService.setUsePoint(memIdx,vo.getSetPoint()); // 회원이 사용한 포인트 차감
		
		
		return "product/productPayOk";
	}
	@ResponseBody
	@RequestMapping(value = "/wishUp",method = RequestMethod.POST)
	public void wishUpPost(int memIdx,int prdIdx) {
		prdService.wishUpPost(memIdx,prdIdx);
		prdService.prdWishUpPost(prdIdx);
	}
	@ResponseBody
	@RequestMapping(value = "/wishDown",method = RequestMethod.POST)
	public void wishDownPost(int memIdx,int prdIdx) {
		prdService.wishDownPost(memIdx,prdIdx);
		prdService.prdWishDownPost(prdIdx);
	}
	@ResponseBody
	@RequestMapping(value = "/optionChange",method = RequestMethod.POST)
	public void optionChange(int opIdx,int count) {
		prdService.setOptionChange(opIdx,count);
	}
	
}
