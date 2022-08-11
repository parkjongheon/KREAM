package com.spring.javagreenS_pjh.service;

import java.io.IOException;
import java.util.ArrayList;

import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;

import com.spring.javagreenS_pjh.vo.BoVO;
import com.spring.javagreenS_pjh.vo.LogVO;
import com.spring.javagreenS_pjh.vo.OrderVO;
import com.spring.javagreenS_pjh.vo.ProductVO;
import com.spring.javagreenS_pjh.vo.ReturnVO;

public interface MemService {

	public void setEmailChange(String email, String mid);

	public LogVO getUserInfo(String mid);

	public void setpwdChange(String pwd, String mid);

	public void setNameChange(String name, String mid);

	public void setNickNameChange(String nickName, String mid);

	public LogVO getNickNameCheck(String nickName);

	public void setTelChange(String tel, String mid);

	public void setProfileImg(MultipartHttpServletRequest imgProfile, String mid);

	public void setProfileDelete(LogVO vo);

	public void setReturn(ReturnVO vo);

	public int getReturnIdx(int memIdx);

	public void setReturnSub(int resub_reIdx, int subIdx, int prdIdx, String prdOption, int prdPrice, int prdCount,
			int delPoint);

	public ArrayList<ReturnVO> getMemReturn(int memIdx);

	public int getOrderCnt(int memIdx);

	public int getReturnCnt(int memIdx);

	public ArrayList<ProductVO> getSearchProduct(String key);

	public ProductVO chooseItem(int prdIdx);

	public void setMyFeedInput(MultipartHttpServletRequest file, BoVO vo);

	public BoVO getTag(String tagName);

	public void setTag(String tagName);

	public void setTagCnt(String tagName);

	public ArrayList<LogVO> userSearchNick(String userSearch);

	public void setfollow(int who_Idx, int for_Idx);

	public LogVO getfollowUse(int sIdx, int memIdx);

	public void setUnfollow(int who_Idx, int for_Idx);

	public ArrayList<LogVO> getFollowerUserList(int memIdx);

	public ArrayList<LogVO> getFollowingUserList(int memIdx);

	public ArrayList<LogVO> getSessionFollowList(int sIdx);

	public void setMyFeedUpdate(MultipartHttpServletRequest file, BoVO vo, BoVO orivo, String[] hImage) throws IOException;

	public LogVO getUserInfor(int sIdx);

	public void setAddressInput(LogVO vo);

	public ArrayList<LogVO> getUserAddressList(int sIdx);

	public LogVO getUserAddress(int idx);

	public void getUserInfoAdrUpdate(int idx, LogVO vo);

	public void getUserAddressUpdate(int idx, LogVO vo);

	public void userAddressChange(LogVO chvo, int sIdx);

	public void userAddressboxChange(LogVO orivo, int adr_Idx);

	public void addressDelete(int adr_Idx);

	public void setUserContent(int sIdx, String content);

	public void setUserDelOk(int sIdx);

	public int getDlvcnt(int memIdx);

	public void setOrderConfirm(int subIdx);

	public OrderVO getorderSubInfo(int subIdx);

	public void setMemPoint(int order_memIdx, int order_prdPoint);

	public int getConfirmcnt(int sIdx);

	public int returnAllcnt(int sIdx);

	public int returncnt1(int sIdx);

	public int returncnt2(int sIdx);

	public int returnClearcnt(int sIdx);

	public void setMsgDelete(int msgIdx);

	
}
