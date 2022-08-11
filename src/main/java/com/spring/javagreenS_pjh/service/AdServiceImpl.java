package com.spring.javagreenS_pjh.service;



import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javagreenS_pjh.dao.AdDAO;
import com.spring.javagreenS_pjh.vo.BoVO;
import com.spring.javagreenS_pjh.vo.ChartVO;
import com.spring.javagreenS_pjh.vo.OrderVO;
import com.spring.javagreenS_pjh.vo.ProductVO;
import com.spring.javagreenS_pjh.vo.ReturnVO;


@Service
public class AdServiceImpl implements AdService {

	@Autowired
	AdDAO adDAO;

	@Override
	public void setBrandImage(MultipartHttpServletRequest brandImage, ProductVO vo) {
		try {
			List<MultipartFile> fileList = brandImage.getFiles("brandImage");
			
			
			for(MultipartFile file : fileList) {
				String oFileName = file.getOriginalFilename();
				String sFileName = saveFileName(oFileName);
				
				writeFile(file,sFileName,"brand");
				
				vo.setBrfName(sFileName);
				
			}
			adDAO.setBrandImage(vo);
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}

	private void writeFile(MultipartFile file, String sFileName, String flag)throws IOException {
		byte[] data = file.getBytes();
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		
		String uploadPath = "";
		if(flag.equals("brand")) {
			uploadPath = request.getSession().getServletContext().getRealPath("/resources/admin/brand/");						
		}
		else if(flag.equals("product")){
			uploadPath = request.getSession().getServletContext().getRealPath("/resources/admin/product/");
		}
		
		FileOutputStream fos = new FileOutputStream(uploadPath + sFileName);
		fos.write(data);
		fos.close();
		
	}

	private String saveFileName(String oFileName) {
		String fileName = "";
		
		Calendar cal = Calendar.getInstance();
		fileName += cal.get(Calendar.YEAR);
		fileName += cal.get(Calendar.MONTH);
		fileName += cal.get(Calendar.DATE);
		fileName += cal.get(Calendar.HOUR);
		fileName += cal.get(Calendar.MINUTE);
		fileName += cal.get(Calendar.SECOND);
		fileName += cal.get(Calendar.MILLISECOND);
		
		fileName += "_" + oFileName;
		
		return fileName;
	}

	@Override
	public ArrayList<ProductVO> getBrandList() {
		ArrayList<ProductVO> brvo = adDAO.getBrandList();
		return brvo;
	}

	@Override
	public void setCategory(String category) {
		adDAO.setCategory(category);
	}

	@Override
	public ProductVO getCategory(String category) {
		ProductVO vo = adDAO.getCategory(category);
		return vo;
	}

	@Override
	public ArrayList<ProductVO> getCategoryList() {
		return adDAO.getCategoryList();
	}

	@Override
	public ProductVO getSubCategory(String subCategory) {
		return adDAO.getSubCategory(subCategory);
	}

	@Override
	public void setSubCategory(String category, String subCategory) {
		adDAO.setSubCategory(category,subCategory);
		
	}

	@Override
	public ArrayList<ProductVO> getSubCategories(String category) {
		return adDAO.getSubCategories(category);
	}

	@Override
	public ArrayList<ProductVO> getBrandCategory(String brand) {
		
		return adDAO.getBrandCategory(brand);
	}

	@Override
	public ArrayList<ProductVO> getBCSubCategory(String brand, String category) {
		return adDAO.getBCSubCategory(brand,category);
	}

	@Override
	public ArrayList<ProductVO> getBCSProduct(String brand, String category, String subCategory) {
		return adDAO.getBCSProduct(brand,category,subCategory);
	}

	@Override
	public ProductVO getUseOption(int prdIdx, String size) {
		return adDAO.getUseOption(prdIdx,size);
	}

	@Override
	public void setOptionInput(int prdIdx, String size, int count, int indexCount) {
		adDAO.setOptionInput(prdIdx, size, count, indexCount);
		
	}

	@Override
	public ProductVO getOption(int prdIdx) {
		return adDAO.getOption(prdIdx);
	}

	@Override
	public void setPrdSell(int prdIdx) {
		adDAO.setPrdSell(prdIdx);
	}

	@Override
	public void setPrdSellStop(int prdIdx) {
		adDAO.setPrdSellStop(prdIdx);
	}

	@Override
	public ArrayList<ProductVO> getPrdInfor(int prdIdx) {
		return adDAO.getPrdInfor(prdIdx);
	}

	@Override
	public ArrayList<ProductVO> getProductInfor(int prdIdx) {
		return adDAO.getProductInfor(prdIdx);
	}

	@Override
	public ProductVO getProductVo(int prdIdx) {
		return adDAO.getProductVo(prdIdx);
	}

	@Override
	public void imgDelete(String prdContent,String flag, int position) {
		//		  		      1 		    2		      3			    4		      5         6         7	 
		//      0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
		// <img src="/javagreenS_pjh/data/ckeditor/temp/220622152314_profile5.jpg" style="height:543px; width:563px" />
		//
		if(prdContent.indexOf("src=\"/") == -1) return;
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		
		String uploadPath =  request.getSession().getServletContext().getRealPath(flag);			
		
		
		String nextImg =  prdContent.substring(prdContent.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile =  nextImg.substring(0, nextImg.indexOf("\""));
			
			String oriFilePath = uploadPath + imgFile;
			
			
			fileDelete(oriFilePath);
			if(nextImg.indexOf("src=\"/") == -1) {
				sw = false;
			}
			else {
				nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
			}
			
		}
		
	}
	
	private void fileDelete(String oriFilePath) {
		File delFile = new File(oriFilePath);
		delFile.delete();
		if(delFile.exists()) delFile.delete();
	}

	@Override
	public void setPrdfNameDelete(ProductVO vo) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/admin/product/");
		
		String fName = vo.getPrdfName();
		String realPathFile = realPath + fName;
		new File(realPathFile).delete();
	}
	
