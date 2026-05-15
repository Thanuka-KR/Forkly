 package service;

import model.MenuItem;
import model.FoodItem;
import model.DrinkItem;

import util.FileHandler;
import util.IdGenerator;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class MenuService {

    private static final String MENU_FILE = "menu.txt";

    // ==============================
    // ADD MENU ITEM
    // ==============================
    public boolean addMenuItem(String name,
                               double price,
                               String category,
                               String description,
                               String image,
                               String itemType,
                               String... extraParams) {

        String itemId =
                IdGenerator.generateMenuItemId();

        boolean available = true;

        MenuItem item;

        // ==============================
        // FOOD ITEM
        // ==============================
        if ("FOOD".equals(itemType)) {

            String cuisine =
                    extraParams.length > 0
                            ? extraParams[0]
                            : "Continental";

            boolean isVegetarian =
                    extraParams.length > 1
                            && Boolean.parseBoolean(extraParams[1]);

            String prepTime =
                    extraParams.length > 2
                            ? extraParams[2]
                            : "15-20 min";

            item = new FoodItem(
                    itemId,
                    name,
                    price,
                    category,
                    available,
                    description,
                    image,
                    cuisine,
                    isVegetarian,
                    prepTime
            );

        }

        // ==============================
        // DRINK ITEM
        // ==============================
        else {

            String size =
                    extraParams.length > 0
                            ? extraParams[0]
                            : "MEDIUM";

            boolean isCold =
                    extraParams.length > 1
                            && Boolean.parseBoolean(extraParams[1]);

            int calories =
                    extraParams.length > 2
                            ? Integer.parseInt(extraParams[2])
                            : 100;

            item = new DrinkItem(
                    itemId,
                    name,
                    price,
                    category,
                    available,
                    description,
                    image,
                    size,
                    isCold,
                    calories
            );
        }

        FileHandler.writeLine(
                MENU_FILE,
                item.toString(),
                true
        );

        return true;
    }

    // ==============================
    // GET ALL ITEMS
    // ==============================
    public List<MenuItem> getAllMenuItems() {

        List<MenuItem> items =
                new ArrayList<>();

        List<String> lines =
                FileHandler.readFromFile(MENU_FILE);

        for (String line : lines) {

            MenuItem item =
                    parseMenuItem(line);

            if (item != null) {

                items.add(item);

            }
        }

        return items;
    }

    // ==============================
    // GET ITEM BY ID
    // ==============================
    public MenuItem getMenuItemById(String itemId) {

        List<MenuItem> items =
                getAllMenuItems();

        for (MenuItem item : items) {

            if (item.getItemId().equals(itemId)) {

                return item;

            }
        }

        return null;
    }

    // ==============================
    // AVAILABLE ITEMS
    // ==============================
    public List<MenuItem> getAvailableItems() {

        return getAllMenuItems()
                .stream()
                .filter(MenuItem::isAvailable)
                .collect(Collectors.toList());
    }

    // ==============================
    // DELETE ITEM
    // ==============================
    public boolean deleteMenuItem(String itemId) {

        return FileHandler.deleteLine(
                MENU_FILE,
                itemId,
                0
        );
    }

    // ==============================
    // UPDATE ITEM
    // ==============================
    public boolean updateMenuItem(String itemId,
                                  String name,
                                  Double price,
                                  String category,
                                  Boolean available,
                                  String description) {

        MenuItem item =
                getMenuItemById(itemId);

        if (item == null) {

            return false;

        }

        if (name != null) {
            item.setName(name);
        }

        if (price != null) {
            item.setPrice(price);
        }

        if (category != null) {
            item.setCategory(category);
        }

        if (available != null) {
            item.setAvailable(available);
        }

        if (description != null) {
            item.setDescription(description);
        }

        return FileHandler.updateLine(
                MENU_FILE,
                itemId,
                item.toString(),
                0
        );
    }

    // ==============================
    // PARSE MENU ITEM
    // ==============================
    private MenuItem parseMenuItem(String line) {

        String[] parts = line.split("\\|");

        if (parts.length < 10) {
            return null;
        }

        String itemType = parts[parts.length - 1];

        // ==============================
        // OLD FORMAT WITHOUT IMAGE
        // itemId|name|price|category|available|description|extra1|extra2|extra3|TYPE
        // ==============================
        if (parts.length == 10) {

            String defaultImage = "default-food.jpg";

            if ("FOOD".equals(itemType)) {

                return new FoodItem(
                        parts[0],
                        parts[1],
                        Double.parseDouble(parts[2]),
                        parts[3],
                        Boolean.parseBoolean(parts[4]),
                        parts[5],
                        defaultImage,
                        parts[6],
                        Boolean.parseBoolean(parts[7]),
                        parts[8]
                );
            }

            if ("DRINK".equals(itemType)) {

                return new DrinkItem(
                        parts[0],
                        parts[1],
                        Double.parseDouble(parts[2]),
                        parts[3],
                        Boolean.parseBoolean(parts[4]),
                        parts[5],
                        defaultImage,
                        parts[6],
                        Boolean.parseBoolean(parts[7]),
                        Integer.parseInt(parts[8])
                );
            }
        }

        // ==============================
        // NEW FORMAT WITH IMAGE
        // itemId|name|price|category|available|description|image|extra1|extra2|extra3|TYPE
        // ==============================
        if (parts.length >= 11) {

            if ("FOOD".equals(itemType)) {

                return new FoodItem(
                        parts[0],
                        parts[1],
                        Double.parseDouble(parts[2]),
                        parts[3],
                        Boolean.parseBoolean(parts[4]),
                        parts[5],
                        parts[6],
                        parts[7],
                        Boolean.parseBoolean(parts[8]),
                        parts[9]
                );
            }

            if ("DRINK".equals(itemType)) {

                return new DrinkItem(
                        parts[0],
                        parts[1],
                        Double.parseDouble(parts[2]),
                        parts[3],
                        Boolean.parseBoolean(parts[4]),
                        parts[5],
                        parts[6],
                        parts[7],
                        Boolean.parseBoolean(parts[8]),
                        Integer.parseInt(parts[9])
                );
            }
        }

        return null;
    }

    // ==============================
    // SEARCH
    // ==============================
    public List<MenuItem> searchItems(String keyword) {

        return getAllMenuItems()
                .stream()
                .filter(item ->
                        item.getName()
                                .toLowerCase()
                                .contains(keyword.toLowerCase())

                                ||

                                item.getDescription()
                                        .toLowerCase()
                                        .contains(keyword.toLowerCase())
                )
                .collect(Collectors.toList());
    }

    // ==============================
    // CATEGORIES
    // ==============================
    public List<String> getAllCategories() {

        return getAllMenuItems()
                .stream()
                .map(MenuItem::getCategory)
                .distinct()
                .collect(Collectors.toList());
    }
}
