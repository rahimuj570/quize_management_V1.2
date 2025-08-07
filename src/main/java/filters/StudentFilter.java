package filters;

import jakarta.servlet.Filter;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import dao.UsersDao;
import entities.Users;
import helper.ConnectionProvider;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;

/**
 * Servlet Filter implementation class StudentFilter
 */
public class StudentFilter extends HttpFilter implements Filter {
       
    /**
     * @see HttpFilter#HttpFilter()
     */
    public StudentFilter() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {

		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		HttpSession s = req.getSession();
		
		
		
		
		Cookie[] cookies = req.getCookies();
	    String save_login = null;
	    if (cookies != null) {
	        for (Cookie cookie : cookies) {
	            if ("save_login".equals(cookie.getName())) {
	                save_login = cookie.getValue();
	                break;
	            }
	        }
	    }
	    
	    Users u2 = new Users();
	    if(save_login!=null) {
	    	UsersDao udao = new UsersDao(ConnectionProvider.main());
		    u2 = udao.getUserById(save_login);	
		    s.setAttribute("current_user", u2);
	    }
	    
		
		
		
		Users u = new Users();
		u = (Users) s.getAttribute("current_user");
		if (u != null ) {
			if (u.getUser_is_teacher() == 0 && u.getUser_is_admin() ==0 ) {
				// pass the request along the filter chain
				chain.doFilter(request, response);
			} else {
				res.sendRedirect(req.getContextPath() + "/unauthorized.jsp");
			}
		} else {
			res.sendRedirect(req.getContextPath() + "/login.jsp");
		}
		
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
