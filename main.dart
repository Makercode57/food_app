import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thebrandopedia_food_app/providers/cart_provider.dart';
import 'package:thebrandopedia_food_app/screens/order success screen.dart';
import 'package:thebrandopedia_food_app/screens/splash_screen.dart';
import 'package:thebrandopedia_food_app/screens/profile_screen.dart';
import 'package:thebrandopedia_food_app/screens/home_screen.dart';
import 'package:thebrandopedia_food_app/screens/cart_screen.dart';
import 'package:thebrandopedia_food_app/screens/check out screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: const MyFoodApp(),
    ),
  );
}

class MyFoodApp extends StatelessWidget {
  const MyFoodApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TheBrandopedia Food App',
      theme: ThemeData(primarySwatch: Colors.orange),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),  
      routes: {
        '/home': (context) => const HomeScreen(),
        '/cart': (context) => CartScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/order-success': (context) => const OrderSuccessScreen(),
        '/checkout': (context) => const CheckoutScreen(),
      },
    );
  }
}
