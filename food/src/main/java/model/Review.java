package model;

import java.io.Serializable;

public class Review implements Serializable {
    private static final long serialVersionUID = 1L;

    private String reviewId;
    private String customerId;
    private String customerName;
    private String itemId;
    private String reviewType;
    private int rating;
    private String comment;
    private String reviewDate;

    public Review() {}

    public Review(String reviewId, String customerId, String customerName,
                  String itemId, String reviewType, int rating,
                  String comment, String reviewDate) {
        this.reviewId = reviewId;
        this.customerId = customerId;
        this.customerName = customerName;
        this.itemId = itemId;
        this.reviewType = reviewType;
        this.rating = rating;
        this.comment = comment;
        this.reviewDate = reviewDate;
    }

    public String getReviewId() { return reviewId; }
    public void setReviewId(String reviewId) { this.reviewId = reviewId; }

    public String getCustomerId() { return customerId; }
    public void setCustomerId(String customerId) { this.customerId = customerId; }

    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }

    public String getItemId() { return itemId; }
    public void setItemId(String itemId) { this.itemId = itemId; }

    public String getReviewType() { return reviewType; }
    public void setReviewType(String reviewType) { this.reviewType = reviewType; }

    public int getRating() { return rating; }
    public void setRating(int rating) { this.rating = rating; }

    public String getComment() { return comment; }
    public void setComment(String comment) { this.comment = comment; }

    public String getReviewDate() { return reviewDate; }
    public void setReviewDate(String reviewDate) { this.reviewDate = reviewDate; }

    public String getRatingStars() {
        StringBuilder stars = new StringBuilder();
        for (int i = 0; i < rating; i++) stars.append("★");
        for (int i = rating; i < 5; i++) stars.append("☆");
        return stars.toString();
    }

    @Override
    public String toString() {
        return reviewId + "|" + customerId + "|" + customerName + "|" +
                itemId + "|" + reviewType + "|" + rating + "|" +
                comment + "|" + reviewDate;
    }
}