	@Override
	public void setbrfNameDelete(ProductVO orivo) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/admin/brand/");
		
		String fName = orivo.getBrfName();
		String realPathFile = realPath + fName;
		new File(realPathFile).delete();
	}
	
	@Override
	public void setProductImage(MultipartHttpServletRequest productImage, ProductVO vo) {
		try {
			List<MultipartFile> fileList = productImage.getFiles("productImage");
			
			
			for(MultipartFile file : fileList) {
				String oFileName = file.getOriginalFilename();
				String sFileName = saveFileName(oFileName);
				
				writeFile(file,sFileName,"product");
				
				vo.setPrdfName(sFileName);
				
			}
			adDAO.setproductImage(vo);
			
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	@Override
	public void setProductImageUpdate(MultipartHttpServletRequest productImage, ProductVO vo) {
		try {
			List<MultipartFile> fileList = productImage.getFiles("productImage");
			
			
			for(MultipartFile file : fileList) {
				String oFileName = file.getOriginalFilename();
				String sFileName = saveFileName(oFileName);
				
				writeFile(file,sFileName,"product");
				
				vo.setPrdfName(sFileName);
				
			}
			adDAO.setProductImageUpdate(vo);
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	@Override
	public void setBrandImageUpdate(MultipartHttpServletRequest brandImage, ProductVO vo) {
		try {
			List<MultipartFile> fileList = brandImage.getFiles("brandImage");
			
			
			for(MultipartFile file : fileList) {
				String oFileName = file.getOriginalFilename();
				String sFileName = saveFileName(oFileName);
				
				writeFile(file,sFileName,"brand");
				
				vo.setBrfName(sFileName);
				
			}
			adDAO.setBrandImgUpdate(vo);
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	@Override
	public void setProductUpdate(ProductVO vo) {
		adDAO.setProductUpdate(vo);
	}

	@Override
	public ArrayList<OrderVO> getOrderInfo(int orderIdx) {
		return adDAO.getOrderInfo(orderIdx);
	}

	@Override
	public void updateOrderVal(int orderIdx, int val) {
		adDAO.updateOrderVal(orderIdx,val);
	}

	@Override
	public ArrayList<ReturnVO> getReturnCheck() {
		return adDAO.getReturnCheck();
	}

	@Override
	public int getOrderCnt() {
		return adDAO.getOrderCnt();
	}

	@Override
	public int getReturnCnt() {
		return adDAO.getReturnCnt();
	}

	@Override
	public ArrayList<ReturnVO> getReturnInfo(int reIdx) {
		return adDAO.getReturnInfo(reIdx);
	}

	@Override
	public void setReturnUpdate(int orderIdx, int pay_price, int pay_setPoint) {
		adDAO.setReturnUpdate(orderIdx,pay_price,pay_setPoint);
	}

	@Override
	public void setReturnsubUpdate(int order_subIdx, int order_prdCount, int order_prdPoint) {
		adDAO.setReturnsubUpdate(order_subIdx,order_prdCount,order_prdPoint);
	}

	@Override
	public void deleteSubOrder(int order_subIdx) {
		adDAO.deleteSubOrder(order_subIdx);
	}

	@Override
	public void deleteOrder(int orderIdx) {
		adDAO.deleteOrder(orderIdx);
	}

	@Override
	public void updateIndexcnt(int orderIdx,int cnt) {
		adDAO.updateIndexcnt(orderIdx,cnt);
	}

	@Override
	public void updateReturnOk(int resubIdx) {
		adDAO.updateReturnOk(resubIdx);
	}

	@Override
	public void setProductreCnt(int order_prdIdx, int order_prdCount,String order_prdoption) {
		adDAO.setProductreCnt(order_prdIdx,order_prdCount,order_prdoption);
	}

	@Override
	public ArrayList<OrderVO> getOrdery(int orderIdx) {
		return adDAO.getOrdery(orderIdx);
	}

	@Override
	public void setProductDelete(int prdIdx) {
		adDAO.setProductDelete(prdIdx);
	}

	@Override
	public ProductVO getBrandInfo(int brIdx) {
		return adDAO.getBrandInfo(brIdx);
	}

	@Override
	public void setBrandUpdate(ProductVO vo) {
		adDAO.setBrandUpdate(vo);
	}

	@Override
	public int getBrandPrdCnt(int brIdx) {
		return adDAO.getBrandPrdCnt(brIdx);
	}

	@Override
	public void setBrandDelete(int brIdx) {
		adDAO.setBrandDelete(brIdx);
	}

	@Override
	public ArrayList<ProductVO> getSubCategoryList() {
		return adDAO.getSubCategoryList();
	}

	@Override
	public void setCateUpdate(int idx, String category) {
		adDAO.setCateUpdate(idx,category);
	}

	@Override
	public void setSubCateUpdate(int idx, String subCategory) {
		adDAO.setSubCateUpdate(idx,subCategory);
	}

	@Override
	public ProductVO cateDeleteCheck(int idx) {
		return adDAO.cateDeleteCheck(idx);
	}

	@Override
	public void cateDelete(int idx) {
		adDAO.cateDelete(idx);
	}

	@Override
	public ProductVO subCateDeleteCheck(int idx) {
		return adDAO.subCateDeleteCheck(idx);
	}

	@Override
	public void subCateDelete(int idx) {
		adDAO.subCateDelete(idx);
	}

	@Override
	public void updateOrderLastDate(int orderIdx) {
		Calendar cal = Calendar.getInstance();
    cal.setTime(new Date());
    DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
    cal.add(Calendar.DATE, 7);
    String lastdate = df.format(cal.getTime());
    
		adDAO.updateOrderLastDate(orderIdx,lastdate);
	}

	@Override
	public OrderVO getOrderSub(int orderIdx) {
		return adDAO.getOrderSub(orderIdx);
	}

	@Override
	public void setMempoint(int order_memIdx, int order_prdPoint) {
		adDAO.setMempoint(order_memIdx,order_prdPoint);
	}

	@Override
	public List<ChartVO> getOrderChartTotal() {
		List<ChartVO> list = new ArrayList<ChartVO>();
		Calendar cal = Calendar.getInstance();
		int nowMonth = cal.get(Calendar.MONTH);
		int nowYear = cal.get(Calendar.YEAR);
		int nowday = cal.get(Calendar.DATE);
		for(int i=0; i<=nowMonth; i++) {
			ChartVO vo = getDate(nowYear,i,nowday);
			ChartVO cvo = adDAO.getOrderChartTotal(vo.getStart(),vo.getEnd());
			if(cvo != null) {
				cvo.setMonth((i+1)+"월");
				list.add(cvo);
			}
		}
		
		return list;
	}
	private ChartVO getDate(int nowYear, int nowMonth, int nowday) {
		ChartVO vo = new ChartVO();
		String start = "";
		String end = "";
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

    Calendar cal = Calendar.getInstance();
    
    cal.set(nowYear, nowMonth , cal.getMinimum(Calendar.DAY_OF_MONTH));
    start = dateFormat.format(cal.getTime());
    vo.setStart(start);
    
    
    cal.set(nowYear, nowMonth , cal.getActualMaximum(Calendar.DAY_OF_MONTH));
    end = dateFormat.format(cal.getTime());
    vo.setEnd(end);
    
		return vo;
	}
	@Override
	public ArrayList<BoVO> getDelcList(int startIndexNo, int pageSize) {
		return adDAO.getDelcList(startIndexNo,pageSize);
	}

	@Override
	public BoVO getDeclContent(int d_Idx) {
		return adDAO.getDeclContent(d_Idx);
	}

	@Override
	public void setDecComent(BoVO vo) {
		adDAO.setDecComent(vo);
	}

	@Override
	public BoVO getAdUserContent(int boIdx) throws Exception {
		BoVO vo = adDAO.getAdUserContent(boIdx);
		String strtime = getTime(vo.getBo_date());
		vo.setStrtime(strtime);
		return vo;
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

	@Override
	public void setFeedBline(int boIdx) {
		adDAO.setFeedBline(boIdx);
	}

	@Override
	public void setFeedDel(int boIdx) {
		adDAO.setFeedDel(boIdx);
	}

	@Override
	public List<ChartVO> getBrandTop() {
		return adDAO.getBrandTop();
	}

}
