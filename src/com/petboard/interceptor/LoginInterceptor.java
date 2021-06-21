package com.petboard.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		HttpSession session = request.getSession(false);
		if(session != null) {
			Object memberVo = session.getAttribute("memberVo");
			if(memberVo != null) {
				return true;
			}
		}
		response.sendRedirect(request.getContextPath() + "/enterLogin");
		return false;
	}
	
}
