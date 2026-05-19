package controller;

import util.FileHandler;
import service.UserService;
import model.User;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/test-setup")
public class TestSetupServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        out.println("<!DOCTYPE html>");
        out.println("<html><head><title>Forkly Setup Test</title></head><body>");
        out.println("<h1 style='color: #FF6B35;'>Forkly System Setup Test</h1>");

        // Test 1: Check Data Directory
        out.println("<h2>📁 Test 1: Data Directory</h2>");
        String dataDir = FileHandler.getDataDir();
        out.println("<p>Data Directory: <strong>" + dataDir + "</strong></p>");

        // Test 2: Check Users
        out.println("<h2>👥 Test 2: Users in System</h2>");
        UserService userService = new UserService();
        List<User> users = userService.getAllUsers();
        out.println("<p>Total Users Found: <strong>" + users.size() + "</strong></p>");

        if (users.isEmpty()) {
            out.println("<p style='color: red;'>⚠️ No users found! Please restart the server.</p>");
        } else {
            out.println("<table border='1' cellpadding='8' style='border-collapse: collapse;'>");
            out.println("<tr style='background: #FF6B35; color: white;'><th>User ID</th><th>Name</th><th>Email</th><th>Role</th></tr>");
            for (User user : users) {
                out.println("<tr>");
                out.println("<td>" + user.getUserId() + "</td>");
                out.println("<td>" + user.getName() + "</td>");
                out.println("<td>" + user.getEmail() + "</td>");
                out.println("<td>" + user.getRole() + "</td>");
                out.println("</tr>");
            }
            out.println("</table>");
        }

        // Test 3: Login Test
        out.println("<h2>🔐 Test 3: Login Validation</h2>");
        boolean adminLogin = userService.validateLogin("admin@forkly.com", "admin123");
        boolean customerLogin = userService.validateLogin("john@example.com", "pass123");

        out.println("<p>Admin Login (admin@forkly.com / admin123): <strong>" + (adminLogin ? "✅ SUCCESS" : "❌ FAILED") + "</strong></p>");
        out.println("<p>Customer Login (john@example.com / pass123): <strong>" + (customerLogin ? "✅ SUCCESS" : "❌ FAILED") + "</strong></p>");

        // Test 4: File List
        out.println("<h2>📄 Test 4: Data Files Location</h2>");
        out.println("<p>All data files are stored at: <code>" + dataDir + "</code></p>");
        out.println("<p>Open this folder on your desktop to see the files!</p>");

        out.println("<hr>");
        out.println("<h3>🔗 Quick Links:</h3>");
        out.println("<ul>");
        out.println("<li><a href='client/login.jsp'>Go to Login Page</a></li>");
        out.println("<li><a href='admin/dashboard.jsp'>Go to Admin Dashboard</a></li>");
        out.println("<li><a href='client/menu.jsp'>Go to Menu</a></li>");
        out.println("</ul>");

        out.println("</body></html>");
    }
}