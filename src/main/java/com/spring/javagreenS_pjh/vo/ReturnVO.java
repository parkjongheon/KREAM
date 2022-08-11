package com.spring.javagreenS_pjh.vo;

import lombok.Data;

public @Data class ReturnVO {
	private int reIdx;
	private int prd_Idx;
	private int mem_Idx;
	private int order_Idx;
	private int sub_Idx;
	private String return_marchantId;
	private int return_totalprice;
	private String return_option;
	private int return_count;
	private int return_point;
	private String return_date;
	private String return_type;
	private String return_content;
	private String return_status;
	private int return_val;
	private int return_indexcnt;
	
	private int resubIdx;
	private int resub_reIdx;
	private int resub_subIdx;
	private int resub_prdIdx;
	private int resub_price;
	private int resub_count;
	private int resub_delPoint;
	private String resub_option;
	
	private String[] order_prdIdx;
	private String[] order_subIdx;
	private String[] order_prdCount;
	private String[] order_prdPrice;
	private String[] order_prdOption;
	
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
	private int totalPrice;
	private int setPoint;
	
	private int memIdx;
	private String mid;
	private String name;
}
