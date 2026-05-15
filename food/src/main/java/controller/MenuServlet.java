package controller;

import service.MenuService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.IOException;

@WebServlet("/menu")
public class MenuServlet extends HttpServlet {

    // ==============================
    // HANDLE GET
    // ==============================
    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws IOException {

        resp.sendRedirect(
                req.getContextPath()
                        + "/client/menu.jsp"
        );
    }

    // ==============================
    // HANDLE POST
    // ==============================
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String action =
                request.getParameter("action");

        MenuService menuService =
                new MenuService();

        // ==============================
        // ADD MENU ITEM
        // ==============================
        if ("add".equals(action)) {

            String name =
                    request.getParameter("name");

            double price =
                    Double.parseDouble(
                            request.getParameter("price")
                    );

            String category =
                    request.getParameter("category");

            String description =
                    request.getParameter("description");

            String image =
                    request.getParameter("image");

            String itemType =
                    request.getParameter("itemType");

            // SAVE MENU ITEM
            menuService.addMenuItem(
                    name,
                    price,
                    category,
                    description,
                    image,
                    itemType
            );

            response.sendRedirect(
                    request.getContextPath()
                            + "/admin/menu-management.jsp?success=1"
            );

            return;
        }

        // ==============================
        // UPDATE MENU ITEM PRICE
        // ==============================
        if ("updatePrice".equals(action)) {

            String itemId =
                    request.getParameter("itemId");

            double newPrice =
                    Double.parseDouble(
                            request.getParameter("price")
                    );

            menuService.updateMenuItem(
                    itemId,
                    null,
                    newPrice,
                    null,
                    null,
                    null
            );

            response.sendRedirect(
                    request.getContextPath()
                            + "/admin/menu-management.jsp?priceUpdated=1"
            );

            return;
        }

        // ==============================
        // DELETE MENU ITEM
        // ==============================
        if ("delete".equals(action)) {

            String itemId =
                    request.getParameter("itemId");

            menuService.deleteMenuItem(itemId);

            response.sendRedirect(
                    request.getContextPath()
                            + "/admin/menu-management.jsp?deleted=1"
            );

            return;
        }

        // ==============================
        // DEFAULT REDIRECT
        // ==============================
        response.sendRedirect(
                request.getContextPath()
                        + "/admin/menu-management.jsp"
        );
    }
}