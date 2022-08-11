package com.spring.javagreenS_pjh.common;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

@Service
public class Common {
	
	
	// 임시폴더생성
	public void setFolder() {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();

		String folerPath =  request.getSession().getServletContext().getRealPath("/resources/admin/temp/");
		File Folder = new File(folerPath);
		if (!Folder.exists()) {
			try{
			    Folder.mkdir(); //폴더 생성합니다.
			    System.out.println("폴더가 생성되었습니다.");
		  } 
		  catch(Exception e){
			    e.getStackTrace();
			}        
	  }
		else {
			System.out.println("이미 폴더가 생성되어 있습니다.");
		}
	}
	// 임시폴더 삭제
	public void deleteFoler() throws IOException {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath =  request.getSession().getServletContext().getRealPath("/resources/admin/temp/");
		File directory = new File(uploadPath);
		FileUtils.deleteDirectory(directory);
	}
	// 파일체크
	public void imgCheck(String prdContent,String upPath,String coPath,int position) throws IOException {
		//                1 		    2		      3			    4		      5         6         7	 
		//      0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
		// <img src="/javagreenS_pjh/admin/temp/220622152314_profile5.jpg" style="height:543px; width:563px" />
		// <img src="/javagreenS_pjh/admin/content/220622152314_profile5.jpg" style="height:543px; width:563px" />
		//
		// 이 작업은 content안에 그림파일(img src="/)가 있을때만 수행한다.
		
		if(prdContent.indexOf("src=\"/") == -1) return;
		String url = "/resources/admin";
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath =  request.getSession().getServletContext().getRealPath(url+upPath);
		String copyPath =  request.getSession().getServletContext().getRealPath(url+coPath);
		
		//int position = 35;
		String nextImg =  prdContent.substring(prdContent.indexOf("src=\"/") + position);
		
		boolean sw = true;
		
		while(sw) {
			String imgFile =  nextImg.substring(0, nextImg.indexOf("\""));
			
			String oriFilePath = uploadPath + imgFile;
			
			String copyFilePath = copyPath + imgFile;
			
			// 폴더에 파일을 복사처리한다.
			fileCopyCheck(oriFilePath,copyFilePath);
			if(nextImg.indexOf("src=\"/") == -1) {
				sw = false;
			}
			else {
				nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
			}		
		}
	}
	// 파일복사
	private void fileCopyCheck(String oriFilePath, String copyFilePath) {
		File oriFile = new File(oriFilePath);
		File copyFile = new File(copyFilePath);
		
		try {
			FileInputStream fis = new FileInputStream(oriFile);
			FileOutputStream fos = new FileOutputStream(copyFile);
			
			byte[] buffer = new byte[2048];
			int count = 0;
			while((count = fis.read(buffer)) != -1) {
				fos.write(buffer,0,count);
			}
			fos.flush();
			fos.close();
			fis.close();
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	
}
