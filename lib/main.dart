import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_ecommerce/routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  final url = dotenv.get('SUPABASE_URL');
  final annonKey = dotenv.get('SUPABASE_ANNONKEY');
  await Supabase.initialize(
    url: url,
    anonKey: annonKey,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "Flutter Ecommerce",
      routerConfig: AppRoute.route,
      theme:
          ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber)),
    );
  }
}
