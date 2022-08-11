package com.spring.javagreenS_pjh.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javagreenS_pjh.vo.LogVO;
import com.spring.javagreenS_pjh.vo.MsgVO;

public interface LogDAO {

	public LogVO getIdInfor(@Param("mid") String mid);

	public void setMemInput(@Param("vo") LogVO vo);

	public LogVO getEmail(@Param("email") String email);

	public LogVO getMidEmail(@Param("mid") String mid,@Param("email") String email);

	public void setUserPwd(@Param("code") String code,@Param("mid") String mid);

	public void setLastDay(@Param("mid") String mid);

	public int getMsgCnt(@Param("sIdx") int sIdx);

	public LogVO getUserInfo(@Param("idx") int idx);

	public void setMsgBox(@Param("mvo") MsgVO mvo);

	public ArrayList<MsgVO> getUserMsgList(@Param("idx") int idx);

	public void setMsgRead(@Param("msgIdx") int msgIdx);

	public String getMsgGoUrl(@Param("msgIdx") int msgIdx);
}
