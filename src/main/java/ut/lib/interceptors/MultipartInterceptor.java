package ut.lib.interceptors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import ut.lib.support.HttpRequestWithModifiableParameters;

public class MultipartInterceptor extends HandlerInterceptorAdapter{
		@SuppressWarnings("unchecked")
		public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler){
			try {
				
				HttpRequestWithModifiableParameters param = new HttpRequestWithModifiableParameters(request); //요렇게 생성해서 
				
				System.out.println(request.getParameter("mode"));
				
				param.setParameter("mode", "test"); //요렇게 값 넣고 

				request = (HttpServletRequest)param; //req로 받으면 됩니다. 
				
				System.out.println(request.getParameter("mode"));
				
//				request.getParameterMap().put("mode", "test");
			} catch (Exception e) {
				e.printStackTrace();
			}
			return true;
		}
	}
