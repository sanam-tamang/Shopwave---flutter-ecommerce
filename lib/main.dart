import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_ecommerce/core/blocs/user_local_data/user_local_data_bloc.dart';
import 'package:flutter_ecommerce/dependency_injection.dart';
import 'package:flutter_ecommerce/features/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter_ecommerce/features/category/blocs/category_bloc/category_bloc.dart';
import 'package:flutter_ecommerce/features/user/blocs/user_bloc/user_bloc.dart';
import 'package:flutter_ecommerce/routes.dart';
import 'package:google_fonts/google_fonts.dart';
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

  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<AuthBloc>()),
        BlocProvider(create: (context) => sl<CategoryBloc>()),
        BlocProvider(
            create: (context) =>
                sl<UserLocalDataBloc>()..add(UserLocalDataEvent.get())),
        BlocProvider(
            create: (context) =>
                sl<UserBloc>()..add(UserEvent.getCurrentUserData())),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: "Flutter Ecommerce",
        routerConfig: AppRoute.route,
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: const Color.fromARGB(255, 253, 62, 4)),
            textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme)),
      ),
    );
  }
}
