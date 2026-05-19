package controller;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/") || pathInfo.equals("/dashboard.jsp")) {
            request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
        } else if (pathInfo.equals("/users") || pathInfo.equals("/users.jsp")) {
            request.getRequestDispatcher("/admin/users.jsp").forward(request, response);
        } else if (pathInfo.equals("/menu") || pathInfo.equals("/menu-management.jsp")) {
            request.getRequestDispatcher("/admin/menu-management.jsp").forward(request, response);
        } else if (pathInfo.equals("/orders") || pathInfo.equals("/orders.jsp")) {
            request.getRequestDispatcher("/admin/orders.jsp").forward(request, response);
        } else if (pathInfo.equals("/payments") || pathInfo.equals("/payments.jsp")) {
            request.getRequestDispatcher("/admin/payments.jsp").forward(request, response);
        } else if (pathInfo.equals("/deliveries") || pathInfo.equals("/deliveries.jsp")) {
            request.getRequestDispatcher("/admin/deliveries.jsp").forward(request, response);
        } else if (pathInfo.equals("/reviews") || pathInfo.equals("/reviews.jsp")) {
            request.getRequestDispatcher("/admin/reviews.jsp").forward(request, response);
        } else if (pathInfo.equals("/notifications") || pathInfo.equals("/notifications.jsp")) {
            request.getRequestDispatcher("/admin/notifications.jsp").forward(request, response);
        } else {
            response.sendError(404, "Page not found");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}