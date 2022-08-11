package com.spring.javagreenS_pjh.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javagreenS_pjh.dao.LogDAO;
import com.spring.javagreenS_pjh.vo.LogVO;

@Service
public class LogServiceIpml implements LogService {

	@Autowired
	LogDAO logDAO;

	@Override
	public LogVO getIdInfor(String mid) {
		return logDAO.getIdInfor(mid);
	}

	@Override
	public int setMemInput(LogVO vo) {
		logDAO.setMemInput(vo);
		int res = 1;
		return res;
	}

	@Override
	public LogVO getEmail(String email) {
		return logDAO.getEmail(email);
	}

	@Override
	public LogVO getMidEmail(String mid, String email) {
		return logDAO.getMidEmail(mid, email);
	}

	@Override
	public void setUserPwd(String code,String mid) {
		logDAO.setUserPwd(code,mid);
		
	}

	@Override
	public void setLastDay(String mid) {
		logDAO.setLastDay(mid);
		
	}

	@Override
	public int getMsgCnt(int sIdx) {
		return logDAO.getMsgCnt(sIdx);
	}

	@Override
	public LogVO getUserInfo(int idx) {
		return logDAO.getUserInfo(idx);
	}

}
