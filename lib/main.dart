import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_provider/authentication_screens/sign_up.dart';
import 'package:firebase_provider/providers/cart_provider.dart';
import 'package:firebase_provider/providers/id_provider.dart';
import 'package:firebase_provider/providers/wish_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: 'AIzaSyAGEimL56Kip1RknYkZQHTfgcis_dZ_zJw',
        appId: '1:297768110531:web:6bd4579757f705391ed576',
        messagingSenderId: '297768110531',
        projectId: 'fir-provider-293f2'),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CartProvider>(
          create: (_) => CartProvider(),
        ),
        ChangeNotifierProvider<WishProvider>(
          create: (_) => WishProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => IdProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Firebase Provider',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
          useMaterial3: true,
        ),
        home: const SignUpScreen(),
      ),
    );
  }
}
