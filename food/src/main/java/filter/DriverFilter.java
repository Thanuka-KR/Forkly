package filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;

import java.io.IOException;

@WebFilter("/driver/*")
public class DriverFilter implements Filter {

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

        boolean isDriver =
                session != null
                        && "DRIVER".equals(
                        session.getAttribute("userRole"));

        if (isDriver) {

            chain.doFilter(request, response);

        } else {

            res.sendRedirect(req.getContextPath()
                    + "/driver/login.jsp?driverRequired=1");
        }
    }
}