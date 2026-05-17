package controller;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
@WebServlet("/notifications")
public class NotificationServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.sendRedirect(req.getContextPath() + "/client/notifications.jsp");
    }
}