import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as target_platform;

class OrangeBotton extends StatelessWidget {
  final String label;
  final Function()? onPressed;
  final double width;
  const OrangeBotton(
      {super.key,
      required this.label,
      required this.onPressed,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: target_platform.kIsWeb
          ? 130
          : MediaQuery.of(context).size.width * width,
      child: Container(
        height: 40,
        //width: MediaQuery.of(context).size.width * width,
        decoration: BoxDecoration(
            color: Colors.orange, borderRadius: BorderRadius.circular(25)),
        child: MaterialButton(
          onPressed: onPressed,
          child: Text(label),
        ),
      ),
    );
  }
}
