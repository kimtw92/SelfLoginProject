package ut.lib.filter;


import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class SecurityFilter implements Filter {
	private FilterConfig filterConfig;

	private ServletContext context;


	public void init(FilterConfig filterConfig) throws ServletException {
		this.filterConfig = filterConfig;
		context = filterConfig.getServletContext();
		context.log("Client Security Filter " + filterConfig.getFilterName() + " Initialized");
	}
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain filterChain) throws IOException, ServletException {
	/*	HttpServletRequest req 	= (HttpServletRequest)request;
		HttpServletResponse res = (HttpServletResponse)response;

		DataMap cookieData = RequestUtil.getDataFromCookie(req);

		String queryString = req.getQueryString() == null ? "" : "?" + req.getQueryString();
		String retrunURL=URLEncoder.encode(req.getRequestURI()+ queryString, "EUC_KR");


		if (cookieData == null || !cookieData.containsKey("C_MIDXXX")) {
    	    //request.setAttribute("RETURN_URL",retrunURL);
			//request.getRequestDispatcher("/index.do?RETURN_URL="+retrunURL).forward(request, response);
		    res.sendRedirect("/index.do?RETURN_URL="+retrunURL);
			return;
		} else {
			filterChain.doFilter(request, response);
			return;
		}*/
		filterChain.doFilter(request, response);
		return;
	}

	public FilterConfig getFilterConfig() {
		return filterConfig;
	}

	public void setFilterConfig(FilterConfig filterConfig) {
		this.filterConfig = filterConfig;
	}

	public void destroy() {
		filterConfig = null;
	}
}
