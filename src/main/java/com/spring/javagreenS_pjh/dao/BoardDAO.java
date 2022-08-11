package com.spring.javagreenS_pjh.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javagreenS_pjh.vo.BoReVO;
import com.spring.javagreenS_pjh.vo.BoVO;
import com.spring.javagreenS_pjh.vo.LogVO;

public interface BoardDAO {

	public BoVO getBoardContent(@Param("boIdx") int boIdx);

	public BoVO getBoardUserInfo(@Param("memIdx") int memIdx);

	public ArrayList<BoVO> getUserContentList(@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize,@Param("memIdx") int memIdx);

	public void setReplyInput(@Param("vo") BoReVO vo);

	public BoReVO getReplyLastIndex(@Param("boRe_memIdx") int idx);

	public void setReplyReInput(@Param("res") int res);

	public ArrayList<BoReVO> getReplyList(@Param("boRe_boIdx") int boRe_boIdx);

	public ArrayList<BoVO> getBoardLikeList(@Param("sIdx") int sIdx);

	public void setBoardLikeUp(@Param("vo") BoVO vo);

	public void setBoardLikeCntUp(@Param("bl_boardIdx") int bl_boardIdx);

	public void setBoardLikeDown(@Param("boIdx")int boIdx,@Param("sIdx") int sIdx);

	public void setBoardLikeCntDown(@Param("boIdx") int boIdx);

	public int feedAllCnt();

	public ArrayList<BoVO> getFeedAll(@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize);

	public ArrayList<BoVO> getTagList();

	public ArrayList<BoVO> getfeedPapular(@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize);

	public int feedFollowtot(@Param("sIdx") int sIdx);

	public ArrayList<BoVO> getFeedFollow(@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize,@Param("sIdx") int sIdx,@Param("flag") String flag);

	public int feedTagtot(@Param("tags") String tags);

	public ArrayList<BoVO> getFeedTagPapular(@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize,@Param("tags") String tags);

	public int getforcnt(@Param("memIdx") int memIdx);

	public int getwhocnt(@Param("memIdx") int memIdx);

	public ArrayList<BoVO> getPrdBoardList(@Param("prdIdx") int prdIdx);

	public int getPrdFeedtot(@Param("prdIdx") int prdIdx);

	public ArrayList<BoVO> getFeedProduct(@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize,@Param("prdIdx") int prdIdx);

	public void setBoardDelete(@Param("boIdx") int boIdx);

	public void setReplyDelete(@Param("boReIdx") int boReIdx);

	public String getReplyInfo(@Param("boReIdx") int boReIdx);

	public void setReplyUpdate(@Param("boReIdx") int boReIdx,@Param("coment") String coment);

	public void setDeclaration(@Param("vo") BoVO vo);

	public ArrayList<BoVO> getTagSearch(@Param("tags") String tags);

	public ArrayList<BoVO> getBestFeed();

}
