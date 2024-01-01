class AverageRating {
  double calculateAverageRating(
      int a, int b, int c, int d, int e, int totalRatings) {
    double averageRating =
        (1 * a + 2 * b + 3 * c + 4 * d + 5 * e) / totalRatings;
    return averageRating;
  }
}
