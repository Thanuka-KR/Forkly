package model;

// ==============================
// SECTION 1: CUSTOMER EXTENDS USER (INHERITANCE)
// ==============================

public class Customer extends User {

    private int totalOrders;
    private double totalSpent;

    // ==============================
    // SECTION 2: CONSTRUCTORS
    // ==============================

    public Customer() {
        super();
        this.totalOrders = 0;
        this.totalSpent = 0.0;
    }

    public Customer(String userId, String name, String email, String password,
                    String phone, String address, String createdAt) {
        super(userId, name, email, password, phone, address, "CUSTOMER", createdAt);
        this.totalOrders = 0;
        this.totalSpent = 0.0;
    }

    // ==============================
    // SECTION 3: GETTERS AND SETTERS
    // ==============================

    public int getTotalOrders() { return totalOrders; }
    public void setTotalOrders(int totalOrders) { this.totalOrders = totalOrders; }

    public double getTotalSpent() { return totalSpent; }
    public void setTotalSpent(double totalSpent) { this.totalSpent = totalSpent; }

    // ==============================
    // SECTION 4: POLYMORPHISM - OVERRIDDEN METHODS
    // ==============================

    @Override
    public String toString() {
        return super.toString() + "|" + totalOrders + "|" + totalSpent;
    }

    public static Customer fromString(String line) {
        String[] parts = line.split("\\|");
        if (parts.length >= 8) {
            Customer customer = new Customer(parts[0], parts[1], parts[2], parts[3],
                    parts[4], parts[5], parts[6]);
            if (parts.length > 8) {
                customer.setTotalOrders(Integer.parseInt(parts[8]));
            }
            if (parts.length > 9) {
                customer.setTotalSpent(Double.parseDouble(parts[9]));
            }
            return customer;
        }
        return null;
    }

    public String showDashboard() {
        return "Welcome " + getName() + "! You have placed " + totalOrders + " orders.";
    }
}