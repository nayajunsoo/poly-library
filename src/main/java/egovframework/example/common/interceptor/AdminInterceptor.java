package egovframework.example.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.web.servlet.HandlerInterceptor;
import egovframework.example.user.service.UserVO;

public class AdminInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession(false);
        UserVO loginVO = (session != null) ? (UserVO) session.getAttribute("loginVO") : null;
        if (loginVO == null) {
            response.sendRedirect(request.getContextPath() + "/user/loginView.do");
            return false;
        }
        if (!"ADMIN".equals(loginVO.getRole())) {
            response.sendRedirect(request.getContextPath() + "/common/accessDenied.do");
            return false;
        }
        return true;
    }
}
