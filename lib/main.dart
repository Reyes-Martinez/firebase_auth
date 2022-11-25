import 'package:firebase_autentication/firebase/auth_services.dart';
import 'package:firebase_autentication/firebase/user_services.dart';
import 'package:firebase_autentication/provider/alimentos_provider.dart';
import 'package:firebase_autentication/provider/login_form_provider.dart';
import 'package:firebase_autentication/provider/profile_provider.dart';
import 'package:firebase_autentication/screens/onboarding_screen.dart';
import 'package:firebase_autentication/screens/screens.dart';
import 'package:firebase_autentication/screens/splash_screen.dart';
import 'package:firebase_autentication/shared/preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Preference.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => LoginFormProvider()),
      ChangeNotifierProvider(create: (_) => AuthServices()),
      ChangeNotifierProvider(create: (_) => ProfileProvider()),
      ChangeNotifierProvider(create: (_) => UserServices()),
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ChangeNotifierProvider(
        create: (_) => AlimentosProvider(),
      )
    ], child: const _APP());
  }
}

class _APP extends StatelessWidget {
  const _APP({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeProvider tema = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: tema.getthemeData(),
      routes: {
        '/login': (_) => const LoginScreen(),
        '/home': (_) => const DashBorad(),
        '/register': (_) => const RegisterScreen(),
        '/profile': (_) => const ProfileScreen(),
        '/splash': (_) => const SplashScreen(),
        '/onboarding': (_) => const OnboardingScreen(),
      },
      initialRoute: '/splash',
    );
  }
}
