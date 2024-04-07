import 'package:flutter/material.dart';


class MySearchBar extends StatelessWidget {
 final TextEditingController controller;
  
  const MySearchBar({super.key,  required this.controller});

  @override
  Widget build(BuildContext context) {
    return  Padding(
  padding: const EdgeInsets.all(8.0),
  child: Container(
    width: MediaQuery.of(context).size.width*0.8,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 2,
          blurRadius: 2,
          offset: const Offset(0, 2), 
        ),
      ],
    ),
    child: TextField(
      decoration: InputDecoration(
        hintText: 'Search Products',
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        prefixIcon: const Icon(Icons.search, size: 16, color: Colors.grey),
        suffixIcon: TextButton(
          onPressed: () {},
          child: const Text(
            'Search',
            style: TextStyle(color: Colors.orange, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.orange, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  ),
);

  }
}