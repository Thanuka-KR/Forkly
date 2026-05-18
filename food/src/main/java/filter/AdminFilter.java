package filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;

import java.io.IOException;

@WebFilter("/admin/*")
public class AdminFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request,
                         ServletResponse response,
                         FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req =
                (HttpServletRequest) request;

        HttpServletResponse res =
                (HttpServletResponse) response;

        HttpSession session =
                req.getSession(false);

        boolean isAdmin =
                session != null
                        && "ADMIN".equals(
                        session.getAttribute("userRole"));

        if (isAdmin) {

            chain.doFilter(request, response);

        } else {

            res.sendRedirect(req.getContextPath()
                    + "/client/login.jsp?adminRequired=1");
        }
    }
}