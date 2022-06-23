import 'package:flutter/material.dart';
import 'package:kalkulator_plts/app/ui/ProductList.dart';
import 'package:kalkulator_plts/app/ui/home_page.dart';
import 'package:kalkulator_plts/app/ui/onboarding_page.dart';
import 'package:kalkulator_plts/app/ui/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => const SplashScreen(),
        '/onboarding': (context) => const OnboardingPage(),
        '/home': (context) => const HomePage(),
        '/productList': (context) => const ProductList(),
      },
    );
  }
}
