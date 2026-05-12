
package model;

public class FoodItem extends MenuItem {

    private String cuisine;
    private boolean isVegetarian;
    private String preparationTime;

    public FoodItem() {

        super();

        this.cuisine = "Continental";

        this.isVegetarian = false;
    }

    public FoodItem(String itemId,
                    String name,
                    double price,
                    String category,
                    boolean available,
                    String description,
                    String image,
                    String cuisine,
                    boolean isVegetarian,
                    String preparationTime) {

        super(itemId,
                name,
                price,
                category,
                available,
                description,
                image);

        this.cuisine = cuisine;

        this.isVegetarian = isVegetarian;

        this.preparationTime = preparationTime;
    }

    public String getCuisine() {
        return cuisine;
    }

    public void setCuisine(String cuisine) {
        this.cuisine = cuisine;
    }

    public boolean isVegetarian() {
        return isVegetarian;
    }

    public void setVegetarian(boolean vegetarian) {
        isVegetarian = vegetarian;
    }

    public String getPreparationTime() {
        return preparationTime;
    }

    public void setPreparationTime(String preparationTime) {
        this.preparationTime = preparationTime;
    }

    @Override
    public double calculateDiscount() {

        return price * 0.10;
    }

    @Override
    public String getItemType() {

        return "FOOD";
    }

    @Override
    public String toString() {

        return super.toString()
                + "|"
                + cuisine
                + "|"
                + isVegetarian
                + "|"
                + preparationTime
                + "|FOOD";
    }
}

