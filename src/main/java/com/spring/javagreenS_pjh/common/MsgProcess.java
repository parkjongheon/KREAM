package com.spring.javagreenS_pjh.common;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javagreenS_pjh.dao.LogDAO;
import com.spring.javagreenS_pjh.vo.MsgVO;

@Service
public class MsgProcess {
	
	@Autowired
	LogDAO logDAO;
	
	public void setMsgBox(MsgVO mvo) {
		String content = "";
		if(mvo.getMsg_flag().equals("ReplyTag")) {
			content = "<a href='/javagreenS_pjh/board/userFeed?memIdx="+mvo.getMsg_forMemIdx()+"'><font color='blue'>@"+mvo.getMsg_forMemNick()+"</font></a>님이 회원님을 <b>태그</b>하였습니다.";
		}
		else if(mvo.getMsg_flag().equals("boardLike")) {
			content = "<a href='/javagreenS_pjh/board/userFeed?memIdx="+mvo.getMsg_forMemIdx()+"'><font color='blue'>@"+mvo.getMsg_forMemNick()+"</font></a>님이 회원님의 게시물에 <i class=\"fa fa-heart\" style=\"color:red\" aria-hidden=\"true\"></i><b>좋아요</b> 를 눌렀습니다.";
		}
		else if(mvo.getMsg_flag().equals("follow")) {
			content = "<a href='/javagreenS_pjh/board/userFeed?memIdx="+mvo.getMsg_forMemIdx()+"'><font color='blue'>@"+mvo.getMsg_forMemNick()+"</font></a>님이 회원님을 <b>팔로우</b>했습니다.";
		}
		mvo.setMsg_content(content);
		logDAO.setMsgBox(mvo);
	}

	public ArrayList<MsgVO> getUserMsgList(int idx) {
		return logDAO.getUserMsgList(idx);
	}

	public void setMsgRead(int msgIdx) {
		logDAO.setMsgRead(msgIdx);
	}

	public String getMsgGoUrl(int msgIdx) {
		return logDAO.getMsgGoUrl(msgIdx);
	}

}
