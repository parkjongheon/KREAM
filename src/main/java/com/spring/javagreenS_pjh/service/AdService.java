package com.spring.javagreenS_pjh.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javagreenS_pjh.vo.BoVO;
import com.spring.javagreenS_pjh.vo.ChartVO;
import com.spring.javagreenS_pjh.vo.OrderVO;
import com.spring.javagreenS_pjh.vo.ProductVO;
import com.spring.javagreenS_pjh.vo.ReturnVO;

public interface AdService {

	public void setBrandImage(MultipartHttpServletRequest brandImage, ProductVO vo);

	public ArrayList<ProductVO> getBrandList();

	public void setCategory(String category);

	public ProductVO getCategory(String category);

	public ArrayList<ProductVO> getCategoryList();

	public ProductVO getSubCategory(String subCategory);

	public void setSubCategory(String category, String subCategory);

	public ArrayList<ProductVO> getSubCategories(String category);

	public void setProductImage(MultipartHttpServletRequest productImage, ProductVO vo);

	public ArrayList<ProductVO> getBrandCategory(String brand);

	public ArrayList<ProductVO> getBCSubCategory(String brand, String category);

	public ArrayList<ProductVO> getBCSProduct(String brand, String category, String subCategory);

	public ProductVO getUseOption(int prdIdx, String size);

	public void setOptionInput(int prdIdx, String size, int count, int indexCount);

	public ProductVO getOption(int prdIdx);

	public void setPrdSell(int prdIdx);

	public void setPrdSellStop(int prdIdx);

	public ArrayList<ProductVO> getPrdInfor(int prdIdx);

	public ArrayList<ProductVO> getProductInfor(int prdIdx);

	public ProductVO getProductVo(int idx);

	public void imgDelete(String prdContent, String string, int position);

	public void setPrdfNameDelete(ProductVO vo);

	public void setProductImageUpdate(MultipartHttpServletRequest productImage, ProductVO vo);

	public void setProductUpdate(ProductVO vo);

	public ArrayList<OrderVO> getOrderInfo(int orderIdx);

	public void updateOrderVal(int orderIdx, int val);

	public ArrayList<ReturnVO> getReturnCheck();

	public int getOrderCnt();

	public int getReturnCnt();

	public ArrayList<ReturnVO> getReturnInfo(int reIdx);

	public void setReturnUpdate(int orderIdx, int pay_price, int pay_setPoint);

	public void setReturnsubUpdate(int order_subIdx, int order_prdCount, int order_prdPoint);

	public void deleteSubOrder(int order_subIdx);

	public void deleteOrder(int orderIdx);

	public void updateIndexcnt(int orderIdx, int cnt);

	public void updateReturnOk(int resubIdx);

	public void setProductreCnt(int order_prdIdx, int order_prdCount,String order_prdoption);

	public ArrayList<OrderVO> getOrdery(int orderIdx);

	public void setProductDelete(int prdIdx);

	public ProductVO getBrandInfo(int brIdx);

	public void setbrfNameDelete(ProductVO orivo);

	public void setBrandImageUpdate(MultipartHttpServletRequest brandImage, ProductVO vo);

	public void setBrandUpdate(ProductVO vo);

	public int getBrandPrdCnt(int brIdx);

	public void setBrandDelete(int brIdx);

	public ArrayList<ProductVO> getSubCategoryList();

	public void setCateUpdate(int idx, String category);

	public void setSubCateUpdate(int idx, String subCategory);

	public ProductVO cateDeleteCheck(int idx);

	public void cateDelete(int idx);

	public ProductVO subCateDeleteCheck(int idx);

	public void subCateDelete(int idx);

	public void updateOrderLastDate(int orderIdx);

	public OrderVO getOrderSub(int orderIdx);

	public void setMempoint(int order_memIdx, int order_prdPoint);

	public List<ChartVO> getOrderChartTotal();

	public ArrayList<BoVO> getDelcList(int startIndexNo, int pageSize);

	public BoVO getDeclContent(int d_Idx);

	public void setDecComent(BoVO vo);

	public BoVO getAdUserContent(int boIdx) throws Exception;

	public void setFeedBline(int boIdx);

	public void setFeedDel(int boIdx);

	public List<ChartVO> getBrandTop();

}
