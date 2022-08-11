package com.spring.javagreenS_pjh.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javagreenS_pjh.dao.BoardDAO;
import com.spring.javagreenS_pjh.vo.BoReVO;
import com.spring.javagreenS_pjh.vo.BoVO;
import com.spring.javagreenS_pjh.vo.LogVO;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	BoardDAO boDAO;

	@Override
	public BoVO getBoardContent(int boIdx) {
		return boDAO.getBoardContent(boIdx);
	}

	@Override
	public BoVO getBoardUserInfo(int memIdx) {
		return boDAO.getBoardUserInfo(memIdx);
	}

	@Override
	public ArrayList<BoVO> getUserContentList(int startIndexNo, int pageSize, int memIdx) {
		return boDAO.getUserContentList(startIndexNo,pageSize, memIdx);
	}

	@Override
	public void setReplyInput(BoReVO vo) {
		boDAO.setReplyInput(vo);
	}

	@Override
	public BoReVO getReplyLastIndex(int idx) {
		return boDAO.getReplyLastIndex(idx);
	}

	@Override
	public void setReplyReInput(int res) {
		boDAO.setReplyReInput(res);
	}

	@Override
	public ArrayList<BoReVO> getReplyList(int boRe_boIdx) {
		return boDAO.getReplyList(boRe_boIdx);
	}

	@Override
	public ArrayList<BoVO> getBoardLikeList(int sIdx) {
		return boDAO.getBoardLikeList(sIdx);
	}

	@Override
	public void setBoardLikeUp(BoVO vo) {
		boDAO.setBoardLikeUp(vo);
	}

	@Override
	public void setBoardLikeCntUp(int bl_boardIdx) {
		boDAO.setBoardLikeCntUp(bl_boardIdx);
	}

	@Override
	public void setBoardLikeDown(int boIdx, int sIdx) {
		boDAO.setBoardLikeDown(boIdx,sIdx);
	}

	@Override
	public void setBoardLikeCntDown(int boIdx) {
		boDAO.setBoardLikeCntDown(boIdx);
	}

	@Override
	public ArrayList<BoVO> getTagList() {
		return boDAO.getTagList();
	}

	@Override
	public int getforcnt(int memIdx) {
		return boDAO.getforcnt(memIdx);
	}

	@Override
	public int getwhocnt(int memIdx) {
		return boDAO.getwhocnt(memIdx);
	}

	@Override
	public ArrayList<BoVO> getPrdBoardList(int prdIdx) {
		return boDAO.getPrdBoardList(prdIdx);
	}

	@Override
	public void setBoardDelete(int boIdx) {
		boDAO.setBoardDelete(boIdx);
	}

	@Override
	public void setReplyDelete(int boReIdx) {
		boDAO.setReplyDelete(boReIdx);
	}

	@Override
	public String getReplyInfo(int boReIdx) {
		String text = boDAO.getReplyInfo(boReIdx);
		return text;
	}

	@Override
	public void setReplyUpdate(int boReIdx, String coment) {
		boDAO.setReplyUpdate(boReIdx,coment);
	}

	@Override
	public void setDeclaration(BoVO vo) {
		boDAO.setDeclaration(vo);
	}

	@Override
	public ArrayList<BoVO> getTagSearch(String tags) {
		return boDAO.getTagSearch(tags);
	}

	@Override
	public ArrayList<BoVO> getBestFeed() {
		return boDAO.getBestFeed();
	}
}
