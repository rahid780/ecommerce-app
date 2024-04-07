import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';



class ReviewsItem extends StatelessWidget {
  const ReviewsItem({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> getReviewImages = [
      'assets/images/img1.jpg',
      'assets/images/img2.png',
      'assets/images/img3.jpg',
      'assets/images/img1.jpg',
      'assets/images/img2.png',
      'assets/images/img3.jpg',
    ];
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                RatingBar.builder(
                  initialRating: 2,
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
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'Farzan',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const Text('5 months ago',
                style: TextStyle(color: Colors.black38, fontSize: 14))
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Very good quality same jesa dekhaya tha wahi cheese bejhe hai very very pretty mujhe dar tha k size may chota na ho par abohat acha hai.',
          style: TextStyle(color: Colors.black87, fontSize: 15),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 80,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: getReviewImages.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
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
                          getReviewImages[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ));
              }),
        ),
        const SizedBox(
          height: 10,
        ),
        const Row(
          children: [
            Text(
              'Size: ${'Not Specified'}',
              style: TextStyle(color: Colors.black38, fontSize: 12),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              'Color Family: ${'White'}',
              style: TextStyle(color: Colors.black38, fontSize: 12),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        )
      ],
    );
  }
}