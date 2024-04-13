import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';

class MyHomeSliderWidget extends StatefulWidget {
  const MyHomeSliderWidget({super.key,});

  @override
  State<MyHomeSliderWidget> createState() => _MyHomeSliderWidgetState();
}

class _MyHomeSliderWidgetState extends State<MyHomeSliderWidget> {
  final List<DocumentSnapshot> _slides = [];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadSlides();
  }

  Future<void> _loadSlides() async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('home_slider_images').get();
    setState(() {
      _slides.addAll(snapshot.docs);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
        child: Container(
              width: MediaQuery.of(context).size.width,
              height: 250,
              color: Colors.grey.shade200,
              child: _slides.isEmpty
            ?  Container(
              margin: EdgeInsets.symmetric(vertical: 100, horizontal: MediaQuery.of(context).size.width *0.4),
              width: 50,
              height: 50,
              child: const CircularProgressIndicator())
            :  Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 230,
                      child: CarouselSlider(
                        options: CarouselOptions(
                          aspectRatio: 16 / 9,
                          viewportFraction: 1,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 4),
                          autoPlayAnimationDuration: const Duration(milliseconds: 1000),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          onPageChanged: (index, _) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                        ),
                        items: _slides.map((doc) {
                          return Builder(builder: (context) {
                            return Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Image.network(doc['image'], fit: BoxFit.cover, ),
                            );
                          });
                        }).toList(),
                      ),
                    ),
                    DotsIndicator(
                      dotsCount: _slides.length,
                      position: _currentIndex,
                      decorator: DotsDecorator(
                        color: Colors.grey, 
                        activeColor: Colors.orange, 
                        size: const Size.square(8.0),
                        activeSize: const Size(20.0, 8.0),
                        spacing: const EdgeInsets.all(3.0),
                        activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                  ],
                ),
            ),
      ),
    );
  }
}
