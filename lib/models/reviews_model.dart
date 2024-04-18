import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  final double rating;
  final String cName;
  final Timestamp time;
  final String comment;
  final List<String> images;
  final String size;
  final String colorFamily;

  Review({
    required this.rating,
    required this.cName,
    required this.time,
    required this.comment,
    required this.images,
    required this.size,
    required this.colorFamily,
  });

   factory Review.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Review(
      cName: data['cname'],
      rating: data['rating'],
      time: data['time'],
      images: List<String>.from(data['images']),
      comment: data['comment'],
      size: data['size'],
      colorFamily: data['colorFamily'],
    );
  }
}
