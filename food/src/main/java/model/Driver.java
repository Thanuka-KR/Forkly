package model;

// ==============================
// DRIVER EXTENDS USER (INHERITANCE)
// ==============================

public class Driver extends User {

    private String licenseNumber;
    private String vehicleType;
    private boolean isAvailable;

    // ==============================
    // CONSTRUCTORS
    // ==============================

    public Driver() {
        super();
        this.isAvailable = true;
    }

    public Driver(String userId, String name, String email, String password,
                  String phone, String address, String createdAt,
                  String licenseNumber, String vehicleType) {
        super(userId, name, email, password, phone, address, "DRIVER", createdAt);
        this.licenseNumber = licenseNumber;
        this.vehicleType = vehicleType;
        this.isAvailable = true;
    }

    // ==============================
    // GETTERS AND SETTERS
    // ==============================

    public String getLicenseNumber() { return licenseNumber; }
    public void setLicenseNumber(String licenseNumber) { this.licenseNumber = licenseNumber; }

    public String getVehicleType() { return vehicleType; }
    public void setVehicleType(String vehicleType) { this.vehicleType = vehicleType; }

    public boolean isAvailable() { return isAvailable; }
    public void setAvailable(boolean available) { isAvailable = available; }

    // ==============================
    // POLYMORPHISM - OVERRIDDEN METHODS
    // ==============================

    @Override
    public String toString() {
        return super.toString() + "|" + licenseNumber + "|" + vehicleType + "|" + isAvailable;
    }

    public static Driver fromString(String line) {
        String[] parts = line.split("\\|");
        if (parts.length >= 8) {
            String licenseNumber = parts.length > 8 ? parts[8] : "";
            String vehicleType   = parts.length > 9 ? parts[9] : "";
            Driver driver = new Driver(parts[0], parts[1], parts[2], parts[3],
                    parts[4], parts[5], parts[7], licenseNumber, vehicleType);
            if (parts.length > 10) {
                driver.setAvailable(Boolean.parseBoolean(parts[10]));
            }
            return driver;
        }
        return null;
    }

    public String showDashboard() {
        return "Driver " + getName() + " | Vehicle: " + vehicleType + " | Available: " + isAvailable;
    }
}
