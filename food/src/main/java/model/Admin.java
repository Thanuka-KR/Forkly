package model;

public class Admin extends User {

    private String adminLevel;
    private String department;

    public Admin() {
        super();
        this.adminLevel = "STAFF";
    }

    public Admin(String userId, String name, String email, String password,
                 String phone, String address, String createdAt, String adminLevel) {
        super(userId, name, email, password, phone, address, "ADMIN", createdAt);
        this.adminLevel = adminLevel != null ? adminLevel : "STAFF";
    }

    public String getAdminLevel() { return adminLevel; }
    public void setAdminLevel(String adminLevel) { this.adminLevel = adminLevel; }

    public String getDepartment() { return department; }
    public void setDepartment(String department) { this.department = department; }

    @Override
    public String toString() {
        return super.toString() + "|" + adminLevel + "|" + (department != null ? department : "");
    }

    public static Admin fromString(String line) {
        String[] parts = line.split("\\|");
        if (parts.length >= 8) {
            String adminLevel = parts.length > 8 ? parts[8] : "STAFF";
            Admin admin = new Admin(parts[0], parts[1], parts[2], parts[3],
                    parts[4], parts[5], parts[6], adminLevel);
            if (parts.length > 9) {
                admin.setDepartment(parts[9]);
            }
            return admin;
        }
        return null;
    }

    public String showDashboard() {
        return "Admin " + getName() + " - Level: " + adminLevel;
    }
}