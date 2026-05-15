package model;

import java.io.Serializable;

public abstract class MenuItem implements Serializable {

    private static final long serialVersionUID = 1L;

    protected String itemId;
    protected String name;
    protected double price;
    protected String category;
    protected boolean available;
    protected String description;

    // ==============================
    // NEW IMAGE FIELD
    // ==============================
    protected String image;

    public MenuItem() {
        this.available = true;
        this.image = "default-food.jpg";
    }

    public MenuItem(String itemId,
                    String name,
                    double price,
                    String category,
                    boolean available,
                    String description,
                    String image) {

        this.itemId = itemId;
        this.name = name;
        this.price = price;
        this.category = category;
        this.available = available;
        this.description = description;
        this.image = image;
    }

    public String getItemId() {
        return itemId;
    }

    public void setItemId(String itemId) {
        this.itemId = itemId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public boolean isAvailable() {
        return available;
    }

    public void setAvailable(boolean available) {
        this.available = available;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    // ==============================
    // IMAGE GETTER / SETTER
    // ==============================
    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public abstract double calculateDiscount();

    public abstract String getItemType();

    @Override
    public String toString() {

        return itemId + "|" +
                name + "|" +
                price + "|" +
                category + "|" +
                available + "|" +
                description + "|" +
                image;
    }
}

