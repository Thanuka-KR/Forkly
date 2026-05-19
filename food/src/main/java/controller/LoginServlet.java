package controller;

import service.UserService;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private UserService userService =
            new UserService();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String email =
                request.getParameter("email");

        String password =
                request.getParameter("password");

        if (userService.validateLogin(email, password)) {

            User user =
                    userService.getUserByEmail(email);

            HttpSession session =
                    request.getSession();

            session.setMaxInactiveInterval(30 * 60);

            session.setAttribute("loggedInUser", user);
            session.setAttribute("userId", user.getUserId());
            session.setAttribute("userRole", user.getRole());
            session.setAttribute("userName", user.getName());

            String[] avatars =
                    {"🍔", "🍕", "🥗", "🍟", "🥤", "🍩", "🍜", "☕"};

            int index =
                    Math.abs(user.getUserId().hashCode())
                            % avatars.length;

            session.setAttribute("profileAvatar", avatars[index]);

            String role =
                    user.getRole() == null
                            ? "CUSTOMER"
                            : user.getRole().trim().toUpperCase();

            if ("ADMIN".equals(role)) {

                response.sendRedirect(request.getContextPath()
                        + "/admin");

                return;
            }

            if ("DRIVER".equals(role)) {

                session.setAttribute("driverLoggedIn", true);
                session.setAttribute("driverName", user.getName());
                session.setAttribute("driverEmail", user.getEmail());
                session.setAttribute("driverId", user.getUserId());

                response.sendRedirect(request.getContextPath()
                        + "/driver/tracking.jsp");

                return;
            }

            String redirectAfterLogin =
                    (String) session.getAttribute("redirectAfterLogin");

            if (redirectAfterLogin != null
                    && !redirectAfterLogin.trim().isEmpty()) {

                session.removeAttribute("redirectAfterLogin");

                response.sendRedirect(redirectAfterLogin);

                return;
            }

            response.sendRedirect(request.getContextPath()
                    + "/client/menu.jsp");

            return;
        }

        response.sendRedirect(request.getContextPath()
                + "/client/login.jsp?error=1");
    }
}