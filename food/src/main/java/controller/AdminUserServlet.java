package controller;

import service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.IOException;

@WebServlet("/admin-user")
public class AdminUserServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        UserService userService = new UserService();

        if ("add".equals(action)) {

            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String role = request.getParameter("role");

            boolean success = userService.registerUser(
                    name,
                    email,
                    password,
                    phone,
                    address,
                    role
            );

            if (success) {
                response.sendRedirect(request.getContextPath()
                        + "/admin/users.jsp?success=1");
            } else {
                response.sendRedirect(request.getContextPath()
                        + "/admin/users.jsp?error=exists");
            }

            return;
        }

        if ("delete".equals(action)) {

            String userId = request.getParameter("userId");

            userService.deleteUser(userId);

            response.sendRedirect(request.getContextPath()
                    + "/admin/users.jsp?deleted=1");

            return;
        }

        response.sendRedirect(request.getContextPath()
                + "/admin/users.jsp");
    }
}