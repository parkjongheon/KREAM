package com.spring.javagreenS_pjh.pagination;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javagreenS_pjh.dao.AdDAO;
import com.spring.javagreenS_pjh.dao.BoardDAO;
import com.spring.javagreenS_pjh.dao.MemDAO;
import com.spring.javagreenS_pjh.dao.ProductDAO;
import com.spring.javagreenS_pjh.vo.BoVO;
import com.spring.javagreenS_pjh.vo.LogVO;
import com.spring.javagreenS_pjh.vo.MsgVO;
import com.spring.javagreenS_pjh.vo.OrderVO;
import com.spring.javagreenS_pjh.vo.ProductVO;
import com.spring.javagreenS_pjh.vo.ReturnVO;

@Service
public class PageProcess {
	@Autowired
	AdDAO adDao;
	
	@Autowired
	ProductDAO prdDao;
	
	@Autowired
	MemDAO memdao;
	
	@Autowired
	BoardDAO bodao;
	
	public PageVO getPage(int pag, int pageSize,String section, String sort, String part,String subpart, String searchString,int orderDate,String btdate) {
		PageVO vo = new PageVO();
		
		//section에 따른 레코드 갯수를 구해오기
		
		int totRecCnt = 0;
		if(section.equals("adMem")) {
			totRecCnt = adDao.totRecCnt();			
		}
		else if(section.equals("adPrd")){
			totRecCnt = adDao.prdRecCnt();
		}
		else if(section.equals("product")){
			totRecCnt = adDao.productRecCnt(part,subpart,searchString);
		}
		else if(section.equals("adOrder")) {
			String start = "";
			String end = "";
			if(btdate.contains("/")) {
				String num[] = btdate.split("/");
				start = num[0];
				end = num[1];				
			}
			totRecCnt = adDao.OrdertotRecCnt(part,orderDate,searchString,start,end);							
		}
		
		
		
		int totPage = (totRecCnt % pageSize)==0 ? totRecCnt / pageSize : (totRecCnt/pageSize)+1;
		int startIndexNo = (pag - 1)* pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage % blockSize) ==0 ? (totPage / blockSize)-1 : (totPage / blockSize);
		
		vo.setPag(pag);
		vo.setPageSize(pageSize);
		vo.setTotRecCnt(totRecCnt);
		vo.setTotPage(totPage);
		vo.setStartIndexNo(startIndexNo);
		vo.setCurScrStartNo(curScrStartNo);
		vo.setBlockSize(blockSize);
		vo.setCurBlock(curBlock);
		vo.setLastBlock(lastBlock);
		
