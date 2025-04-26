import 'package:flutter/material.dart';
import 'package:my_portfolio/modules/home/home_page.dart';
import 'package:my_portfolio/theme/app_theme.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Arjun P Shaji',
      debugShowCheckedModeBanner: false,
      theme: getAppTheme(context),
      home: const HomePage(),
    );
  }
}
