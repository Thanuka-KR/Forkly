package service;

import model.Delivery;

public class DashboardService {

    private UserService userService =
            new UserService();

    private MenuService menuService =
            new MenuService();

    private OrderService orderService =
            new OrderService();

    private DeliveryService deliveryService =
            new DeliveryService();

    public int getTotalUsers() {

        return userService.getAllUsers().size();
    }

    public int getTotalMenuItems() {

        return menuService.getAllMenuItems().size();
    }

    public int getTotalOrders() {

        return orderService.getAllOrders().size();
    }

    public int getActiveDeliveries() {

        int count =
                0;

        for (Delivery delivery : deliveryService.getAllDeliveries()) {

            if (!"DELIVERED".equalsIgnoreCase(delivery.getStatus())) {

                count++;
            }
        }

        return count;
    }
}