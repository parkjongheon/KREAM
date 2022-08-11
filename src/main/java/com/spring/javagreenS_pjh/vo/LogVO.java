package com.spring.javagreenS_pjh.vo;

import lombok.Data;

public @Data class LogVO {
	private int idx;
	private String mid;
	private String pwd;
	private String name;
	private String tel;
	private String email;
	private String nickName;
	private String post;
	private String address;
	private String gender;
	private String birthDay;
	private String strGrade;
	private int grade;
	private int point;
	private String userDel;
	private String joinDay;
	private String lastDay;
	private String photo;
	private String content;
	
	
	private int fIdx;
	private int who_Idx;
	private int for_Idx;
	
	private int adr_Idx;
	private int adr_memIdx;
	private String adr_name;
	private String adr_tel;
	private String adr_post;
	private String adr_address;
	
}
