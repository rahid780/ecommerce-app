class Review {
  final double rating;
  final String reviewerName;
  final String reviewTime;
  final String reviewText;
  final List<String> reviewImages;
  final String size;
  final String colorFamily;

  Review({
    required this.rating,
    required this.reviewerName,
    required this.reviewTime,
    required this.reviewText,
    required this.reviewImages,
    required this.size,
    required this.colorFamily,
  });
}
