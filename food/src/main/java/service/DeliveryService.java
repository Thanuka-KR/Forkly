package service;

import model.Delivery;
import model.StandardDelivery;
import model.ExpressDelivery;
import util.FileHandler;
import util.IdGenerator;

import java.util.ArrayList;
import java.util.List;
import java.util.Collections;

public class DeliveryService {

    private static final String DELIVERY_FILE = "deliveries.txt";

    public Delivery createDelivery(String orderId,
                                   String customerId,
                                   String address,
                                   String deliveryType) {

        String deliveryId = IdGenerator.generateDeliveryId();

        String assignedDate =
                new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
                        .format(new java.util.Date());

        Delivery delivery;

        if ("EXPRESS".equals(deliveryType)) {

            delivery =
                    new ExpressDelivery(deliveryId,
                            orderId,
                            customerId,
                            address,
                            assignedDate);

        } else {

            delivery =
                    new StandardDelivery(deliveryId,
                            orderId,
                            customerId,
                            address,
                            assignedDate);

        }

        delivery.setStatus("READY_FOR_DELIVERY");
        delivery.setDriverName("Not accepted yet");
        delivery.setDriverPhone("-");
        delivery.setEstimatedTime("Not set yet");

        FileHandler.writeLine(DELIVERY_FILE,
                delivery.toString(),
                true);

        return delivery;
    }

    public Delivery getDeliveryByOrderId(String orderId) {

        List<Delivery> deliveries = getAllDeliveries();

        for (Delivery delivery : deliveries) {

            if (delivery.getOrderId() != null
                    && delivery.getOrderId().equals(orderId)) {

                return delivery;
            }
        }

        return null;
    }
    public List<Delivery> getDeliveriesByCustomer(String customerId) {

        List<Delivery> deliveries =
                new ArrayList<>();

        List<String> lines =
                FileHandler.readFromFile(DELIVERY_FILE);

        for (String line : lines) {

            String[] parts =
                    line.split("\\|");

            if (parts.length > 2
                    && parts[2].equals(customerId)) {

                Delivery delivery =
                        parseDelivery(line);

                if (delivery != null) {

                    deliveries.add(delivery);
                }
            }
        }

        return deliveries;
    }

    public List<Delivery> getAllDeliveries() {

        List<Delivery> deliveries =
                new ArrayList<>();

        List<String> lines =
                FileHandler.readFromFile(DELIVERY_FILE);

        for (String line : lines) {

            Delivery delivery =
                    parseDelivery(line);

            if (delivery != null) {

                deliveries.add(delivery);
            }
        }

        Collections.reverse(deliveries);

        return deliveries;
    }

    public List<Delivery> getReadyDeliveries() {

        List<Delivery> readyDeliveries =
                new ArrayList<>();

        for (Delivery delivery : getAllDeliveries()) {

            if ("READY_FOR_DELIVERY".equals(delivery.getStatus())) {

                readyDeliveries.add(delivery);
            }
        }

        return readyDeliveries;
    }

    public boolean acceptDelivery(String deliveryId,
                                  String driverName,
                                  String driverPhone) {

        Delivery delivery =
                getDeliveryById(deliveryId);

        if (delivery == null) {

            return false;
        }

        delivery.setDriverName(driverName);
        delivery.setDriverPhone(driverPhone);
        delivery.setStatus("ACCEPTED");

        return FileHandler.updateLine(DELIVERY_FILE,
                deliveryId,
                delivery.toString(),
                0);
    }

    public boolean updateDeliveryStatus(String deliveryId,
                                        String status) {

        Delivery delivery =
                getDeliveryById(deliveryId);

        if (delivery == null) {

            return false;
        }

        delivery.setStatus(status);

        return FileHandler.updateLine(DELIVERY_FILE,
                deliveryId,
                delivery.toString(),
                0);
    }

    public boolean updateEstimatedTime(String deliveryId,
                                       String estimatedTime) {

        Delivery delivery =
                getDeliveryById(deliveryId);

        if (delivery == null) {

            return false;
        }

        delivery.setEstimatedTime(estimatedTime);

        return FileHandler.updateLine(DELIVERY_FILE,
                deliveryId,
                delivery.toString(),
                0);
    }

    public boolean updateDeliveryAddress(String deliveryId,
                                         String address) {

        Delivery delivery =
                getDeliveryById(deliveryId);

        if (delivery == null) {

            return false;
        }

        delivery.setAddress(address);

        return FileHandler.updateLine(DELIVERY_FILE,
                deliveryId,
                delivery.toString(),
                0);
    }

    public boolean deleteDelivery(String deliveryId) {

        return FileHandler.deleteLine(DELIVERY_FILE,
                deliveryId,
                0);
    }

    public Delivery getDeliveryById(String deliveryId) {

        String line =
                FileHandler.findLine(DELIVERY_FILE,
                        deliveryId,
                        0);

        if (line != null) {

            return parseDelivery(line);
        }

        return null;
    }

    private Delivery parseDelivery(String line) {

        String[] parts =
                line.split("\\|");

        if (parts.length < 9) {

            return null;
        }

        String deliveryType =
                parts.length > 9 ? parts[9] : "STANDARD";

        Delivery delivery;

        if ("EXPRESS".equals(deliveryType)) {

            delivery =
                    new ExpressDelivery(parts[0],
                            parts[1],
                            parts[2],
                            parts[5],
                            parts[7]);

        } else {

            delivery =
                    new StandardDelivery(parts[0],
                            parts[1],
                            parts[2],
                            parts[5],
                            parts[7]);
        }

        delivery.setDriverName(parts[3]);
        delivery.setDriverPhone(parts[4]);
        delivery.setStatus(parts[6]);
        delivery.setEstimatedTime(parts[8]);

        return delivery;
    }
}