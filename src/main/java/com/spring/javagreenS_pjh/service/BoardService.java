package com.spring.javagreenS_pjh.service;

import java.util.ArrayList;

import com.spring.javagreenS_pjh.vo.BoReVO;
import com.spring.javagreenS_pjh.vo.BoVO;
import com.spring.javagreenS_pjh.vo.LogVO;

public interface BoardService {

	public BoVO getBoardContent(int boIdx);

	public BoVO getBoardUserInfo(int memIdx);

	public ArrayList<BoVO> getUserContentList(int startIndexNo, int pageSize, int memIdx);

	public void setReplyInput(BoReVO vo);

	public BoReVO getReplyLastIndex(int idx);

	public void setReplyReInput(int res);

	public ArrayList<BoReVO> getReplyList(int boRe_boIdx);

	public ArrayList<BoVO> getBoardLikeList(int sIdx);

	public void setBoardLikeUp(BoVO vo);

	public void setBoardLikeCntUp(int bl_boardIdx);

	public void setBoardLikeDown(int boIdx, int sIdx);

	public void setBoardLikeCntDown(int boIdx);

	public ArrayList<BoVO> getTagList();

	public int getforcnt(int memIdx);

	public int getwhocnt(int memIdx);

	public ArrayList<BoVO> getPrdBoardList(int prdIdx);

	public void setBoardDelete(int boIdx);

	public void setReplyDelete(int boReIdx);

	public String getReplyInfo(int boReIdx);

	public void setReplyUpdate(int boReIdx, String coment);

	public void setDeclaration(BoVO vo);

	public ArrayList<BoVO> getTagSearch(String tags);

	public ArrayList<BoVO> getBestFeed();


}
