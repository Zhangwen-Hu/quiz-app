package com.example.quizapp.filter;

import org.springframework.stereotype.Component;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@Component
public class AuthFilter implements Filter {
    
    // Paths that don't require authentication
    private static final List<String> PUBLIC_PATHS = Arrays.asList(
            "/login", "/register", "/contact", 
            "/css/", "/js/", "/images/", "/logout", "/authenticate", "/error", "/access-denied"
    );
    
    // Paths that require admin access
    private static final List<String> ADMIN_PATHS = Arrays.asList(
            "/admin", "/admin/", "/users", "/questions/manage", "/categories/manage"
    );

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        
        String requestPath = httpRequest.getRequestURI().substring(httpRequest.getContextPath().length());
        
        // Check if the path is public
        boolean isPublicPath = PUBLIC_PATHS.stream().anyMatch(requestPath::startsWith);
        
        // Allow access to public paths
        if (isPublicPath) {
            chain.doFilter(request, response);
            return;
        }
        
        // Check if user is logged in
        if (session == null || session.getAttribute("user") == null) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
            return;
        }
        
        // Check if path requires admin access
        boolean isAdminPath = ADMIN_PATHS.stream().anyMatch(requestPath::startsWith);
        
        if (isAdminPath) {
            Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
            if (isAdmin == null || !isAdmin) {
                // Redirect to 403 page instead of sending error
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/access-denied");
                return;
            }
        }
        
        // Continue the filter chain
        chain.doFilter(request, response);
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code, if needed
    }

    @Override
    public void destroy() {
        // Cleanup code, if needed
    }
} 