package com.spring.javagreenS_pjh.vo;

import lombok.Data;

public @Data class ChartVO {
	private String month;
	private int totals;
	private int rtot;
	private int stot;
	
	private String start;
	private String end;
	
	private String brand;
	private String kprdName;
	private int cnt;
}
