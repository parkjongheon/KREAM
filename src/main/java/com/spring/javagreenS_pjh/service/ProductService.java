package com.spring.javagreenS_pjh.service;

import java.util.ArrayList;

import com.spring.javagreenS_pjh.vo.OrderVO;
import com.spring.javagreenS_pjh.vo.ProductVO;

public interface ProductService {

	public ArrayList<ProductVO> getProduct(int startIndexNum, int pageSize, String sort, String brand, String part, String subpart, String search);

	public ArrayList<ProductVO> getBrand();

	public ArrayList<ProductVO> getCategory();

	public ArrayList<ProductVO> getSubCategory(String idx);

	public ProductVO GetProductInfo(int prdIdx);

	public ArrayList<ProductVO> getProductOption(int prdIdx);

	public void setCart(int memIdx, int prdIdx, String size, int count);

	public ProductVO getSelectCart(int memIdx, int prdIdx, String size, int count);

	public void setUpdateCart(int memIdx, int prdIdx, String size, int count);

	public ArrayList<ProductVO> getCartList(int memIdx);

	public void deleteCart(int idx);

	public void setOptionCountUp(int idx);

	public void setOptionCountDown(int idx);

	public void setOrder(OrderVO vo);

	public int getOrderIdx(int memIdx);

	public void setOrderSub(int orderIdx,int memIdx, int prdIdx, int prdCount, int prdPrice, String prdOption, int prdTotalPoint);

	public void setUsePoint(int memIdx, int setPoint);

	public void setOrderProductCount(int prdIdx, int prdCount, String prdOption);

	public int getOptionCount(int prdIdx, String prdOption);

	public void OrderSetdeleteCart(int memIdx, int prdIdx, String prdOption);

	public ArrayList<ProductVO> getWishList(int sIdx);

	public void wishUpPost(int memIdx, int prdIdx);

	public void prdWishUpPost(int prdIdx);

	public void wishDownPost(int memIdx, int prdIdx);

	public void prdWishDownPost(int prdIdx);

	public ArrayList<ProductVO> getPrdBrandList(String ebrName,int prdIdx);

	public ArrayList<ProductVO> getBestProductList();

	public ArrayList<ProductVO> getNewProductList();

	public void setOptionChange(int opIdx, int count);


}
