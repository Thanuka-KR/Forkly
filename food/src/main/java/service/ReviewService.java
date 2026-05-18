package service;

import model.Review;
import util.FileHandler;
import util.IdGenerator;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class ReviewService {

    private static final String REVIEW_FILE = "reviews.txt";

    public Review createReview(String customerId, String customerName, String itemId, String reviewType, int rating, String comment) {
        String reviewId = IdGenerator.generateReviewId();
        String reviewDate = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());

        Review review = new Review(reviewId, customerId, customerName, itemId, reviewType, rating, comment, reviewDate);
        FileHandler.writeLine(REVIEW_FILE, review.toString(), true);
        return review;
    }

    public List<Review> getAllReviews() {
        List<Review> reviews = new ArrayList<>();
        List<String> lines = FileHandler.readFromFile(REVIEW_FILE);
        for (String line : lines) {
            Review review = parseReview(line);
            if (review != null) reviews.add(review);
        }
        return reviews;
    }

    public List<Review> getReviewsByItem(String itemId) {
        return getAllReviews().stream()
                .filter(r -> r.getItemId().equals(itemId))
                .collect(Collectors.toList());
    }

    public List<Review> getReviewsByCustomer(String customerId) {
        return getAllReviews().stream()
                .filter(r -> r.getCustomerId().equals(customerId))
                .collect(Collectors.toList());
    }

    public List<Review> getReviewsByType(String reviewType) {
        return getAllReviews().stream()
                .filter(r -> r.getReviewType().equals(reviewType))
                .collect(Collectors.toList());
    }

    public Review getReviewById(String reviewId) {
        String line = FileHandler.findLine(REVIEW_FILE, reviewId, 0);
        return line != null ? parseReview(line) : null;
    }

    public boolean updateReview(String reviewId, Integer rating, String comment) {
        Review review = getReviewById(reviewId);
        if (review == null) return false;
        if (rating != null) review.setRating(rating);
        if (comment != null) review.setComment(comment);
        return FileHandler.updateLine(REVIEW_FILE, reviewId, review.toString(), 0);
    }

    public boolean deleteReview(String reviewId) {
        return FileHandler.deleteLine(REVIEW_FILE, reviewId, 0);
    }

    public double getAverageRatingForItem(String itemId) {
        return getReviewsByItem(itemId).stream()
                .mapToInt(Review::getRating)
                .average()
                .orElse(0.0);
    }

    private Review parseReview(String line) {
        String[] parts = line.split("\\|");
        if (parts.length >= 8) {
            return new Review(parts[0], parts[1], parts[2], parts[3], parts[4],
                    Integer.parseInt(parts[5]), parts[6], parts[7]);
        }
        return null;
    }
}