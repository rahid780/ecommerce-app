import 'dart:math';

import 'package:firebase_provider/main_screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductDetailsScreen extends StatefulWidget {
  final dynamic productDetails;
  const ProductDetailsScreen({super.key, required this.productDetails});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: SizedBox(width: 200, child: Text(widget.productDetails['name'])),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.5,
                  color: Colors.white,
                  child: Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    color: Colors.white,
                    elevation: 5,
                    child: Image(
                      image: NetworkImage(widget.productDetails['image']),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.favorite_border,
                        color: Colors.orange,
                        size: 25,
                      )),
                )
              ]),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  color: Colors.white,
                  elevation: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.95,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.productDetails['name'],
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  PriceRowWidget(widget: widget),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Item Description:',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Text(
                              widget.productDetails['description'],
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black),
                              maxLines: 14,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              RatingsAndReviewsWidget(),
            ],
          ),
        ),
      ),
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.store,
                color: Colors.red,
                size: 25,
              )),
          const SizedBox(
            height: 20,
            child: VerticalDivider(
              color: Colors.grey,
              width: 1,
            ),
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.chat,
                color: Colors.red,
                size: 25,
              )),
          Container(
              width: MediaQuery.of(context).size.width * 0.3,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                  )
                ],
              ),
              child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Buy now',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ))),
          Container(
              width: MediaQuery.of(context).size.width * 0.3,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                  )
                ],
              ),
              child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Add to Cart',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  )))
        ],
      ),
    );
  }
}

class RatingsAndReviewsWidget extends StatefulWidget {
  const RatingsAndReviewsWidget({
    super.key,
  });

  @override
  State<RatingsAndReviewsWidget> createState() =>
      _RatingsAndReviewsWidgetState();
}

class _RatingsAndReviewsWidgetState extends State<RatingsAndReviewsWidget> {
  List<String> poepleLoves = [
    'Love Design',
    'Product',
    'Color',
    'Size',
    'Best Quality',
    'Excelent Product'
  ];
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
              const ReviewsItem(),
             const Padding(
                padding:  EdgeInsets.symmetric(vertical: 8.0),
                child: Divider(),
              ),
              const ReviewsItem(),
              const ReviewsItem(),
            ],
          ),
        ),
      ),
    );
  }
}

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

class PriceRowWidget extends StatelessWidget {
  const PriceRowWidget({
    super.key,
    required this.widget,
  });

  final ProductDetailsScreen widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Text(
              'Rs. ',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange),
            ),
            Text(
              (widget.productDetails['price'] / 3).toStringAsFixed(0),
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Rs. ${widget.productDetails['price']}',
              style: const TextStyle(
                  decoration: TextDecoration.lineThrough,
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
            const SizedBox(
              width: 3,
            ),
            Text(
              (((widget.productDetails['price'] / 3) /
                          (widget.productDetails['price']) *
                          100) -
                      100)
                  .toStringAsFixed(0),
              style: const TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
            const Text(
              '%',
              style: TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
          ],
        ),
        Row(
          children: [
            const Text(
              '122 Sold',
              style: TextStyle(
                  fontSize: 10,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.share,
                  color: Colors.black,
                  size: 15,
                ))
          ],
        ),
      ],
    );
  }
}
