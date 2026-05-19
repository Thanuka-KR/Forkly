package filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;

import java.io.IOException;

@WebFilter(urlPatterns = {
        "/client/menu.jsp",
        "/client/cart.jsp",
        "/client/order-history.jsp",
        "/client/payment.jsp",
        "/client/notifications.jsp",
        "/cart",
        "/payment"
})
public class AuthFilter implements Filter {

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

        boolean loggedIn =
                session != null
                        && session.getAttribute("loggedInUser") != null;

        boolean driverLoggedIn =
                session != null
                        && Boolean.TRUE.equals(
                        session.getAttribute("driverLoggedIn"));

        // ==============================
        // ALLOW ACCESS
        // ==============================
        if (loggedIn || driverLoggedIn) {

            chain.doFilter(request, response);

        } else {

            // ==============================
            // SAVE ORIGINAL URL
            // ==============================
            String requestedUrl =
                    req.getRequestURI();

            String query =
                    req.getQueryString();

            if (query != null) {

                requestedUrl =
                        requestedUrl + "?" + query;
            }

            HttpSession newSession =
                    req.getSession();

            newSession.setAttribute(
                    "redirectAfterLogin",
                    requestedUrl
            );

            // ==============================
            // REDIRECT LOGIN
            // ==============================
            res.sendRedirect(req.getContextPath()
                    + "/client/login.jsp?loginRequired=1");
        }
    }
}