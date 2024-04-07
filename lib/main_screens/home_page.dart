import 'package:firebase_provider/widgets/dummy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_provider/widgets/my_app_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_provider/main_screens/profile_screen.dart';
import 'package:firebase_provider/main_screens/categories_screen.dart';
import 'package:firebase_provider/mini_screens/cart_screen.dart';
import 'package:firebase_provider/widgets/category_home_widget.dart';
import 'package:firebase_provider/main_screens/electronics_screen.dart';
import 'package:firebase_provider/main_screens/fruits_screen.dart';
import 'package:firebase_provider/widgets/home_main_categories.dart';
import 'package:firebase_provider/widgets/home_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late final PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.orange,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.color_lens),
              title: const Text('Color Themes'),
              onTap: () {
                // Handle color themes action
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Wishlist'),
              onTap: () {
                // Handle wishlist action
              },
            ),
            // Add more list tiles for other actions
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children:  [
          Column(
            children: [
              MyAppBar(
                title: 'Welcome',
                leadingIcon: const Icon(Icons.menu),
                onLeadingIconPressed: () {
                  _scaffoldKey.currentState!.openDrawer();
                },
                actionIcon: const Icon(Icons.person),
                onActionIconPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const ProfileScreen()),
                  );
                },
              ),
              const Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(height: 10),
                      DummySearchBar(),
                      SizedBox(height: 10),
                      MyHomeSliderWidget(),
                      SizedBox(height: 10),
                      MainCategories(
                        nextScreen: CategoriesScreen(),
                        category: 'Categories',
                        headline: 'Choose for your best life.',
                      ),
                      SizedBox(height: 10),
                      CategoryWidget(
                        category: 'Fruits',
                        headline: 'Fresh and fast delivery',
                        nextScreen: FruitsScreen(),
                      ),
                      SizedBox(height: 10),
                      CategoryWidget(
                        category: 'Electronics',
                        headline: 'Original and branded',
                        nextScreen: ElectronicsScreen(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const CategoriesScreen(),
          const CartScreen(),
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.orange,
        backgroundColor: Colors.transparent,
        items: const <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.category, size: 30),
          Icon(Icons.shopping_cart, size: 30),
          Icon(Icons.person, size: 30),
        ],
        index: _currentIndex,
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 01),
            curve: Curves.easeOut,
          );
        },
      ),
    );
  }
}
