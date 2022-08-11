package com.spring.javagreenS_pjh.interceptor;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AdminInterceptor extends HandlerInterceptorAdapter {
	@Override
  public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
  	HttpSession session = request.getSession();
  	int level = session.getAttribute("sGrade")==null ? 99 : (int) session.getAttribute("sGrade");
  	if(level != 0) {
  		RequestDispatcher dispatcher;
  		dispatcher = request.getRequestDispatcher("/msg/adgetOut");
  		
  		dispatcher.forward(request, response);
  		return false;
  	}
  	return true;
  }
}
