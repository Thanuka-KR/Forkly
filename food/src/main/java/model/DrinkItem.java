
package model;

public class DrinkItem extends MenuItem {

    private String size;
    private boolean isCold;
    private int calories;

    public DrinkItem() {

        super();

        this.size = "MEDIUM";
    }

    public DrinkItem(String itemId,
                     String name,
                     double price,
                     String category,
                     boolean available,
                     String description,
                     String image,
                     String size,
                     boolean isCold,
                     int calories) {

        super(itemId,
                name,
                price,
                category,
                available,
                description,
                image);

        this.size = size;

        this.isCold = isCold;

        this.calories = calories;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public boolean isCold() {
        return isCold;
    }

    public void setCold(boolean cold) {
        isCold = cold;
    }

    public int getCalories() {
        return calories;
    }

    public void setCalories(int calories) {
        this.calories = calories;
    }

    @Override
    public double calculateDiscount() {

        return price * 0.05;
    }

    @Override
    public String getItemType() {

        return "DRINK";
    }

    @Override
    public String toString() {

        return super.toString()
                + "|"
                + size
                + "|"
                + isCold
                + "|"
                + calories
                + "|DRINK";
    }
}
