import 'package:firebase_provider/models/reviews_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class ReviewsItem extends StatelessWidget {
  final Review review;

  const ReviewsItem({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                RatingBar.builder(
                  initialRating: review.rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 15,
                  ignoreGestures: true,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {},
                ),
                const SizedBox(width: 10),
                Text(
                  review.reviewerName,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            Text(review.reviewTime,
                style: const TextStyle(color: Colors.black38, fontSize: 14))
          ],
        ),
        const SizedBox(height: 10),
        Text(
          review.reviewText,
          style: const TextStyle(color: Colors.black87, fontSize: 15),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 80,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: review.reviewImages.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        review.reviewImages[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              }),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Text(
              'Size: ${review.size}',
              style: const TextStyle(color: Colors.black38, fontSize: 12),
            ),
            const SizedBox(width: 5),
            Text(
              'Color Family: ${review.colorFamily}',
              style: const TextStyle(color: Colors.black38, fontSize: 12),
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
