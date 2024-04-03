import 'package:flutter/material.dart';


class MyAppBar extends StatelessWidget {
 final String title;
 final Icon leadingIcon;
 final VoidCallback onLeadingIconPressed;
 final Icon actionIcon;
 final VoidCallback onActionIconPressed;
  const MyAppBar({super.key, required this.title, required this.leadingIcon, required this.onLeadingIconPressed, required this.actionIcon, required this.onActionIconPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      height: 50,
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(icon: leadingIcon, onPressed: onLeadingIconPressed),
          Text(title,style: const TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),),
          IconButton(icon:  actionIcon, onPressed: onActionIconPressed),
        ],
      ),
    );
  }
}

