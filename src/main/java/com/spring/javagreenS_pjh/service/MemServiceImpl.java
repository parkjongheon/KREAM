package com.spring.javagreenS_pjh.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javagreenS_pjh.dao.MemDAO;
import com.spring.javagreenS_pjh.vo.BoVO;
import com.spring.javagreenS_pjh.vo.LogVO;
import com.spring.javagreenS_pjh.vo.OrderVO;
import com.spring.javagreenS_pjh.vo.ProductVO;
import com.spring.javagreenS_pjh.vo.ReturnVO;

@Service
public class MemServiceImpl implements MemService {
	
	@Autowired
	MemDAO memDAO;

	@Override
	public void setEmailChange(String email,String mid) {
		memDAO.setEmailChange(email,mid);
		
	}

	@Override
	public LogVO getUserInfo(String mid) {
		return memDAO.getUserInfo(mid);
	}

	@Override
	public void setpwdChange(String pwd, String mid) {
		memDAO.setpwdChange(pwd, mid);
		
	}

	@Override
	public void setNameChange(String name, String mid) {
		memDAO.setNameChange(name, mid);
		
	}

	@Override
	public void setNickNameChange(String nickName, String mid) {
		memDAO.setNickNameChange(nickName,mid);
		
	}

	@Override
	public LogVO getNickNameCheck(String nickName) {
		return memDAO.getNickNameCheck(nickName);
	}

	@Override
	public void setTelChange(String tel, String mid) {
		memDAO.setTelChange(tel, mid);
		
	}

