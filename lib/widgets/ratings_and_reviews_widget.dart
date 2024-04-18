import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_provider/models/reviews_model.dart';
import 'package:firebase_provider/widgets/reviews_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingsAndReviewsWidget extends StatefulWidget {
  final String proId;
  const RatingsAndReviewsWidget({
    super.key, required this.proId,
  });

  @override
  State<RatingsAndReviewsWidget> createState() =>
      _RatingsAndReviewsWidgetState();
}

class _RatingsAndReviewsWidgetState extends State<RatingsAndReviewsWidget> {
  CollectionReference _ratingsAndReviews = FirebaseFirestore.instance.collection('product').doc().collection('reviews');


  List<String> poepleLoves = [
    'Love Design',
    'Product',
    'Color',
    'Size',
    'Best Quality',
    'Excelent Product'
  ];

Future<List<Review>> getReviews ()async{

QuerySnapshot querySnapshot = await _ratingsAndReviews.get();

 List<Review> reviews = querySnapshot.docs
          .map((doc) {
            return Review(cName: doc['cname'], rating: doc['rating'], time: doc['time'], images: doc['images'], comment: doc['comment'], size: doc['size'], colorFamily: doc['colorFamily'],);
          })
          .toList();

      return reviews;
}

  // final List<Review> reviews = [
  //   Review(
  //     cName: 'Faraz',
  //     rating: 4.5,
  //     comment:
  //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
  //     time: '3 months ago',
  //     images: [
  //     'assets/images/img2.png',
  //     'assets/images/img3.jpg',
  //     'assets/images/img1.jpg',
  //     ],
  //     size: 'Not specified',
  //     colorFamily: 'white',
  //   ),
  //   Review(
  //     cName: 'Haris Khan',
  //     rating: 3.5,
  //     comment:
  //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
  //     time: '1 months ago',
  //     images: [
  //     'assets/images/img1.jpg',
  //     'assets/images/img3.jpg',
  //     ],
  //     size: 'Not specified',
  //     colorFamily: 'black',
  //   ),
  // ];

  double rating = 4.5;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Rating & Reviews',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(children: [
                Text(
                  rating.toString(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                RatingBar.builder(
                  initialRating: rating.toDouble(),
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 24,
                  ignoreGestures: true,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      rating = rating;
                    });
                  },
                ),
                rating > 4.0
                    ? Image.asset(
                        'assets/icons/top_rated.png',
                        width: 35,
                        height: 35,
                      )
                    : const SizedBox()
              ]),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(5)),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          Icon(
                            Icons.camera_alt,
                            color: Colors.grey,
                            size: 12,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Photos(23)',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          )
                        ]),
                        Icon(
                          Icons.keyboard_arrow_right_outlined,
                          color: Colors.grey,
                          size: 16,
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(5)),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'View All(23)',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        Icon(
                          Icons.keyboard_arrow_right_outlined,
                          color: Colors.grey,
                          size: 16,
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                color: Colors.grey,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('What poeple like about it',
                  style: TextStyle(color: Colors.black, fontSize: 16)),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 40,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: poepleLoves.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 4.0),
                              child: Text(
                                '${poepleLoves[index]}(${Random().nextInt(150)})',
                                style: const TextStyle(
                                    color: Colors.black87, fontSize: 14),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          )
                        ],
                      );
                    }),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                color: Colors.grey,
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
  height: 430,
  child: StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
        .collection('products')
        .doc(widget.proId)
        .collection('reviews')
        .snapshots(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }
      if (!snapshot.hasData) {
        return const Center(child: Text("No reviews available"));
      }
      var documents = snapshot.data!.docs;
      return ListView.builder(
        itemCount: documents.length,  
        itemBuilder: (context, index) {
          Review review = Review.fromFirestore(documents[index]);
          return ReviewsItem(review: review);
        },
      );
    },
  ),
),
            ],
          ),
        ),
      ),
    );
  }
}
