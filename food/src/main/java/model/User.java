package model;

// ==============================
// SECTION 1: BASE USER CLASS WITH ENCAPSULATION
// ==============================

import java.io.Serializable;

public class User implements Serializable {
    private static final long serialVersionUID = 1L;

    // Private fields - Encapsulation
    private String userId;
    private String name;
    private String email;
    private String password;
    private String phone;
    private String address;
    private String role; // "CUSTOMER" or "ADMIN"
    private String createdAt;

    // ==============================
    // SECTION 2: CONSTRUCTORS
    // ==============================

    public User() {}

    public User(String userId, String name, String email, String password,
                String phone, String address, String role, String createdAt) {
        this.userId = userId;
        this.name = name;
        this.email = email;
        this.password = password;
        this.phone = phone;
        this.address = address;
        this.role = role;
        this.createdAt = createdAt;
    }

    // ==============================
    // SECTION 3: GETTERS AND SETTERS (ENCAPSULATION)
    // ==============================

    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public String getCreatedAt() { return createdAt; }
    public void setCreatedAt(String createdAt) { this.createdAt = createdAt; }

    // ==============================
    // SECTION 4: UTILITY METHODS
    // ==============================

    @Override
    public String toString() {
        return userId + "|" + name + "|" + email + "|" + password + "|" +
                phone + "|" + address + "|" + role + "|" + createdAt;
    }

    public static User fromString(String line) {
        String[] parts = line.split("\\|");
        if (parts.length == 8) {
            return new User(parts[0], parts[1], parts[2], parts[3],
                    parts[4], parts[5], parts[6], parts[7]);
        }
        return null;
    }
}