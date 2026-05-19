package util;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class FileHandler {

    // ==============================
    // STORE FILES ON DESKTOP FOR EASY ACCESS
    // ==============================

    // Get user's desktop path
    private static final String USER_HOME = System.getProperty("user.home");
    private static final String DESKTOP_PATH = USER_HOME + File.separator + "Desktop" + File.separator + "ForklyData" + File.separator;

    // Fallback paths if desktop fails
    private static final String PROJECT_PATH = System.getProperty("user.dir") + File.separator + "data" + File.separator;
    private static final String TOMCAT_PATH = System.getProperty("catalina.base") + File.separator + "webapps" + File.separator + "Forkly" + File.separator + "data" + File.separator;

    private static String DATA_DIR = null;

    static {
        initializeDataDirectory();
    }

    private static void initializeDataDirectory() {
        // Try Desktop first
        File desktopDir = new File(DESKTOP_PATH);
        if (desktopDir.exists() || desktopDir.mkdirs()) {
            DATA_DIR = DESKTOP_PATH;
            System.out.println("=========================================");
            System.out.println("✅ Data directory created on DESKTOP!");
            System.out.println("📍 Location: " + DATA_DIR);
            System.out.println("=========================================");
        }
        // Try Project directory as fallback
        else {
            File projectDir = new File(PROJECT_PATH);
            if (projectDir.exists() || projectDir.mkdirs()) {
                DATA_DIR = PROJECT_PATH;
                System.out.println("✅ Data directory created in project: " + DATA_DIR);
            }
            // Try Tomcat as last resort
            else {
                File tomcatDir = new File(TOMCAT_PATH);
                if (tomcatDir.exists() || tomcatDir.mkdirs()) {
                    DATA_DIR = TOMCAT_PATH;
                    System.out.println("✅ Data directory created in Tomcat: " + DATA_DIR);
                }
            }
        }

        // Initialize sample data files
        initializeDataFiles();
    }

    public static String getDataDir() {
        return DATA_DIR;
    }

    // ==============================
    // WRITE TO FILE
    // ==============================
    public static void writeToFile(String filename, List<String> lines, boolean append) {
        if (DATA_DIR == null) {
            System.err.println("ERROR: Data directory not initialized!");
            return;
        }

        File file = new File(DATA_DIR + filename);

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file, append))) {
            for (String line : lines) {
                writer.write(line);
                writer.newLine();
            }
            System.out.println("✅ File written: " + file.getAbsolutePath());
        } catch (IOException e) {
            System.err.println("❌ Error writing to file: " + filename);
            e.printStackTrace();
        }
    }

    public static void writeLine(String filename, String line, boolean append) {
        List<String> lines = new ArrayList<>();
        lines.add(line);
        writeToFile(filename, lines, append);
    }

    // ==============================
    // READ FROM FILE
    // ==============================
    public static List<String> readFromFile(String filename) {
        List<String> lines = new ArrayList<>();

        if (DATA_DIR == null) {
            System.err.println("ERROR: Data directory not initialized!");
            return lines;
        }

        File file = new File(DATA_DIR + filename);

        if (!file.exists()) {
            System.out.println("File does not exist yet: " + file.getAbsolutePath());
            return lines;
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (!line.trim().isEmpty()) {
                    lines.add(line);
                }
            }
        } catch (IOException e) {
            System.err.println("Error reading from file: " + filename);
            e.printStackTrace();
        }

        return lines;
    }

    // ==============================
    // UPDATE LINE IN FILE
    // ==============================
    public static boolean updateLine(String filename, String identifier,
                                     String newLine, int identifierIndex) {
        List<String> lines = readFromFile(filename);
        boolean updated = false;

        for (int i = 0; i < lines.size(); i++) {
            String[] parts = lines.get(i).split("\\|");
            if (parts.length > identifierIndex && parts[identifierIndex].equals(identifier)) {
                lines.set(i, newLine);
                updated = true;
                break;
            }
        }

        if (updated) {
            writeToFile(filename, lines, false);
        }

        return updated;
    }

    // ==============================
    // DELETE LINE FROM FILE
    // ==============================
    public static boolean deleteLine(String filename, String identifier, int identifierIndex) {
        List<String> lines = readFromFile(filename);
        boolean deleted = false;

        for (int i = 0; i < lines.size(); i++) {
            String[] parts = lines.get(i).split("\\|");
            if (parts.length > identifierIndex && parts[identifierIndex].equals(identifier)) {
                lines.remove(i);
                deleted = true;
                break;
            }
        }

        if (deleted) {
            writeToFile(filename, lines, false);
        }

        return deleted;
    }

    // ==============================
    // FIND LINE IN FILE
    // ==============================
    public static String findLine(String filename, String identifier, int identifierIndex) {
        List<String> lines = readFromFile(filename);

        for (String line : lines) {
            String[] parts = line.split("\\|");
            if (parts.length > identifierIndex && parts[identifierIndex].equals(identifier)) {
                return line;
            }
        }

        return null;
    }

    // ==============================
    // CREATE SAMPLE DATA FILES
    // ==============================
    public static void initializeDataFiles() {
        System.out.println("\n=========================================");
        System.out.println("📁 Creating data files at: " + DATA_DIR);
        System.out.println("=========================================\n");

        // Create users.txt with sample data
        List<String> userLines = readFromFile("users.txt");
        if (userLines.isEmpty()) {
            System.out.println("📝 Creating users.txt with sample data...");
            List<String> sampleUsers = new ArrayList<>();
            sampleUsers.add("ADM001|Admin User|admin@forkly.com|admin123|1234567890|Main Street|ADMIN|2024-01-01|SUPER_ADMIN|Management");
            sampleUsers.add("CUST001|John Doe|john@example.com|pass123|9876543210|123 Customer Rd|CUSTOMER|2024-01-02|0|0.0");
            writeToFile("users.txt", sampleUsers, false);
        } else {
            System.out.println("✅ users.txt already exists with " + userLines.size() + " records");
        }

        // Create menu.txt with sample data
        List<String> menuLines = readFromFile("menu.txt");
        if (menuLines.isEmpty()) {
            System.out.println("📝 Creating menu.txt with sample data...");
            List<String> sampleMenu = new ArrayList<>();
            sampleMenu.add("M001|Margherita Pizza|12.99|Pizza|true|Classic cheese and tomato pizza|Italian|true|20|FOOD");
            sampleMenu.add("M002|Chicken Burger|8.99|Burgers|true|Grilled chicken burger with lettuce|American|false|15|FOOD");
            sampleMenu.add("M003|Coca Cola|2.99|Beverages|true|Refreshing soft drink|MEDIUM|true|150|DRINK");
            sampleMenu.add("M004|French Fries|4.99|Sides|true|Crispy golden fries|American|true|10|FOOD");
            writeToFile("menu.txt", sampleMenu, false);
        } else {
            System.out.println("✅ menu.txt already exists with " + menuLines.size() + " records");
        }

        // Create other empty files if they don't exist
        String[] otherFiles = {"orders.txt", "payments.txt", "reviews.txt", "deliveries.txt", "notifications.txt"};
        for (String filename : otherFiles) {
            List<String> lines = readFromFile(filename);
            if (lines.isEmpty()) {
                System.out.println("📝 Creating empty file: " + filename);
                writeToFile(filename, new ArrayList<>(), false);
            } else {
                System.out.println("✅ " + filename + " already exists with " + lines.size() + " records");
            }
        }

        System.out.println("\n=========================================");
        System.out.println("✅ All data files are ready!");
        System.out.println("📍 Location: " + DATA_DIR);
        System.out.println("=========================================\n");
    }
}