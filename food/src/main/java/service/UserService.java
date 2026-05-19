package service;

import model.User;
import model.Customer;
import model.Admin;
import model.Driver;
import util.FileHandler;
import util.IdGenerator;

import java.util.ArrayList;
import java.util.List;

public class UserService {

    private static final String USER_FILE =
            "users.txt";

    public boolean registerUser(String name,
                                String email,
                                String password,
                                String phone,
                                String address,
                                String role) {

        List<User> existingUsers =
                getAllUsers();

        for (User user : existingUsers) {

            if (user.getEmail().equalsIgnoreCase(email)) {

                return false;
            }
        }

        String userId =
                IdGenerator.generateUserId();

        String createdAt =
                new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
                        .format(new java.util.Date());

        String cleanRole =
                role == null
                        ? "CUSTOMER"
                        : role.trim().toUpperCase();

        String userLine;

        if ("ADMIN".equals(cleanRole)) {

            Admin admin =
                    new Admin(userId,
                            name,
                            email,
                            password,
                            phone,
                            address,
                            createdAt,
                            "STAFF");

            userLine =
                    admin.toString();

        } else if ("DRIVER".equals(cleanRole)) {

            Driver driver =
                    new Driver(userId,
                            name,
                            email,
                            password,
                            phone,
                            address,
                            createdAt,
                            "",
                            "");

            userLine =
                    driver.toString();

        } else {

            Customer customer =
                    new Customer(userId,
                            name,
                            email,
                            password,
                            phone,
                            address,
                            createdAt);

            userLine =
                    customer.toString();
        }

        FileHandler.writeLine(USER_FILE,
                userLine,
                true);

        return true;
    }

    public User getUserByEmail(String email) {

        List<String> lines =
                FileHandler.readFromFile(USER_FILE);

        for (String line : lines) {

            String[] parts =
                    line.split("\\|");

            if (parts.length > 2
                    && parts[2].equalsIgnoreCase(email)) {

                return parseUser(line,
                        parts);
            }
        }

        return null;
    }

    public User getUserById(String userId) {

        List<String> lines =
                FileHandler.readFromFile(USER_FILE);

        for (String line : lines) {

            String[] parts =
                    line.split("\\|");

            if (parts.length > 0
                    && parts[0].equals(userId)) {

                return parseUser(line,
                        parts);
            }
        }

        return null;
    }

    public List<User> getAllUsers() {

        List<User> users =
                new ArrayList<>();

        List<String> lines =
                FileHandler.readFromFile(USER_FILE);

        for (String line : lines) {

            String[] parts =
                    line.split("\\|");

            if (parts.length > 6) {

                User user =
                        parseUser(line,
                                parts);

                if (user != null) {

                    users.add(user);
                }
            }
        }

        return users;
    }

    private User parseUser(String line,
                           String[] parts) {

        String role =
                parts[6] == null
                        ? "CUSTOMER"
                        : parts[6].trim().toUpperCase();

        if ("ADMIN".equals(role)) {

            return Admin.fromString(line);
        }

        if ("DRIVER".equals(role)) {

            return Driver.fromString(line);
        }

        return Customer.fromString(line);
    }

    public boolean validateLogin(String email,
                                 String password) {

        User user =
                getUserByEmail(email);

        if (user == null) {

            return false;
        }

        return user.getPassword().equals(password);
    }

    public boolean updateUserProfile(String userId,
                                     String name,
                                     String phone,
                                     String address) {

        User user =
                getUserById(userId);

        if (user == null) {

            return false;
        }

        user.setName(name);
        user.setPhone(phone);
        user.setAddress(address);

        return FileHandler.updateLine(USER_FILE,
                userId,
                user.toString(),
                0);
    }

    public boolean updateUserPassword(String userId,
                                      String newPassword) {

        User user =
                getUserById(userId);

        if (user == null) {

            return false;
        }

        user.setPassword(newPassword);

        return FileHandler.updateLine(USER_FILE,
                userId,
                user.toString(),
                0);
    }

    public boolean deleteUser(String userId) {

        return FileHandler.deleteLine(USER_FILE,
                userId,
                0);
    }

    public List<User> searchUsers(String keyword) {

        List<User> results =
                new ArrayList<>();

        for (User user : getAllUsers()) {

            if (user.getName().toLowerCase().contains(keyword.toLowerCase())
                    || user.getEmail().toLowerCase().contains(keyword.toLowerCase())) {

                results.add(user);
            }
        }

        return results;
    }

    public List<User> getUsersByRole(String role) {

        List<User> results =
                new ArrayList<>();

        for (User user : getAllUsers()) {

            if (user.getRole() != null
                    && user.getRole().trim().equalsIgnoreCase(role)) {

                results.add(user);
            }
        }

        return results;
    }
}