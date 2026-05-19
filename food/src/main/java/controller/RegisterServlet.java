package controller;

import service.UserService;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String role = request.getParameter("role");

        if (role == null || role.isEmpty()) {
            role = "CUSTOMER";
        }

        System.out.println("Registration attempt - Email: " + email + ", Role: " + role);

        boolean success = userService.registerUser(name, email, password, phone, address, role);

        if (success) {
            System.out.println("Registration successful for: " + email);
            response.sendRedirect(request.getContextPath() + "/client/login.jsp?success=1");
        } else {
            System.out.println("Registration failed for: " + email);
            response.sendRedirect(request.getContextPath() + "/client/register.jsp?error=1");
        }
    }
}