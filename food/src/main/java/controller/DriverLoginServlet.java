package controller;

import model.User;
import service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.IOException;

@WebServlet(name = "DriverLoginServlet",
        urlPatterns = {"/driver-login"})
public class DriverLoginServlet extends HttpServlet {

    // ==============================
    // SECTION 1: HANDLE DRIVER LOGIN
    // ==============================
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        // ==============================
        // SECTION 2: GET LOGIN DATA
        // ==============================
        String email    = request.getParameter("email");
        String password = request.getParameter("password");

        // ==============================
        // SECTION 3: VALIDATE AGAINST users.txt
        // ==============================
        UserService userService = new UserService();
        boolean valid = userService.validateLogin(email, password);

        if (valid) {

            User user = userService.getUserByEmail(email);

            // make sure the account is actually a DRIVER role
            if (!"DRIVER".equals(user.getRole())) {
                response.sendRedirect(request.getContextPath()
                        + "/driver/login.jsp?error=1");
                return;
            }

            // ==============================
            // SECTION 4: SET SESSION
            // ==============================
            HttpSession session = request.getSession(true);
            session.setMaxInactiveInterval(30 * 60);

            session.setAttribute("driverLoggedIn", true);
            session.setAttribute("driverName",     user.getName());
            session.setAttribute("driverEmail",    user.getEmail());
            session.setAttribute("driverId",       user.getUserId());
            session.setAttribute("userRole",       "DRIVER");  // needed by DriverFilter

            // ==============================
            // GO TO DRIVER DASHBOARD
            // ==============================
            response.sendRedirect(request.getContextPath()
                    + "/driver/tracking.jsp");

        } else {

            // ==============================
            // LOGIN FAILED
            // ==============================
            response.sendRedirect(request.getContextPath()
                    + "/driver/login.jsp?error=1");
        }
    }
}
