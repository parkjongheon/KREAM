package com.spring.javagreenS_pjh.vo;

import lombok.Data;

public @Data class OrderVO {
	private int orderIdx;
	private int memIdx;
	private int pay_price;
	private String pay_getName;
	private String pay_getTel;
	private String pay_getPost;
	private String pay_getAddress;
	private String pay_getPostMsg;
	private String pay_orderDate;
	private String pay_marchantId;
	private String pay_setPoint;
	private String mid;
	private String name;
	
	private int order_memIdx;
	private int order_subIdx;
	private int order_prdIdx;
	private int order_prdCount;
	private int order_prdPrice;
	private int order_prdPoint;
	private int order_val;
	private String order_prdOption;
	private String order_lastdate;
	private int[] prdIdx;
	private int[] prdCount;
	private int[] prdPrice;
	private String[] prdOption;
	private int[] prdTotalPoint;
	
	private int totalPrice;
	private int setPoint;
	
	private int indexcnt;
	
	
	private String ebrName;
	private String eprdName;
	private String kprdName;
	private String prdNum;
	private String prdCategory;
	private String prdSubCategory;
	private String prdRdate;
	private int rPrice;
	private int sPrice;
	private String prdfName;
	private String prdContent;
	private int sellCount;
	private int sellStop;
	private int wishCount;
	private int prdSale;
	
	private String color;
	
	private String strTime;
	private long mindate;
}
