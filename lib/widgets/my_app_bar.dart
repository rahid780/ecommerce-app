import 'package:flutter/material.dart';


class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
 final String title;
 final Icon? leadingIcon;
 final VoidCallback? onLeadingIconPressed;
 final Icon? actionIcon;
 final VoidCallback? onActionIconPressed;
  const MyAppBar({super.key, required this.title,  this.leadingIcon,  this.onLeadingIconPressed,  this.actionIcon,  this.onActionIconPressed});

 @override
 Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: 50,
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          leadingIcon == null ? const SizedBox(width: 30,) :  IconButton(icon: leadingIcon!, onPressed: onLeadingIconPressed),
            Text(title,style: const TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),),
           actionIcon == null ? const SizedBox(width: 30,) : IconButton(icon:  actionIcon!, onPressed: onActionIconPressed,),
          ],
        ),
      ),
    );
  }
}