	@Override
	public void setProfileImg(MultipartHttpServletRequest imgProfile, String mid) {
		try {
			List<MultipartFile> fileList = imgProfile.getFiles("imgProfile");
			String sFileNames = "";
			
			for(MultipartFile file : fileList) {
				String oFileName = file.getOriginalFilename();
				String sFileName = saveFileName(oFileName);
				
				writeFile(file,sFileName,"profile");
				
				sFileNames = sFileName;
				
			}
			memDAO.setProfileImg(sFileNames,mid);
			
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	private void writeFile(MultipartFile file, String sFileName,String flag) throws IOException {
		byte[] data = file.getBytes();
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = "";
		if(flag.equals("profile")) {
			uploadPath =  request.getSession().getServletContext().getRealPath("/resources/member/");			
			
		}
		else if(flag.equals("board")) {
			uploadPath =  request.getSession().getServletContext().getRealPath("/resources/board/");						
		}
		
		FileOutputStream fos = new FileOutputStream(uploadPath + sFileName);
		fos.write(data);
		fos.close();
	}

	private String saveFileName(String oFileName) {
		String fileName = "";
		
		Calendar cal = Calendar.getInstance();
		fileName += cal.get(Calendar.YEAR);
		fileName += cal.get(Calendar.MONTH);
		fileName += cal.get(Calendar.DATE);
		fileName += cal.get(Calendar.HOUR);
		fileName += cal.get(Calendar.MINUTE);
		fileName += cal.get(Calendar.SECOND);
		fileName += cal.get(Calendar.MILLISECOND);
		
		fileName += "_" + oFileName;
		
		return fileName;
	}

	@Override
	public void setProfileDelete(LogVO vo) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/member/");
		
		String photo = vo.getPhoto();
		String realPathFile = realPath + photo;
		new File(realPathFile).delete();
		
		
		memDAO.setProfileDelete(vo.getMid());
		
	}

	@Override
	public void setReturn(ReturnVO vo) {
		memDAO.setReturn(vo);
	}

	@Override
	public int getReturnIdx(int memIdx) {
		return memDAO.getReturnIdx(memIdx);
	}

	@Override
	public void setReturnSub(int resub_reIdx, int subIdx, int prdIdx, String prdOption, int prdPrice, int prdCount,
			int delPoint) {
		memDAO.setReturnSub(resub_reIdx,subIdx,prdIdx,prdOption,prdPrice,prdCount,delPoint);
	}

	@Override
	public ArrayList<ReturnVO> getMemReturn(int memIdx) {
		return memDAO.getMemReturn(memIdx);
	}

	@Override
	public int getOrderCnt(int memIdx) {
		return memDAO.getOrderCnt(memIdx);
	}

	@Override
	public int getReturnCnt(int memIdx) {
		return memDAO.getReturnCnt(memIdx);
	}

	@Override
	public ArrayList<ProductVO> getSearchProduct(String key) {
		return memDAO.getSearchProduct(key);
	}

	@Override
	public ProductVO chooseItem(int prdIdx) {
		return memDAO.chooseItem(prdIdx);
	}

	@Override
	public void setMyFeedInput(MultipartHttpServletRequest file, BoVO vo) {
		try {
			List<MultipartFile> fileList = file.getFiles("file");
			
			String fName = "";
			for(MultipartFile files : fileList) {
				String oFileName = files.getOriginalFilename();
				String sFileName = saveFileName(oFileName);
				
				writeFile(files,sFileName,"board");
				fName += sFileName + "/";
				
			}
			vo.setBo_fName(fName);
			memDAO.setMyFeedInput(vo);
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	@Override
	public void setMyFeedUpdate(MultipartHttpServletRequest file, BoVO vo, BoVO orivo,String[] hImage) throws IOException {
		
		List<MultipartFile> fileList = file.getFiles("file");

		String[] oriImage = orivo.getBo_fName().split("/");
		
		for(int i =0; i<hImage.length; i++) {
			if(!oriImage[i].equals(hImage[i])) {
				ImageDelete(oriImage[i]);
			}
		}
		String fName = "";
		for(MultipartFile files : fileList) {
			if(files.getSize() != 0) {
				String oFileName = files.getOriginalFilename();
				String sFileName = saveFileName(oFileName);
				writeFile(files,sFileName);
				fName += sFileName + "/";					
			}
		}
		
		String[] fNames = fName.split("/");
		String realfNames = "";
		
		if(hImage[0].equals("")) { // 첫번째 사진이 변경되었을경우 새로등록한파일중 첫번째를 썸네일
			realfNames = fNames[0]+"/";
			for(int i =0; i<hImage.length; i++) {
				if(!hImage[i].equals("")) {
					realfNames += hImage[i]+"/";
				}
			}
			
			for(int i =1; i<fNames.length; i++) {
					realfNames += fNames[i]+"/";
			}
		}
		else {										// 첫번째 사진이 변경이 안되었을경우 
			realfNames = hImage[0]+"/";
			for(int i =1; i<hImage.length; i++) {
				if(!hImage[i].equals("")) {
					realfNames += hImage[i]+"/";
				}
			}
			
			for(int i =0; i<fNames.length; i++) {
					realfNames += fNames[i]+"/";
			}
		}
		
		vo.setBo_fName(realfNames);

		
		memDAO.setMyFeedUpdate(vo);
	}
	private void ImageDelete(String fName) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/board/");
		
		String realPathFile = realPath + fName;
		new File(realPathFile).delete();
	}
	
	private void writeFile(MultipartFile file, String sFileName)throws IOException {
		byte[] data = file.getBytes();
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/board/");						

		
		FileOutputStream fos = new FileOutputStream(uploadPath + sFileName);
		fos.write(data);
		fos.close();
		
	}
	
	@Override
	public BoVO getTag(String tagName) {
		return memDAO.getTag(tagName);
	}

	@Override
	public void setTag(String tagName) {
		memDAO.setTag(tagName);
	}

	@Override
	public void setTagCnt(String tagName) {
		memDAO.setTagCnt(tagName);
	}

	@Override
	public ArrayList<LogVO> userSearchNick(String userSearch) {
		return memDAO.userSearchNick(userSearch);
	}

	@Override
	public void setfollow(int who_Idx, int for_Idx) {
		memDAO.setfollow(who_Idx,for_Idx);
	}

	@Override
	public LogVO getfollowUse(int sIdx, int memIdx) {
		return memDAO.getfollowUse(sIdx,memIdx);
	}

	@Override
	public void setUnfollow(int who_Idx, int for_Idx) {
		memDAO.setUnfollow(who_Idx,for_Idx);
	}

	@Override
	public ArrayList<LogVO> getFollowerUserList(int memIdx) {
		return memDAO.getFollowerUserList(memIdx);
	}

	@Override
	public ArrayList<LogVO> getFollowingUserList(int memIdx) {
		return memDAO.getFollowingUserList(memIdx);
	}

	@Override
	public ArrayList<LogVO> getSessionFollowList(int sIdx) {
		return memDAO.getSessionFollowList(sIdx);
	}

	@Override
	public LogVO getUserInfor(int sIdx) {
		return memDAO.getUserInfor(sIdx);
	}

	@Override
	public void setAddressInput(LogVO vo) {
		memDAO.setAddressInput(vo);
	}

	@Override
	public ArrayList<LogVO> getUserAddressList(int sIdx) {
		return memDAO.getUserAddressList(sIdx);
	}

	@Override
	public LogVO getUserAddress(int idx) {
		return memDAO.getUserAddress(idx);
	}

	@Override
	public void getUserInfoAdrUpdate(int idx, LogVO vo) {
		memDAO.getUserInfoAdrUpdate(idx,vo);
	}

	@Override
	public void getUserAddressUpdate(int idx, LogVO vo) {
		memDAO.getUserAddressUpdate(idx,vo);
	}

	@Override
	public void userAddressChange(LogVO chvo, int sIdx) {
		memDAO.userAddressChange(chvo,sIdx);
	}

	@Override
	public void userAddressboxChange(LogVO orivo, int adr_Idx) {
		memDAO.userAddressboxChange(orivo,adr_Idx);
	}

	@Override
	public void addressDelete(int adr_Idx) {
		memDAO.addressDelete(adr_Idx);
	}

	@Override
	public void setUserContent(int sIdx,String content) {
		memDAO.setUserContent(sIdx,content);
	}

	@Override
	public void setUserDelOk(int sIdx) {
		memDAO.setUserDelOk(sIdx);
	}

	@Override
	public int getDlvcnt(int memIdx) {
		return memDAO.getDlvcnt(memIdx);
	}

	@Override
	public void setOrderConfirm(int subIdx) {
		memDAO.setOrderConfirm(subIdx);
	}

	@Override
	public OrderVO getorderSubInfo(int subIdx) {
		return memDAO.getorderSubInfo(subIdx);
	}

	@Override
	public void setMemPoint(int order_memIdx, int order_prdPoint) {
		memDAO.setMemPoint(order_memIdx,order_prdPoint);
	}

	@Override
	public int getConfirmcnt(int sIdx) {
		return memDAO.getConfirmcnt(sIdx);
	}

	@Override
	public int returnAllcnt(int sIdx) {
		return memDAO.returnAllcnt(sIdx);
	}

	@Override
	public int returncnt1(int sIdx) {
		return memDAO.returncnt1(sIdx);
	}

	@Override
	public int returncnt2(int sIdx) {
		return memDAO.returncnt2(sIdx);
	}

	@Override
	public int returnClearcnt(int sIdx) {
		return memDAO.returnClearcnt(sIdx);
	}

	@Override
	public void setMsgDelete(int msgIdx) {
		memDAO.setMsgDelete(msgIdx);
	}

	


}
