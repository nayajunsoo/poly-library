package egovframework.example.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.web.servlet.HandlerInterceptor;
import egovframework.example.user.service.UserVO;

public class AuthInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession(false);
        UserVO loginVO = (session != null) ? (UserVO) session.getAttribute("loginVO") : null;
        if (loginVO == null) {
            String requestURI = request.getRequestURI();
            String queryString = request.getQueryString();
            String returnUrl = (queryString != null) ? requestURI + "?" + queryString : requestURI;
            response.sendRedirect(request.getContextPath()
                + "/user/loginView.do?returnUrl=" + java.net.URLEncoder.encode(returnUrl, "UTF-8"));
            return false;
        }
        return true;
    }
}
