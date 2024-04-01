import 'package:firebase_provider/main_screens/home_page.dart';
import 'package:flutter/material.dart';


class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const HomePage()));
        } ,icon: const Icon(Icons.arrow_back) ,),
        title: const Text('Categories'),
      ),
      body: const Center(
        child: Text('Categories'),
      ),
    );
  }
}