		return vo;
		
	}
	
	public PageVO getOrderPage(int memIdx, int pag, int pageSize, String sort, String date, int orderDate, String btdate,
			String search,int val,String part) {
		PageVO vo = new PageVO();
		int totRecCnt = 0;
		String start = "";
		String end = "";
		if(btdate.contains("/")) {
			String num[] = btdate.split("/");
			start = num[0];
			end = num[1];				
		}
		if(memIdx != 0) {
			totRecCnt = memdao.myOrdertotRecCnt(memIdx,orderDate,date,search,start,end,val);				
		}
		else {
			totRecCnt = adDao.adOrdertotRecCnt(orderDate,date,search,part,start,end,val);
		}
		
		int totPage = (totRecCnt % pageSize)==0 ? totRecCnt / pageSize : (totRecCnt/pageSize)+1;
		int startIndexNo = (pag - 1)* pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage % blockSize) ==0 ? (totPage / blockSize)-1 : (totPage / blockSize);
		
		vo.setPag(pag);
		vo.setPageSize(pageSize);
		vo.setTotRecCnt(totRecCnt);
		vo.setTotPage(totPage);
		vo.setStartIndexNo(startIndexNo);
		vo.setCurScrStartNo(curScrStartNo);
		vo.setBlockSize(blockSize);
		vo.setCurBlock(curBlock);
		vo.setLastBlock(lastBlock);
		
		return vo;
	}	

	public PageVO getReturnPage(int memIdx, int pag, int pageSize, String sort, String date, int orderDate, String btdate,
			String search, int val, String part) {
		PageVO vo = new PageVO();
		int totRecCnt = 0;
		String start = "";
		String end = "";
		if(btdate.contains("/")) {
			String num[] = btdate.split("/");
			start = num[0];
			end = num[1];				
		}
		if(memIdx != 0) {
			totRecCnt = memdao.myReturntotRecCnt(memIdx,orderDate,date,search,start,end,val);				
		}
		else {
			totRecCnt = adDao.adReturntotRecCnt(orderDate,date,search,part,start,end,val);
		}
		
		int totPage = (totRecCnt % pageSize)==0 ? totRecCnt / pageSize : (totRecCnt/pageSize)+1;
		int startIndexNo = (pag - 1)* pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage % blockSize) ==0 ? (totPage / blockSize)-1 : (totPage / blockSize);
		
		vo.setPag(pag);
		vo.setPageSize(pageSize);
		vo.setTotRecCnt(totRecCnt);
		vo.setTotPage(totPage);
		vo.setStartIndexNo(startIndexNo);
		vo.setCurScrStartNo(curScrStartNo);
		vo.setBlockSize(blockSize);
		vo.setCurBlock(curBlock);
		vo.setLastBlock(lastBlock);
		
		return vo;
	}


	public ArrayList<LogVO> getMemberList(int startIndexNo, int pageSize, String sort) {
		ArrayList<LogVO> vos = adDao.getMemberList(startIndexNo,pageSize,sort);
		return vos;
	}


	public ArrayList<ProductVO> getProductList(int startIndexNo, int pageSize, String sort) {
		ArrayList<ProductVO> prdvos = adDao.getProductList(startIndexNo,pageSize,sort);
		return prdvos;
	}


	public ArrayList<OrderVO> getOrderList(int startIndexNo, int pageSize, String sort,String date,int orderDate,String part,String search,String btdate,int val) throws Exception {
		String start = "";
		String end = "";
		if(btdate.contains("/")) {
			String num[] = btdate.split("/");
			start = num[0];
			end = num[1];				
		}
		ArrayList<OrderVO> vos = adDao.getOrderList(startIndexNo,pageSize,sort,date,orderDate,part,search,start,end,val);
		for(int i = 0; i<vos.size(); i++) {
			if(vos.get(i).getOrder_lastdate() != null) {
				long mindate = caldate(vos.get(i).getOrder_lastdate());
				
				long diffSec =  mindate / 1000; //초 차이
		    long diffDays = diffSec / (24*60*60);
			  String strTime = diffDays+"일 전";
		    
			  vos.get(i).setMindate(diffDays);
			  vos.get(i).setStrTime(strTime);
			}
			else {
				vos.get(i).setMindate(1);
			}
		}
		return vos;
	}

	private long caldate(String order_lastdate) throws Exception {
		String todayNow = new SimpleDateFormat("yyyy-MM-dd").format(new Date(System.currentTimeMillis()));
		
		Date format1 = new SimpleDateFormat("yyyy-MM-dd").parse(order_lastdate);
    Date format2 = new SimpleDateFormat("yyyy-MM-dd").parse(todayNow);
    long diffSec = (format1.getTime() - format2.getTime());
    
		return diffSec;
	}

	public ArrayList<OrderVO> getMemOrderList(int memIdx,int startIndexNo, int pageSize, String sort, String date, int orderDate,
			String search, String btdate,int val) throws Exception {
		String start = "";
		String end = "";
		if(btdate.contains("/")) {
			String num[] = btdate.split("/");
			start = num[0];
			end = num[1];				
		}
		ArrayList<OrderVO> vos = memdao.getMemOrderList(memIdx,startIndexNo,pageSize,sort,date,orderDate,search,start,end,val);
		for(int i = 0; i<vos.size(); i++) {
			if(vos.get(i).getOrder_lastdate() != null) {
				long mindate = caldate(vos.get(i).getOrder_lastdate());
				
				long diffSec =  mindate / 1000; //초 차이
		    long diffDays = diffSec / (24*60*60);
			  String strTime = diffDays+"일 전";
		    
			  vos.get(i).setMindate(diffDays);
			  vos.get(i).setStrTime(strTime);
			}
		}
		return vos;
	}

	public ArrayList<ReturnVO> getReturnList(int startIndexNo, int pageSize, String sort, String date, int orderDate,
			String part, String search, String btdate, int val) {
		String start = "";
		String end = "";
		if(btdate.contains("/")) {
			String num[] = btdate.split("/");
			start = num[0];
			end = num[1];				
		}
		return adDao.getReturnList(startIndexNo,pageSize,sort,date,orderDate,part,search,start,end,val);
	}
	public ArrayList<ReturnVO> getMemReturnList(int memIdx, int startIndexNo, int pageSize, String sort, String date,
			int orderDate, String search, String btdate, int val) {
		String start = "";
		String end = "";
		if(btdate.contains("/")) {
			String num[] = btdate.split("/");
			start = num[0];
			end = num[1];				
		}
		return memdao.getMemReturnList(memIdx,startIndexNo,pageSize,sort,date,orderDate,start,end,val);
	}
	
	
	public PageVO getFeedtot(int pag, int pageSize) {
		PageVO vo = new PageVO();
		int totRecCnt = 0;
		totRecCnt = bodao.feedAllCnt();
		int totPage = (totRecCnt % pageSize)==0 ? totRecCnt / pageSize : (totRecCnt/pageSize)+1;
		int startIndexNo = (pag - 1)* pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage % blockSize) ==0 ? (totPage / blockSize)-1 : (totPage / blockSize);
		
		vo.setPag(pag);
		vo.setPageSize(pageSize);
		vo.setTotRecCnt(totRecCnt);
		vo.setTotPage(totPage);
		vo.setStartIndexNo(startIndexNo);
		vo.setCurScrStartNo(curScrStartNo);
		vo.setBlockSize(blockSize);
		vo.setCurBlock(curBlock);
		vo.setLastBlock(lastBlock);
		return vo;
	}
	public PageVO getFeedFollowtot(int pag, int pageSize, int sIdx, String flag) {
		PageVO vo = new PageVO();
		
		int totRecCnt = 0;
		totRecCnt = bodao.feedFollowtot(sIdx);
		int totPage = (totRecCnt % pageSize)==0 ? totRecCnt / pageSize : (totRecCnt/pageSize)+1;
		int startIndexNo = (pag - 1)* pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage % blockSize) ==0 ? (totPage / blockSize)-1 : (totPage / blockSize);
		
		vo.setPag(pag);
		vo.setPageSize(pageSize);
		vo.setTotRecCnt(totRecCnt);
		vo.setTotPage(totPage);
		vo.setStartIndexNo(startIndexNo);
		vo.setCurScrStartNo(curScrStartNo);
		vo.setBlockSize(blockSize);
		vo.setCurBlock(curBlock);
		vo.setLastBlock(lastBlock);
		return vo;
	}
	public PageVO getFeedTagtot(int pag, int pageSize, String tags) {
		PageVO vo = new PageVO();
		
		int totRecCnt = 0;
		totRecCnt = bodao.feedTagtot(tags);
		int totPage = (totRecCnt % pageSize)==0 ? totRecCnt / pageSize : (totRecCnt/pageSize)+1;
		int startIndexNo = (pag - 1)* pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage % blockSize) ==0 ? (totPage / blockSize)-1 : (totPage / blockSize);
		
		vo.setPag(pag);
		vo.setPageSize(pageSize);
		vo.setTotRecCnt(totRecCnt);
		vo.setTotPage(totPage);
		vo.setStartIndexNo(startIndexNo);
		vo.setCurScrStartNo(curScrStartNo);
		vo.setBlockSize(blockSize);
		vo.setCurBlock(curBlock);
		vo.setLastBlock(lastBlock);
		return vo;
	}

	public PageVO getPrdFeedtot(int pag, int pageSize, int prdIdx) {
		PageVO vo = new PageVO();
		
		int totRecCnt = 0;
		totRecCnt = bodao.getPrdFeedtot(prdIdx);
		int totPage = (totRecCnt % pageSize)==0 ? totRecCnt / pageSize : (totRecCnt/pageSize)+1;
		int startIndexNo = (pag - 1)* pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage % blockSize) ==0 ? (totPage / blockSize)-1 : (totPage / blockSize);
		
		vo.setPag(pag);
		vo.setPageSize(pageSize);
		vo.setTotRecCnt(totRecCnt);
		vo.setTotPage(totPage);
		vo.setStartIndexNo(startIndexNo);
		vo.setCurScrStartNo(curScrStartNo);
		vo.setBlockSize(blockSize);
		vo.setCurBlock(curBlock);
		vo.setLastBlock(lastBlock);
		return vo;
	}

	public PageVO getWishPage(int sIdx, int pag, int pageSize) {
		PageVO vo = new PageVO();
		
		int totRecCnt = 0;
		totRecCnt = memdao.getWishPage(sIdx);
		int totPage = (totRecCnt % pageSize)==0 ? totRecCnt / pageSize : (totRecCnt/pageSize)+1;
		int startIndexNo = (pag - 1)* pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage % blockSize) ==0 ? (totPage / blockSize)-1 : (totPage / blockSize);
		
		vo.setPag(pag);
		vo.setPageSize(pageSize);
		vo.setTotRecCnt(totRecCnt);
		vo.setTotPage(totPage);
		vo.setStartIndexNo(startIndexNo);
		vo.setCurScrStartNo(curScrStartNo);
		vo.setBlockSize(blockSize);
		vo.setCurBlock(curBlock);
		vo.setLastBlock(lastBlock);
		return vo;
	}
	public PageVO getDectot(int pag, int pageSize) {
		PageVO vo = new PageVO();
		
		int totRecCnt = 0;
		totRecCnt = adDao.getDectot();
		int totPage = (totRecCnt % pageSize)==0 ? totRecCnt / pageSize : (totRecCnt/pageSize)+1;
		int startIndexNo = (pag - 1)* pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage % blockSize) ==0 ? (totPage / blockSize)-1 : (totPage / blockSize);
		
		vo.setPag(pag);
		vo.setPageSize(pageSize);
		vo.setTotRecCnt(totRecCnt);
		vo.setTotPage(totPage);
		vo.setStartIndexNo(startIndexNo);
		vo.setCurScrStartNo(curScrStartNo);
		vo.setBlockSize(blockSize);
		vo.setCurBlock(curBlock);
		vo.setLastBlock(lastBlock);
		return vo;
	}
	public PageVO getPrdtot(int pag, int pageSize, String sort, String brand, String part, String subpart,
			String search) {
		PageVO vo = new PageVO();
		
		int totRecCnt = 0;
		totRecCnt = prdDao.AllprdRecCnt(sort,brand,part,subpart,search);
		int totPage = (totRecCnt % pageSize)==0 ? totRecCnt / pageSize : (totRecCnt/pageSize)+1;
		int startIndexNo = (pag - 1)* pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage % blockSize) ==0 ? (totPage / blockSize)-1 : (totPage / blockSize);
		
		vo.setPag(pag);
		vo.setPageSize(pageSize);
		vo.setTotRecCnt(totRecCnt);
		vo.setTotPage(totPage);
		vo.setStartIndexNo(startIndexNo);
		vo.setCurScrStartNo(curScrStartNo);
		vo.setBlockSize(blockSize);
		vo.setCurBlock(curBlock);
		vo.setLastBlock(lastBlock);
		return vo;
	}

	public PageVO getAdFeedAlltot(int pag, int pageSize) {
		PageVO vo = new PageVO();
		
		int totRecCnt = 0;
		totRecCnt = adDao.getAdFeedAlltot();
		int totPage = (totRecCnt % pageSize)==0 ? totRecCnt / pageSize : (totRecCnt/pageSize)+1;
		int startIndexNo = (pag - 1)* pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage % blockSize) ==0 ? (totPage / blockSize)-1 : (totPage / blockSize);
		
		vo.setPag(pag);
		vo.setPageSize(pageSize);
		vo.setTotRecCnt(totRecCnt);
		vo.setTotPage(totPage);
		vo.setStartIndexNo(startIndexNo);
		vo.setCurScrStartNo(curScrStartNo);
		vo.setBlockSize(blockSize);
		vo.setCurBlock(curBlock);
		vo.setLastBlock(lastBlock);
		return vo;
	}
	public PageVO getUserContentTot(int pag, int pageSize, int memIdx) {
		PageVO vo = new PageVO();
		
		int totRecCnt = 0;
		totRecCnt = memdao.getUserContentTot(memIdx);
		int totPage = (totRecCnt % pageSize)==0 ? totRecCnt / pageSize : (totRecCnt/pageSize)+1;
		int startIndexNo = (pag - 1)* pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage % blockSize) ==0 ? (totPage / blockSize)-1 : (totPage / blockSize);
		
		vo.setPag(pag);
		vo.setPageSize(pageSize);
		vo.setTotRecCnt(totRecCnt);
		vo.setTotPage(totPage);
		vo.setStartIndexNo(startIndexNo);
		vo.setCurScrStartNo(curScrStartNo);
		vo.setBlockSize(blockSize);
		vo.setCurBlock(curBlock);
		vo.setLastBlock(lastBlock);
		return vo;
	}
	public PageVO getMyDeclarationTot(int sIdx, int pag, int pageSize) {
		PageVO vo = new PageVO();
		
		int totRecCnt = 0;
		totRecCnt = memdao.getMyDeclarationTot(sIdx);
		int totPage = (totRecCnt % pageSize)==0 ? totRecCnt / pageSize : (totRecCnt/pageSize)+1;
		int startIndexNo = (pag - 1)* pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage % blockSize) ==0 ? (totPage / blockSize)-1 : (totPage / blockSize);
		
		vo.setPag(pag);
		vo.setPageSize(pageSize);
		vo.setTotRecCnt(totRecCnt);
		vo.setTotPage(totPage);
		vo.setStartIndexNo(startIndexNo);
		vo.setCurScrStartNo(curScrStartNo);
		vo.setBlockSize(blockSize);
		vo.setCurBlock(curBlock);
		vo.setLastBlock(lastBlock);
		return vo;
	}

	public PageVO getMyHistoryTot(int sIdx, int pag, int pageSize) {
		PageVO vo = new PageVO();
		
		int totRecCnt = 0;
		totRecCnt = memdao.getMyHistoryTot(sIdx);
		int totPage = (totRecCnt % pageSize)==0 ? totRecCnt / pageSize : (totRecCnt/pageSize)+1;
		int startIndexNo = (pag - 1)* pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage % blockSize) ==0 ? (totPage / blockSize)-1 : (totPage / blockSize);
		
		vo.setPag(pag);
		vo.setPageSize(pageSize);
		vo.setTotRecCnt(totRecCnt);
		vo.setTotPage(totPage);
		vo.setStartIndexNo(startIndexNo);
		vo.setCurScrStartNo(curScrStartNo);
		vo.setBlockSize(blockSize);
		vo.setCurBlock(curBlock);
		vo.setLastBlock(lastBlock);
		return vo;
	}
	
	public ArrayList<BoVO> getFeedAll(int startIndexNo, int pageSize) {
		return bodao.getFeedAll(startIndexNo,pageSize);
	}

	public ArrayList<BoVO> getfeedPapular(int startIndexNo, int pageSize) {
		return bodao.getfeedPapular(startIndexNo,pageSize);
	}

	public ArrayList<BoVO> getFeedFollow(int startIndexNo, int pageSize, int sIdx, String flag) {
		return bodao.getFeedFollow(startIndexNo,pageSize,sIdx,flag);
	}

	public ArrayList<BoVO> getFeedTagPapular(int startIndexNo, int pageSize, String tags) {
		return bodao.getFeedTagPapular(startIndexNo,pageSize,tags);
	}

	public ArrayList<BoVO> getFeedProduct(int startIndexNo, int pageSize, int prdIdx) {
		return bodao.getFeedProduct(startIndexNo,pageSize,prdIdx);
	}

	public ArrayList<ProductVO> getWishList(int startIndexNo, int pageSize, int sIdx) {
		return memdao.getWishList(startIndexNo,pageSize,sIdx);
	}

	public ArrayList<BoVO> getAdFeedAll(int startIndexNo, int pageSize) {
		return adDao.getAdFeedAll(startIndexNo,pageSize);
	}

	public ArrayList<BoVO> getMyDeclarationList(int startIndexNo, int pageSize, int sIdx) {
		return memdao.getMyDeclarationList(startIndexNo,pageSize,sIdx);
	}

	public ArrayList<MsgVO> getMyHistoryList(int startIndexNo, int pageSize, int sIdx) {
		return memdao.getMyHistoryList(startIndexNo,pageSize,sIdx);
	}


	

	


}
