package ut.lib.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;

public class ConfigFilter implements Filter {
	private FilterConfig filterConfig;
	private ServletContext context;

	public void init(FilterConfig filterConfig) throws ServletException {
		this.filterConfig = filterConfig;
		context = filterConfig.getServletContext();
		context.log("Client Config Filter " + filterConfig.getFilterName() + " Initialized");
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain filterChain) throws IOException, ServletException {
		//HttpServletRequest req 	= (HttpServletRequest)request;
		//HttpServletResponse res = (HttpServletResponse)response;

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
