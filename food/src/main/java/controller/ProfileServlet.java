package controller;

import model.User;
import service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.IOException;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        // ==============================
        // CHECK LOGIN SESSION
        // ==============================
        HttpSession session =
                request.getSession(false);

        if (session == null
                || session.getAttribute("loggedInUser") == null) {

            response.sendRedirect(request.getContextPath()
                    + "/client/login.jsp?loginRequired=1");

            return;
        }

        // ==============================
        // GET LOGGED USER
        // ==============================
        User user =
                (User) session.getAttribute("loggedInUser");

        // ==============================
        // GET FORM DATA
        // ==============================
        String name =
                request.getParameter("name");

        String phone =
                request.getParameter("phone");

        String address =
                request.getParameter("address");

        String password =
                request.getParameter("password");

        // ==============================
        // UPDATE PROFILE
        // ==============================
        UserService userService =
                new UserService();

        userService.updateUserProfile(
                user.getUserId(),
                name,
                phone,
                address
        );

        // ==============================
        // UPDATE PASSWORD
        // ==============================
        if (password != null
                && !password.trim().isEmpty()) {

            userService.updateUserPassword(
                    user.getUserId(),
                    password
            );
        }

        // ==============================
        // REFRESH USER SESSION
        // ==============================
        User updatedUser =
                userService.getUserById(
                        user.getUserId()
                );

        session.setAttribute(
                "loggedInUser",
                updatedUser
        );

        session.setAttribute(
                "userName",
                updatedUser.getName()
        );

        // ==============================
        // SUCCESS REDIRECT
        // ==============================
        response.sendRedirect(request.getContextPath()
                + "/client/profile.jsp?success=1");
    }
}