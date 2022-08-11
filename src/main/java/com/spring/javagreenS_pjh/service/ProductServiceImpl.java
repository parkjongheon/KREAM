package com.spring.javagreenS_pjh.service;

import java.text.DecimalFormat;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javagreenS_pjh.dao.ProductDAO;
import com.spring.javagreenS_pjh.vo.OrderVO;
import com.spring.javagreenS_pjh.vo.ProductVO;

@Service
public class ProductServiceImpl implements ProductService {
	
	@Autowired
	ProductDAO prdDAO;

	@Override
	public ArrayList<ProductVO> getBrand() {
		return prdDAO.getBrand();
	}

	@Override
	public ArrayList<ProductVO> getCategory() {
		return prdDAO.getCategory();
	}

	@Override
	public ArrayList<ProductVO> getSubCategory(String idx) {
		return prdDAO.getSubCategory(idx);
	}

	@Override
	public ArrayList<ProductVO> getProduct(int startIndexNum, int pageSize, String sort, String brand, String part,
			String subpart, String search) {
		DecimalFormat fmt = new DecimalFormat("###,###");
		ArrayList<ProductVO> vos = prdDAO.getProduct(startIndexNum,pageSize,sort,brand,part,subpart,search);
		for(int i = 0; i < vos.size(); i++) {
			vos.get(i).setFormatPrice(fmt.format(vos.get(i).getSPrice()));
		}
				
		return vos;
	}

	@Override
	public ProductVO GetProductInfo(int prdIdx) {
		DecimalFormat fmt = new DecimalFormat("###,###");
		ProductVO vo = prdDAO.GetProductInfo(prdIdx);
		vo.setFormatPrice(fmt.format(vo.getSPrice()));
		
		return vo;
	}

	@Override
	public ArrayList<ProductVO> getProductOption(int prdIdx) {
		return prdDAO.getProductOption(prdIdx);
	}

	@Override
	public void setCart(int memIdx, int prdIdx, String size, int count) {
		prdDAO.setCart(memIdx,prdIdx,size,count);
	}

	@Override
	public ProductVO getSelectCart(int memIdx, int prdIdx, String size, int count) {
		return prdDAO.getSelectCart(memIdx,prdIdx,size,count);
	}

	@Override
	public void setUpdateCart(int memIdx, int prdIdx, String size, int count) {
		prdDAO.setUpdateCart(memIdx,prdIdx,size,count);
		
	}

	@Override
	public ArrayList<ProductVO> getCartList(int memIdx) {
		return prdDAO.getCartList(memIdx);
	}

	@Override
	public void deleteCart(int idx) {
		prdDAO.deleteCart(idx);
		
	}

	@Override
	public void setOptionCountUp(int idx) {
		prdDAO.setOptionCountUp(idx);
		
	}

	@Override
	public void setOptionCountDown(int idx) {
		prdDAO.setOptionCountDown(idx);
		
	}

	@Override
	public void setOrder(OrderVO vo) {
		prdDAO.setOrder(vo);
		
	}

	@Override
	public int getOrderIdx(int memIdx) {
		return prdDAO.getOrderIdx(memIdx);
	}

	@Override
	public void setOrderSub(int orderIdx,int memIdx, int prdIdx, int prdCount, int prdPrice, String prdOption, int prdTotalPoint) {
		prdDAO.setOrderSub(orderIdx,memIdx,prdIdx,prdCount,prdPrice,prdOption,prdTotalPoint);
		
	}

	@Override
	public void setUsePoint(int memIdx, int setPoint) {
		prdDAO.setUsePoint(memIdx,setPoint);
		
	}

	@Override
	public void setOrderProductCount(int prdIdx, int prdCount, String prdOption) {
		prdDAO.setOrderProductCount(prdIdx,prdCount,prdOption);
		
	}

	@Override
	public int getOptionCount(int prdIdx, String prdOption) {
		return prdDAO.getOptionCount(prdIdx,prdOption);
	}

	@Override
	public void OrderSetdeleteCart(int memIdx, int prdIdx, String prdOption) {
		prdDAO.OrderSetdeleteCart(memIdx,prdIdx,prdOption);
	}

	@Override
	public ArrayList<ProductVO> getWishList(int sIdx) {
		return prdDAO.getWishList(sIdx);
	}

	@Override
	public void wishUpPost(int memIdx, int prdIdx) {
		prdDAO.wishUpPost(memIdx, prdIdx);
	}

	@Override
	public void prdWishUpPost(int prdIdx) {
		prdDAO.prdWishUpPost(prdIdx);
	}

	@Override
	public void wishDownPost(int memIdx, int prdIdx) {
		prdDAO.wishDownPost(memIdx,prdIdx);
	}

	@Override
	public void prdWishDownPost(int prdIdx) {
		prdDAO.prdWishDownPost(prdIdx);
		
	}

	@Override
	public ArrayList<ProductVO> getPrdBrandList(String ebrName,int prdIdx) {
		DecimalFormat fmt = new DecimalFormat("###,###");
		ArrayList<ProductVO> brvos = prdDAO.getPrdBrandList(ebrName,prdIdx);
		for(int i = 0; i < brvos.size(); i++) {
			brvos.get(i).setFormatPrice(fmt.format(brvos.get(i).getSPrice()));
		}
		
		return brvos;
	}

	@Override
	public ArrayList<ProductVO> getBestProductList() {
		DecimalFormat fmt = new DecimalFormat("###,###");
		ArrayList<ProductVO> vos = prdDAO.getBestProductList();
		for(int i = 0; i < vos.size(); i++) {
			vos.get(i).setFormatPrice(fmt.format(vos.get(i).getSPrice()));
		}
		return vos;
	}

	@Override
	public ArrayList<ProductVO> getNewProductList() {
		DecimalFormat fmt = new DecimalFormat("###,###");
		ArrayList<ProductVO> vos = prdDAO.getNewProductList();
		for(int i = 0; i < vos.size(); i++) {
			vos.get(i).setFormatPrice(fmt.format(vos.get(i).getSPrice()));
		}
		return vos;
	}

	@Override
	public void setOptionChange(int opIdx, int count) {
		prdDAO.setOptionChange(opIdx,count);
	}

}
