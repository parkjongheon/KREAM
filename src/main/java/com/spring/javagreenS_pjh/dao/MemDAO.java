package com.spring.javagreenS_pjh.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javagreenS_pjh.vo.BoVO;
import com.spring.javagreenS_pjh.vo.LogVO;
import com.spring.javagreenS_pjh.vo.MsgVO;
import com.spring.javagreenS_pjh.vo.OrderVO;
import com.spring.javagreenS_pjh.vo.ProductVO;
import com.spring.javagreenS_pjh.vo.ReturnVO;

public interface MemDAO {

	public void setEmailChange(@Param("email") String email,@Param("mid") String mid);

	public LogVO getUserInfo(@Param("mid") String mid);

	public void setpwdChange(@Param("pwd") String pwd,@Param("mid") String mid);

	public void setNameChange(@Param("name") String name,@Param("mid") String mid);

	public void setNickNameChange(@Param("nickName") String nickName,@Param("mid") String mid);

	public LogVO getNickNameCheck(@Param("nickName") String nickName);

	public void setTelChange(@Param("tel") String tel, @Param("mid") String mid);

	public void setProfileImg(@Param("photo") String sFileNames,@Param("mid") String mid);

	public void setProfileDelete(@Param("mid") String mid);

	public int myOrdertotRecCnt(@Param("memIdx") int memIdx,@Param("orderDate") int orderDate,@Param("date") String date,@Param("search") String search,@Param("start") String start,@Param("end") String end,@Param("val") int val);

	public ArrayList<OrderVO> getMemOrderList(@Param("memIdx") int memIdx,@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize,@Param("sort") String sort,@Param("date") String date,@Param("orderDate") int orderDate,@Param("search") String search,@Param("start") String start,@Param("end") String end,@Param("val") int val);

	public void setReturn(@Param("vo") ReturnVO vo);

	public int getReturnIdx(@Param("memIdx") int memIdx);

	public void setReturnSub(@Param("resub_reIdx") int resub_reIdx,@Param("subIdx") int subIdx,@Param("prdIdx") int prdIdx,@Param("prdOption") String prdOption,@Param("prdPrice") int prdPrice,@Param("prdCount") int prdCount,
			@Param("delPoint") int delPoint);

	public ArrayList<ReturnVO> getMemReturn(@Param("memIdx") int memIdx);

	public int getOrderCnt(@Param("memIdx") int memIdx);

	public int getReturnCnt(@Param("memIdx") int memIdx);

	public ArrayList<ProductVO> getSearchProduct(@Param("key") String key);

	public ProductVO chooseItem(@Param("prdIdx") int prdIdx);

	public void setMyFeedInput(@Param("vo") BoVO vo);

	public BoVO getTag(@Param("tagName") String tagName);

	public void setTag(@Param("tagName") String tagName);

	public void setTagCnt(@Param("tagName") String tagName);

	public ArrayList<LogVO> userSearchNick(@Param("userSearch") String userSearch);

	public void setfollow(@Param("who_Idx") int who_Idx,@Param("for_Idx") int for_Idx);

	public LogVO getfollowUse(@Param("sIdx") int sIdx,@Param("memIdx") int memIdx);

	public void setUnfollow(@Param("who_Idx") int who_Idx,@Param("for_Idx") int for_Idx);

	public ArrayList<LogVO> getFollowerUserList(@Param("memIdx") int memIdx);

	public ArrayList<LogVO> getFollowingUserList(@Param("memIdx") int memIdx);

	public ArrayList<LogVO> getSessionFollowList(@Param("sIdx") int sIdx);

	public void setMyFeedUpdate(@Param("vo") BoVO vo);

	public int getWishPage(@Param("sIdx") int sIdx);

	public ArrayList<ProductVO> getWishList(@Param("startIndexNo")int startIndexNo,@Param("pageSize") int pageSize,@Param("sIdx") int sIdx);

	public LogVO getUserInfor(@Param("sIdx") int sIdx);

	public void setAddressInput(@Param("vo") LogVO vo);

	public ArrayList<LogVO> getUserAddressList(@Param("sIdx") int sIdx);

	public LogVO getUserAddress(@Param("idx") int idx);

	public void getUserInfoAdrUpdate(@Param("idx") int idx,@Param("vo") LogVO vo);

	public void getUserAddressUpdate(@Param("idx") int idx,@Param("vo") LogVO vo);

	public void userAddressChange(@Param("chvo") LogVO chvo,@Param("sIdx") int sIdx);

	public void userAddressboxChange(@Param("orivo") LogVO orivo,@Param("adr_Idx") int adr_Idx);

	public void addressDelete(@Param("adr_Idx") int adr_Idx);

	public void setUserContent(@Param("sIdx") int sIdx, @Param("content") String content);

	public void setUserDelOk(@Param("sIdx") int sIdx);

	public int getDlvcnt(@Param("memIdx") int memIdx);

	public void setOrderConfirm(@Param("subIdx") int subIdx);

	public OrderVO getorderSubInfo(@Param("subIdx") int subIdx);

	public void setMemPoint(@Param("order_memIdx") int order_memIdx,@Param("order_prdPoint") int order_prdPoint);

	public int getConfirmcnt(@Param("sIdx") int sIdx);

	public int myReturntotRecCnt(@Param("memIdx") int memIdx,@Param("orderDate") int orderDate,@Param("date") String date,@Param("search") String search,@Param("start") String start,@Param("end") String end,
			@Param("val")	int val);
	
	public ArrayList<ReturnVO> getMemReturnList(@Param("memIdx") int memIdx,@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize,@Param("sort") String sort,@Param("date") String date,@Param("orderDate") int orderDate,
			@Param("start")	String start,@Param("end") String end,@Param("val") int val);

	public int returnAllcnt(@Param("sIdx") int sIdx);

	public int returncnt1(@Param("sIdx") int sIdx);

	public int returncnt2(@Param("sIdx") int sIdx);

	public int returnClearcnt(@Param("sIdx") int sIdx);

	public int getUserContentTot(@Param("memIdx") int memIdx);

	public int getMyDeclarationTot(@Param("sIdx") int sIdx);

	public ArrayList<BoVO> getMyDeclarationList(@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize,@Param("sIdx") int sIdx);

	public int getMyHistoryTot(@Param("sIdx") int sIdx);

	public ArrayList<MsgVO> getMyHistoryList(@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize,@Param("sIdx") int sIdx);

	public void setMsgDelete(@Param("msgIdx") int msgIdx);


	
}
