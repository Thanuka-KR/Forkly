package controller;

import service.NotificationService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.IOException;

@WebServlet("/notification-action")
public class NotificationActionServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String action =
                request.getParameter("action");

        String notificationId =
                request.getParameter("notificationId");

        String userId =
                request.getParameter("userId");

        String redirectPage =
                request.getParameter("redirect");

        NotificationService notificationService =
                new NotificationService();

        // ==============================
        // MARK ALL AS READ
        // ==============================
        if ("markAllRead".equals(action)) {

            notificationService.markAllAsRead(userId);
        }

        // ==============================
        // DELETE SINGLE NOTIFICATION
        // ==============================
        if ("deleteOne".equals(action)) {

            notificationService.deleteNotification(notificationId);
        }

        // ==============================
        // DELETE ALL NOTIFICATIONS
        // ==============================
        if ("clearAll".equals(action)) {

            notificationService.clearAllNotifications(userId);
        }

        // ==============================
        // ADMIN SEND OFFER TO ALL USERS
        // ==============================
        if ("sendOfferAll".equals(action)) {

            String offerTitle =
                    request.getParameter("offerTitle");

            String offerMessage =
                    request.getParameter("offerMessage");

            int sentCount =
                    notificationService.sendOfferToAllUsers(
                            offerTitle,
                            offerMessage
                    );

            response.sendRedirect(
                    request.getContextPath()
                            + "/admin/notifications.jsp?offerSent="
                            + sentCount
            );

            return;
        }

        // ==============================
        // REDIRECT BACK
        // ==============================
        if ("admin".equals(redirectPage)) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/admin/notifications.jsp"
            );

        } else {

            response.sendRedirect(
                    request.getContextPath()
                            + "/client/notifications.jsp"
            );
        }
    }
}