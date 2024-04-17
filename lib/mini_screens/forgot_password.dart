// ignore_for_file: avoid_print

import 'package:firebase_provider/providers/auth_repo.dart';
import 'package:firebase_provider/widgets/my_app_bar.dart';
import 'package:firebase_provider/widgets/orange_button.dart';
import 'package:firebase_provider/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as target_platform;
import '../widgets/auth_widgets.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _CustomerLoginState();
}

class _CustomerLoginState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();

  late String email;
  late String password;
  bool processing = false;
  bool sendEmailVerification = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        appBar: MyAppBar(
          title: 'Forgot Password',
          leadingIcon: const Icon(Icons.arrow_back),
          onLeadingIconPressed: () => Navigator.pop(context),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Card(
              color: Colors.grey.shade100,
              child: SizedBox(
                width: target_platform.kIsWeb ? 450 : size.width,
                child: SafeArea(
                  child: Center(
                    child: SingleChildScrollView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      reverse: true,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            //mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Center(
                                child: Text(
                                  'To reset your password',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Acme',
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              const Center(
                                child: Text(
                                  'Please Enter your email address \n and click on the button below',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Acme',
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: TextFormField(
                                  controller: _emailController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'please enter your email';
                                    } else if (value.isValidEmail() == false) {
                                      return 'invalid Eamil';
                                    } else if (value.isValidEmail() == true) {
                                      return null;
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    email = value;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: textFormDecoration.copyWith(
                                      labelText: 'Email',
                                      hintText: 'Enter your Email'),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: processing == false
                                    ? OrangeBotton(
                                        label: 'Reset Password',
                                        onPressed: () async {
                                          setState(() {
                                            processing = true;
                                          });
                                          if (_formKey.currentState!
                                              .validate()) {
                                            AuthRepo.sendPasswordResetEmail(
                                                    _emailController.text)
                                                .whenComplete(() {
                                              MyMessageHandler.showSnackBar(
                                                  _scaffoldKey,
                                                  'Please check your email inbox');
                                              setState(() {
                                                processing = false;
                                              });
                                            });
                                          } else {
                                            setState(() {
                                              processing = false;
                                            });
                                            print('form not valid');
                                          }
                                        },
                                        width: 0.6)
                                    : const CircularProgressIndicator(
                                        color: Colors.orange,
                                      ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
