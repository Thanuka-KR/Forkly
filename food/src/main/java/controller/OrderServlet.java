package controller;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
@WebServlet("/order")
public class OrderServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.sendRedirect(req.getContextPath() + "/client/payment.jsp");
    }
}