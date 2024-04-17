import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_provider/authentication_screens/sign_up.dart';
import 'package:firebase_provider/main_screens/home_page.dart';
import 'package:firebase_provider/mini_screens/forgot_password.dart';
import 'package:firebase_provider/providers/auth_repo.dart';
import 'package:firebase_provider/providers/id_provider.dart';
import 'package:firebase_provider/widgets/auth_widgets.dart';
import 'package:firebase_provider/widgets/snack_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email;
  late String password;
  bool processing = false;
  bool sendEmailVerification = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  bool passwordVisible = false;

  setUserId(User user) {
    context.read<IdProvider>().setCustomerId(user);
  }

  void logIn() async {
    setState(() {
      processing = true;
    });

    if (_formKey.currentState!.validate()) {
      try {
        await AuthRepo.signInWithEmailAndPassword(email, password);

        User user = FirebaseAuth.instance.currentUser!;
        await FirebaseFirestore.instance
            .collection('customers')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get()
            .then((snap) async {
          if (snap.exists) {
            await AuthRepo.reloadUserData();
            if (await AuthRepo.checkEmailVerification()) {
              _formKey.currentState!.reset();

              setUserId(user);

              /* final SharedPreferences prefs = await _prefs;
              prefs.setString('customerid', user.uid);
              print(user.uid); */
              {
                await Future.delayed(const Duration(microseconds: 100))
                    .whenComplete(() => Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context)=> const HomePage())));
              }
            } else {
              MyMessageHandler.showSnackBar(
                  _scaffoldKey, 'please check your inbox');
              setState(() {
                processing = false;
                sendEmailVerification = true;
              });
            }
          } else {
            setState(() {
              processing = false;
            });
            MyMessageHandler.showSnackBar(_scaffoldKey,
                'You are not registered as a customer please register first');
          }
        });
      } on FirebaseAuthException catch (e) {
        setState(() {
          processing = false;
        });
        MyMessageHandler.showSnackBar(_scaffoldKey, e.message.toString());
      }
    } else {
      setState(() {
        processing = false;
      });
      MyMessageHandler.showSnackBar(_scaffoldKey, 'please fill all fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Card(
              color: Colors.grey.shade100,
              child: SizedBox(
                width: kIsWeb ? 450 : size.width,
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
                              const AuthHeaderLable(
                                headerLable: 'Log in',
                                subHeaderLable: 'As Customer',
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: TextFormField(
                                  // controller: _emailController,
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
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'please enter your password';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    password = value;
                                  },
                                  //  controller: _passwordController,
                                  obscureText: !passwordVisible,
                                  decoration: textFormDecoration.copyWith(
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              passwordVisible =
                                                  !passwordVisible;
                                            });
                                          },
                                          icon: Icon(
                                            passwordVisible
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: Colors.orange,
                                          )),
                                      labelText: 'Password',
                                      hintText: 'Enter your Password'),
                                ),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ForgotPassword()));
                                  },
                                  child: const Text(
                                    'Forgot Password',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontStyle: FontStyle.italic),
                                  )),
                              HaveAccount(
                                haveAccount: 'Don\'t have an account? ',
                                actionLable: 'Sign Up',
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignUpScreen()));
                                },
                              ),
                              sendEmailVerification == true
                                  ? SizedBox(
                                      height: 50,
                                      child: TextButton(
                                          onPressed: () async {
                                            try {
                                              await FirebaseAuth
                                                  .instance.currentUser!
                                                  .sendEmailVerification()
                                                  .whenComplete(() {
                                                MyMessageHandler.showSnackBar(
                                                    _scaffoldKey,
                                                    'Verification Email sent please check your inbox');
                                              });
                                            } catch (e) {
                                              MyMessageHandler.showSnackBar(
                                                  _scaffoldKey, e.toString());
                                            }
                                            setState(() {
                                              sendEmailVerification = false;
                                            });
                                          },
                                          child: const Text(
                                            'Resend Verification Email',
                                            style: TextStyle(fontSize: 18),
                                          )),
                                    )
                                  : const SizedBox(),
                              processing == true
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                          color: Colors.orange))
                                  : AuthMainButton(
                                      mainButtonLable: 'log In',
                                      onPressed: () {
                                        logIn();
                                      },
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
