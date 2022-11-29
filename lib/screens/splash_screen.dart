import 'package:firebase_autentication/firebase/auth_services.dart';
import 'package:firebase_autentication/screens/screens.dart';
import 'package:firebase_autentication/shared/preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

import '../firebase/user_services.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  loadUser(context) async {
    final authProvider = Provider.of<AuthServices>(context);
    final userProvider = Provider.of<UserServices>(context);
    final user = await authProvider.getUser(Preference.user);
    userProvider.loadUser(user);
  }

  @override
  Widget build(BuildContext context) {
    if (Preference.user.isNotEmpty) {
      loadUser(context);
    }

    return SplashScreenView(
      navigateRoute: (Preference.user.isNotEmpty)
          ? const DashBorad()
          : const LoginScreen(),
      duration: 3000,
      imageSize: 330,
      imageSrc: "assets/Logo_coffee_linx.gif",
      //text: "Coffee Linx",
      //textType: TextType.ScaleAnimatedText,
      //textStyle: const TextStyle(fontSize: 30.0, color: Colors.black),
      backgroundColor: Colors.white,
    );
  }
}
