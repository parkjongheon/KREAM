package com.spring.javagreenS_pjh.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javagreenS_pjh.vo.BoVO;
import com.spring.javagreenS_pjh.vo.ChartVO;
import com.spring.javagreenS_pjh.vo.LogVO;
import com.spring.javagreenS_pjh.vo.OrderVO;
import com.spring.javagreenS_pjh.vo.ProductVO;
import com.spring.javagreenS_pjh.vo.ReturnVO;

public interface AdDAO {

	public ArrayList<LogVO> getMemberList(@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize,@Param("sort") String sort);

	public int totRecCnt();

	public void setBrandImage(@Param("vo") ProductVO vo);

	public ArrayList<ProductVO> getBrandList();

	public ProductVO getCategory(@Param("category") String category);

	public void setCategory(@Param("category") String category);

	public ArrayList<ProductVO> getCategoryList();

	public ProductVO getSubCategory(@Param("subCategory") String subCategory);

	public void setSubCategory(@Param("category") String category, @Param("subCategory") String subCategory);

	public ArrayList<ProductVO> getSubCategories(@Param("category") String category);

	public void setproductImage(@Param("vo") ProductVO vo);

	public ArrayList<ProductVO> getBrandCategory(@Param("brand") String brand);

	public ArrayList<ProductVO> getBCSubCategory(@Param("brand") String brand,@Param("category") String category);

	public ArrayList<ProductVO> getBCSProduct(@Param("brand") String brand,@Param("category") String category,@Param("subCategory") String subCategory);

	public ProductVO getUseOption(@Param("prdIdx") int prdIdx,@Param("size") String size);

	public void setOptionInput(@Param("prdIdx") int prdIdx,@Param("size") String size,@Param("prdCount") int count,@Param("indexNum") int indexCount);

	public int prdRecCnt();

	public ArrayList<ProductVO> getProductList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("sort") String sort);

	public ProductVO getOption(@Param("prdIdx") int prdIdx);

	public void setPrdSell(@Param("prdIdx") int prdIdx);

	public void setPrdSellStop(@Param("prdIdx") int prdIdx);

	public ArrayList<ProductVO> getPrdInfor(@Param("prdIdx") int prdIdx);

	public ArrayList<ProductVO> getProductInfor(@Param("prdIdx") int prdIdx);

	public ProductVO getProductVo(@Param("prdIdx") int prdIdx);

	public void setProductImageUpdate(@Param("vo") ProductVO vo);

	public void setProductUpdate(@Param("vo") ProductVO vo);

	public int productRecCnt(@Param("part") String part,@Param("subpart") String subpart,@Param("searchString") String searchString);

	public int OrdertotRecCnt();

	public ArrayList<OrderVO> getOrderList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("sort") String sort,@Param("date") String date,@Param("orderDate") int orderDate,@Param("part") String part,@Param("search") String search,@Param("start")String start,@Param("end")String end,@Param("val") int val);

	public int OrdertotRecCnt(@Param("part") String part,@Param("orderDate") int orderDate,@Param("searchString") String searchString,@Param("start")String start,@Param("end")String end);

	public ArrayList<OrderVO> getOrderInfo(@Param("orderIdx") int orderIdx);

	public int adOrdertotRecCnt(@Param("orderDate") int orderDate,@Param("date") String date,@Param("search") String search,@Param("part")String part,@Param("start") String start,@Param("end") String end,@Param("val") int val);

	public void updateOrderVal(@Param("orderIdx") int orderIdx,@Param("val") int val);

	public ArrayList<ReturnVO> getReturnCheck();

	public int getOrderCnt();

	public int getReturnCnt();

	public int adReturntotRecCnt(@Param("orderDate") int orderDate,@Param("date") String date,@Param("search") String search,@Param("part")String part,@Param("start") String start,@Param("end") String end,@Param("val") int val);

	public ArrayList<ReturnVO> getReturnList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("sort") String sort,@Param("date") String date,@Param("orderDate") int orderDate,@Param("part") String part,@Param("search") String search,@Param("start")String start,@Param("end")String end,@Param("val") int val);

	public ArrayList<ReturnVO> getReturnInfo(@Param("reIdx") int reIdx);

	public void setReturnUpdate(@Param("orderIdx") int orderIdx,@Param("pay_price") int pay_price,@Param("pay_setPoint") int pay_setPoint);

	public void setReturnsubUpdate(@Param("order_subIdx") int order_subIdx,@Param("order_prdCount") int order_prdCount,@Param("order_prdPoint") int order_prdPoint);

	public void deleteSubOrder(@Param("order_subIdx") int order_subIdx);

	public void deleteOrder(@Param("orderIdx") int orderIdx);

	public void updateIndexcnt(@Param("orderIdx") int orderIdx,@Param("cnt") int cnt);

	public void updateReturnOk(@Param("resubIdx") int resubIdx);

	public void setProductreCnt(@Param("order_prdIdx") int order_prdIdx,@Param("order_prdCount") int order_prdCount,@Param("order_prdoption") String order_prdoption);

	public ArrayList<OrderVO> getOrdery(@Param("orderIdx") int orderIdx);

	public void setProductDelete(@Param("prdIdx") int prdIdx);

	public ProductVO getBrandInfo(@Param("brIdx") int brIdx);

	public void setBrandImgUpdate(@Param("vo")ProductVO vo);

	public void setBrandUpdate(@Param("vo") ProductVO vo);

	public int getBrandPrdCnt(@Param("brIdx") int brIdx);

	public void setBrandDelete(@Param("brIdx") int brIdx);

	public ArrayList<ProductVO> getSubCategoryList();

	public void setCateUpdate(@Param("idx") int idx,@Param("category") String category);

	public void setSubCateUpdate(@Param("idx") int idx,@Param("subCategory") String subCategory);

	public ProductVO cateDeleteCheck(@Param("idx") int idx);

	public void cateDelete(@Param("idx") int idx);

	public ProductVO subCateDeleteCheck(@Param("idx") int idx);

	public void subCateDelete(@Param("idx") int idx);

	public void updateOrderLastDate(@Param("orderIdx") int orderIdx,@Param("lastdate") String lastdate);

	public OrderVO getOrderSub(@Param("orderIdx") int orderIdx);

	public void setMempoint(@Param("order_memIdx") int order_memIdx,@Param("order_prdPoint") int order_prdPoint);

	public ChartVO getOrderChartTotal(@Param("start") String start,@Param("end") String end);

	public int getDectot();

	public ArrayList<BoVO> getDelcList(@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize);

	public BoVO getDeclContent(@Param("d_Idx") int d_Idx);

	public void setDecComent(@Param("vo") BoVO vo);

	public int getAdFeedAlltot();

	public ArrayList<BoVO> getAdFeedAll(@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize);

	public BoVO getAdUserContent(@Param("boIdx") int boIdx);

	public void setFeedBline(@Param("boIdx") int boIdx);

	public void setFeedDel(@Param("boIdx") int boIdx);

	public List<ChartVO> getBrandTop();



	







	
}
