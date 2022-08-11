package com.spring.javagreenS_pjh.vo;

import lombok.Data;

public @Data class MsgVO {
	private int msgIdx;
	private int msg_memIdx;
	private String msg_content;
	private String msg_url;
	private int msg_forMemIdx;
	private String msg_forMemNick;
	private int msg_val;
	private String msg_flag;
}
