import 'package:firebase_provider/main_screens/home_page.dart';
import 'package:firebase_provider/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _search = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 70,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomePage()),);
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: const Offset(
                                0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextField(
                        autofocus: true,
                        controller: _searchController,
                        onChanged: (value) {
                          setState(() {
                            _search = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Search Products',
                          hintStyle: const TextStyle(
                              color: Colors.grey, fontSize: 14),
                          prefixIcon: const Icon(Icons.search,
                              size: 16, color: Colors.grey),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.orange, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey.shade400, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: _search.isEmpty
                  ? const Center(
                      child: Text(
                        'Enter a search query to find products',
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('products').snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text('Something went wrong'),
                          );
                        }

                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        final result = snapshot.data!.docs.where((doc) =>
                            doc['name'].toString().toLowerCase().contains(_search.toLowerCase()));

                        if (result.isEmpty) {
                          return Center(
                            child: Text(
                              'No products found for "$_search"',
                              style: const TextStyle(fontSize: 18),
                            ),
                          );
                        }

                        return GridView(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1,
                          ),
                          children: result.map((e) => ProductItem(productData: e, fromSearchScreen: true,)).toList(),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
