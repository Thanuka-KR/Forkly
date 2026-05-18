package controller;

import service.ReviewService;

import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

import java.io.IOException;

@WebServlet("/review")
public class ReviewServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws IOException {

        String action =
                request.getParameter("action");

        ReviewService reviewService =
                new ReviewService();

        if ("add".equals(action)) {

            HttpSession session =
                    request.getSession(false);

            if (session == null
                    || session.getAttribute("userId") == null) {

                response.sendRedirect(request.getContextPath()
                        + "/client/login.jsp?loginRequired=1");

                return;
            }

            String customerId =
                    (String) session.getAttribute("userId");

            String customerName =
                    (String) session.getAttribute("userName");

            String itemId =
                    request.getParameter("itemId");

            String reviewType =
                    request.getParameter("reviewType");

            int rating =
                    Integer.parseInt(request.getParameter("rating"));

            String comment =
                    request.getParameter("comment");

            reviewService.createReview(
                    customerId,
                    customerName,
                    itemId,
                    reviewType,
                    rating,
                    comment
            );

            response.sendRedirect(request.getContextPath()
                    + "/client/reviews.jsp?success=1");

            return;
        }

        if ("delete".equals(action)) {

            String reviewId =
                    request.getParameter("reviewId");

            reviewService.deleteReview(reviewId);

            response.sendRedirect(request.getContextPath()
                    + "/admin/reviews.jsp?deleted=1");

            return;
        }

        response.sendRedirect(request.getContextPath()
                + "/client/reviews.jsp");
    }
}