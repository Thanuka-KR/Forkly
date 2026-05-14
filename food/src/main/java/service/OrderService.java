package service;

import model.Order;
import model.OrderItem;
import util.FileHandler;
import util.IdGenerator;

import java.util.ArrayList;
import java.util.List;
import java.util.Collections;
import java.util.Comparator;

public class OrderService {

    private static final String ORDER_FILE = "orders.txt";

    public Order createOrder(String customerId,
                             List<OrderItem> items,
                             String deliveryAddress) {

        String orderId = IdGenerator.generateOrderId();

        String orderDate =
                new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
                        .format(new java.util.Date());

        Order order =
                new Order(orderId,
                        customerId,
                        orderDate,
                        0,
                        "PENDING",
                        deliveryAddress);

        order.setItems(items);

        order.calculateTotal();

        FileHandler.writeLine(ORDER_FILE,
                order.toString(),
                true);

        return order;
    }

    public Order createOrder(String customerId,
                             List<OrderItem> items) {

        return createOrder(customerId,
                items,
                "");

    }

    public Order getOrderById(String orderId) {

        String line =
                FileHandler.findLine(ORDER_FILE,
                        orderId,
                        0);

        if (line != null) {

            return parseOrder(line);

        }

        return null;
    }

    public List<Order> getOrdersByCustomer(String customerId) {

        List<Order> orders = new ArrayList<>();

        List<String> lines =
                FileHandler.readFromFile(ORDER_FILE);

        for (String line : lines) {

            String[] parts =
                    line.split("\\|");

            if (parts.length > 1
                    && parts[1].equals(customerId)) {

                Order order =
                        parseOrder(line);

                if (order != null) {

                    orders.add(order);

                }

            }

        }

        Collections.sort(orders,
                new Comparator<Order>() {

                    @Override
                    public int compare(Order o1,
                                       Order o2) {

                        return o2.getOrderDate()
                                .compareTo(o1.getOrderDate());

                    }

                });

        return orders;
    }

    public List<Order> getAllOrders() {

        List<Order> orders = new ArrayList<>();

        List<String> lines =
                FileHandler.readFromFile(ORDER_FILE);

        for (String line : lines) {

            Order order =
                    parseOrder(line);

            if (order != null) {

                orders.add(order);

            }

        }

        Collections.sort(orders,
                new Comparator<Order>() {

                    @Override
                    public int compare(Order o1,
                                       Order o2) {

                        return o2.getOrderDate()
                                .compareTo(o1.getOrderDate());

                    }

                });

        return orders;
    }

    public boolean updateOrderStatus(String orderId,
                                     String status) {

        Order order =
                getOrderById(orderId);

        if (order == null) {

            return false;

        }

        order.setStatus(status);

        return FileHandler.updateLine(ORDER_FILE,
                orderId,
                order.toString(),
                0);

    }

    public boolean cancelOrder(String orderId) {

        return updateOrderStatus(orderId,
                "CANCELLED");

    }

    public boolean deleteOrder(String orderId) {

        return FileHandler.deleteLine(ORDER_FILE,
                orderId,
                0);

    }

    private Order parseOrder(String line) {

        String[] parts =
                line.split("\\|");

        if (parts.length < 5) {

            return null;

        }

        Order order;

        if (parts.length >= 7) {

            order =
                    new Order(parts[0],
                            parts[1],
                            parts[2],
                            Double.parseDouble(parts[3]),
                            parts[4],
                            parts[5]);

            String itemsText =
                    parts[6];

            loadItems(order,
                    itemsText);

        } else {

            order =
                    new Order(parts[0],
                            parts[1],
                            parts[2],
                            Double.parseDouble(parts[3]),
                            parts[4]);

            if (parts.length > 5) {

                loadItems(order,
                        parts[5]);

            }

        }

        return order;

    }

    private void loadItems(Order order,
                           String itemsText) {

        if (itemsText == null || itemsText.isEmpty()) {

            return;

        }

        String[] itemsStr =
                itemsText.split(";");

        for (String itemStr : itemsStr) {

            String[] itemParts =
                    itemStr.split(",");

            if (itemParts.length >= 4) {

                OrderItem item =
                        new OrderItem(itemParts[0],
                                itemParts[1],
                                Integer.parseInt(itemParts[2]),
                                Double.parseDouble(itemParts[3]));

                order.addItem(item);

            }

        }

    }

}