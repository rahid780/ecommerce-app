
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AuthMainButton extends StatelessWidget {
  final String mainButtonLable;
  final Function() onPressed;
  const AuthMainButton(
      {Key? key, required this.mainButtonLable, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Material(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(25),
        child: MaterialButton(
          minWidth: double.infinity,
          onPressed: onPressed,
          child: Text(
            mainButtonLable,
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class HaveAccount extends StatelessWidget {
  final String haveAccount;
  final String actionLable;
  final Function() onPressed;
  const HaveAccount({
    Key? key,
    required this.haveAccount,
    required this.actionLable,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          haveAccount,
          style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
        ),
        TextButton(
            onPressed: onPressed,
            child: Text(
              actionLable,
              style: const TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ))
      ],
    );
  }
}

class AuthHeaderLable extends StatelessWidget {
  final String headerLable;
  final String subHeaderLable;
  const AuthHeaderLable(
      {Key? key, required this.headerLable, required this.subHeaderLable})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                headerLable,
                style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Acme'),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  subHeaderLable,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Acme'),
                ),
              ),
            ],
          ),
          IconButton(
              onPressed: () {
                kIsWeb
                    ? Navigator.pushReplacementNamed(context, '/customer_home')
                    : Navigator.pushReplacementNamed(
                        context, '/onboarding_screen');
              },
              icon: const Icon(
                Icons.home,
                size: 40,
              ))
        ],
      ),
    );
  }
}

var textFormDecoration = InputDecoration(
  labelText: 'Full Name',
  hintText: 'Enter your full name',
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
  enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.orange, width: 1),
      borderRadius: BorderRadius.circular(15)),
  focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.deepOrangeAccent, width: 2),
      borderRadius: BorderRadius.circular(15)),
);

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^([a-zA-Z0-9]+)([\-\_\.]*)([a-zA-Z0-9]*)([@])([a-zA-Z0-9]{2,})([\.][a-zA-Z]{2,3})$')
        .hasMatch(this);
  }
}
