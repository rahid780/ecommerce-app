import 'package:firebase_provider/providers/cart_provider.dart';
import 'package:firebase_provider/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_provider/main_screens/profile_screen.dart';
import 'package:firebase_provider/main_screens/categories_screen.dart';
import 'package:firebase_provider/mini_screens/cart_screen.dart';
import 'package:firebase_provider/widgets/category_home_widget.dart';
import 'package:firebase_provider/main_screens/electronics_screen.dart';
import 'package:firebase_provider/main_screens/fruits_screen.dart';
import 'package:firebase_provider/widgets/home_main_categories.dart';
import 'package:firebase_provider/widgets/home_slider.dart';
import 'package:firebase_provider/widgets/search_bar.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late final PageController _pageController;
  int _currentIndex = 0;
  List<dynamic> _cartCount = [];

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
     _cartCount = context.watch<CartProvider>().cartList;
    return Scaffold(
      key: _scaffoldKey,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [
          SafeArea(
            child: Column(
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
                        MaterialPageRoute(builder: (context) => const ProfileScreen()));
                  },
                ),
                const Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        MySearchBar(),
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
          ),
          const CategoriesScreen(),
          const CartScreen(),
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.orange,
        backgroundColor: Colors.white,
        items:  <Widget>[
          const Icon(Icons.home, size: 30),
          const Icon(Icons.category, size: 30),
          _cartCount.isEmpty ? const Icon(Icons.shopping_cart, size: 30): badges.Badge(
            badgeContent:  Text( _cartCount.length.toString(), style: const TextStyle(fontSize: 14),),
            child: const Icon(Icons.shopping_cart, size: 30)),
           const Icon(Icons.person, size: 30),
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
