package com.spring.javagreenS_pjh.service;

import com.spring.javagreenS_pjh.vo.LogVO;

public interface LogService {

	public LogVO getIdInfor(String mid);

	public int setMemInput(LogVO vo);

	public LogVO getEmail(String email);

	public LogVO getMidEmail(String mid, String email);

	public void setUserPwd(String code, String mid);

	public void setLastDay(String mid);

	public int getMsgCnt(int sIdx);

	public LogVO getUserInfo(int idx);

}
