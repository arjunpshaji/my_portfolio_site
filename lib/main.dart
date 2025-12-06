import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:my_portfolio/modules/home/home_page.dart';
import 'package:my_portfolio/theme/app_theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart';
import 'package:my_portfolio/providers/portfolio_provider.dart';

void main() async {
  print("🚀 App Starting...");
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: ".env");
    print("✅ DotEnv loaded");

    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL']!,
      anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
    );
    print("✅ Supabase initialized");

    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => PortfolioProvider()..loadData(),
          ),
        ],
        child: const PortfolioApp(),
      ),
    );
  } catch (e, stack) {
    print("🔥 Critical Error during startup: $e");
    print(stack);
  }
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
