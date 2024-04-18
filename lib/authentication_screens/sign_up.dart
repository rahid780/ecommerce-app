// ignore_for_file: avoid_print

import 'dart:io';
import 'package:firebase_provider/authentication_screens/login.dart';
import 'package:firebase_provider/widgets/snack_bar.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_provider/widgets/auth_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late String profileImage;
  late String _uid;
  late String name;
  late String address;
  late String email;
  late String phone;
  late String password;
  late String conpassword;
  bool processing = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  final TextEditingController _passwordController = TextEditingController();

  bool passwordVisible = false;
  bool conpasswordVisible = false;

  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  dynamic _pickedImageError;

  CollectionReference customers =
      FirebaseFirestore.instance.collection('customers');

  void _pickImageFromCamera() async {
    try {
      final pickedImage = await _picker.pickImage(
        source: ImageSource.camera,
        maxHeight: 600,
        maxWidth: 600,
      );
      setState(() {
        _imageFile = pickedImage;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });
      print(_pickedImageError);
    }
  }

  void _pickImageFromGallery() async {
    try {
      final pickedImage = await _picker.pickImage(
          source: ImageSource.gallery,
          maxHeight: 600,
          maxWidth: 600,
          imageQuality: 95);
      setState(() {
        _imageFile = pickedImage;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });
      print(_pickedImageError);
    }
  }

  void signUp() async {
    setState(() {
      processing = true;
    });

    if (_formKey.currentState!.validate()) {
      if (_imageFile != null) {
        try {
          await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password);
          print('user saved to database');

          firebase_storage.Reference ref =
              firebase_storage.FirebaseStorage.instance
                  .ref('cust-images/$email.jpg');
          await ref.putFile(File(_imageFile!.path));
          profileImage = await ref.getDownloadURL();

          print('image saved to database');
          _uid = FirebaseAuth.instance.currentUser!.uid;
          await customers.doc(_uid).set({
            'approved': true,
            'name': name,
            'email': email,
            'profileImage': profileImage,
            'phone': phone,
            'address': address,
            'cid': _uid,
          });
          //print('data saved to database');

          _formKey.currentState!.reset();
          setState(() {
            _imageFile == null;
          });

          await Future.delayed(const Duration(microseconds: 100)).whenComplete(
              () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LoginScreen())));
        } on FirebaseAuthException catch (e) {
          setState(() {
            processing = false;
          });
          MyMessageHandler.showSnackBar(_scaffoldKey, e.toString());
        }
      } else {
        setState(() {
          processing = false;
        });
        MyMessageHandler.showSnackBar(_scaffoldKey, 'please pick image first');
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
          child: SizedBox(
            width: kIsWeb ? 450 : size.width,
            child: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const AuthHeaderLable(
                            headerLable: 'Sign Up',
                            subHeaderLable: 'As Customer',
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 40),
                                child: kIsWeb
                                    ? CircleAvatar(
                                        radius: 60,
                                        backgroundColor: Colors.orange,
                                        backgroundImage: _imageFile == null
                                            ? null
                                            : NetworkImage(_imageFile!.path),
                                      )
                                    : CircleAvatar(
                                        radius: 60,
                                        backgroundColor: Colors.orange,
                                        backgroundImage: _imageFile == null
                                            ? null
                                            : FileImage(File(_imageFile!.path)),
                                      ),
                              ),
                              Column(
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.orange,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15))),
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.camera_alt,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        _pickImageFromCamera();
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.orange,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(15),
                                            bottomRight: Radius.circular(15))),
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.photo,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        _pickImageFromGallery();
                                      },
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'please enter your full name';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                name = value;
                              },
                              //controller: _nameController,
                              decoration: textFormDecoration.copyWith(
                                  labelText: 'Full Name',
                                  hintText: 'Enter your Full Name'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
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
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'please enter your phone number';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                phone = value;
                              },
                              //controller: _nameController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(),
                              decoration: textFormDecoration.copyWith(
                                  labelText: 'Phone Number',
                                  hintText: 'Enter your phone number'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'please enter your Address';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                address = value;
                              },
                              decoration: textFormDecoration.copyWith(
                                  labelText: 'Address',
                                  hintText: 'Enter your Address'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: TextFormField(
                              controller: _passwordController,
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
                                          passwordVisible = !passwordVisible;
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
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'please enter confirm password';
                                } else if (value != _passwordController.text) {
                                  return 'password not matching';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                password = value;
                              },
                              //  controller: _passwordController,
                              obscureText: !conpasswordVisible,
                              decoration: textFormDecoration.copyWith(
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          conpasswordVisible =
                                              !conpasswordVisible;
                                        });
                                      },
                                      icon: Icon(
                                        conpasswordVisible
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: Colors.orange,
                                      )),
                                  labelText: 'Confirm Password',
                                  hintText: 'Enter Confirm Password'),
                            ),
                          ),
                          HaveAccount(
                            haveAccount: 'already have an account?',
                            actionLable: 'log In',
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()));
                            },
                          ),
                          processing == true
                              ? const CircularProgressIndicator(
                                  color: Colors.orange)
                              : AuthMainButton(
                                  mainButtonLable: 'Sign Up',
                                  onPressed: () {
                                    signUp();
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
    );
  }
}
