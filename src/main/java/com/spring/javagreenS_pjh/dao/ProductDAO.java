package com.spring.javagreenS_pjh.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javagreenS_pjh.vo.OrderVO;
import com.spring.javagreenS_pjh.vo.ProductVO;

public interface ProductDAO {

	public ArrayList<ProductVO> getProduct(@Param("startIndexNum") int startIndexNum,@Param("pageSize") int pageSize,@Param("sort") String sort,@Param("brand") String brand,@Param("part") String part,@Param("subpart") String subpart,@Param("search") String search);

	public ArrayList<ProductVO> getBrand();

	public ArrayList<ProductVO> getCategory();

	public ArrayList<ProductVO> getSubCategory(@Param("idx") String idx);

	public ProductVO GetProductInfo(@Param("prdIdx") int prdIdx);

	public ArrayList<ProductVO> getProductOption(@Param("prdIdx") int prdIdx);

	public void setCart(@Param("memIdx") int memIdx,@Param("prdIdx") int prdIdx,@Param("size") String size,@Param("count") int count);

	public ProductVO getSelectCart(@Param("memIdx") int memIdx,@Param("prdIdx") int prdIdx,@Param("size") String size,@Param("count") int count);

	public void setUpdateCart(@Param("memIdx") int memIdx,@Param("prdIdx") int prdIdx,@Param("size") String size,@Param("count") int count);

	public ArrayList<ProductVO> getCartList(@Param("memIdx") int memIdx);

	public void deleteCart(@Param("idx") int idx);

	public void setOptionCountUp(@Param("idx") int idx);

	public void setOptionCountDown(@Param("idx") int idx);

	public void setOrder(@Param("vo") OrderVO vo);

	public int getOrderIdx(@Param("memIdx") int memIdx);

	public void setOrderSub(@Param("orderIdx") int orderIdx,@Param("memIdx") int memIdx,@Param("prdIdx") int prdIdx,@Param("prdCount") int prdCount,@Param("prdPrice") int prdPrice,@Param("prdOption") String prdOption,@Param("prdTotalPoint") int prdTotalPoint);

	public void setUsePoint(@Param("memIdx") int memIdx,@Param("setPoint") int setPoint);

	public void setOrderProductCount(@Param("prdIdx") int prdIdx,@Param("prdCount") int prdCount,@Param("prdOption") String prdOption);

	public int getOptionCount(@Param("prdIdx") int prdIdx,@Param("prdOption") String prdOption);

	public void OrderSetdeleteCart(@Param("memIdx") int memIdx,@Param("prdIdx") int prdIdx,@Param("prdOption") String prdOption);

	public ArrayList<ProductVO> getWishList(@Param("sIdx")int sIdx);

	public void wishUpPost(@Param("memIdx") int memIdx,@Param("prdIdx") int prdIdx);

	public void prdWishUpPost(@Param("prdIdx") int prdIdx);

	public void wishDownPost(@Param("memIdx") int memIdx,@Param("prdIdx") int prdIdx);

	public void prdWishDownPost(@Param("prdIdx") int prdIdx);

	public ArrayList<ProductVO> getPrdBrandList(@Param("ebrName") String ebrName,@Param("prdIdx") int prdIdx);

	public ArrayList<ProductVO> getBestProductList();

	public int AllprdRecCnt(@Param("sort") String sort,@Param("brand") String brand,@Param("part") String part,@Param("subpart") String subpart,@Param("search") String search);

	public ArrayList<ProductVO> getNewProductList();

	public void setOptionChange(@Param("opIdx") int opIdx,@Param("count") int count);

	
}
