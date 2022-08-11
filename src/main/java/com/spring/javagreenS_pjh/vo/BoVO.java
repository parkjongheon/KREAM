package com.spring.javagreenS_pjh.vo;

import lombok.Data;

public @Data class BoVO {
	private int boIdx;
	private int bo_memIdx;
	private int bo_prdIdx;
	private String bo_fName;
	private String bo_content;
	private String bo_tag;
	private String bo_date;
	private int bo_likeCnt;
	private int bo_val;
	private String strtime;
	private int tagIdx;
	private String tagName;
	private int tagCnt;
	
	private int idx;
	private String mid;
	private String nickName;
	private String photo;
	private String content;
	private String userDel;
	
	private int reCnt;
	private int prdIdx;
	private String ebrName;
	private String kprdName;
	private String eprdName;
	private String prdfName;
	
	private int blIdx;
	private int bl_memIdx;
	private int bl_boardIdx;
	
	private int d_Idx;
	private int d_memIdx;
	private int d_boIdx;
	private String d_status;
	private String d_content;
	private String d_decDate;
	private String d_coment;
}
