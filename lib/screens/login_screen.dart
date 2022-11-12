import 'dart:async';

import 'package:firebase_autentication/firebase/auth_services.dart';
import 'package:firebase_autentication/models/user.dart';
import 'package:firebase_autentication/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

import '../decorations/input_decorations.dart';
import '../firebase/user_services.dart';
import '../provider/login_form_provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthServices>(context);
    final userServices = Provider.of<UserServices>(context);

    return Scaffold(
        body: AuthBackground(
            child: SingleChildScrollView(
      child: Column(children: [
        const SizedBox(height: 180),
        CardContainer(
            child: Column(children: [
          Text('Login', style: Theme.of(context).textTheme.headline4),
          const _LoginForm(),
        ])),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'O puede iniciar sesion con:',
          style: TextStyle(fontSize: 20, color: Colors.brown),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const SizedBox(height: 25),
              SocialLoginButton(
                buttonType: SocialLoginButtonType.generalLogin,
                text: 'Sing Up',
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/register',
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              SocialLoginButton(
                borderRadius: 10,
                buttonType: SocialLoginButtonType.facebook,
                onPressed: () async {
                  UserDAO us = await authProvider.signInWithFacebook();
                  userServices.loadUser(us);
                  Navigator.pushReplacementNamed(context, '/home');
                },
              ),
              const SizedBox(
                height: 10,
              ),
              // github(authProvider: authProvider),
              const SizedBox(
                height: 10,
              ),
              SocialLoginButton(
                borderRadius: 10,
                buttonType: SocialLoginButtonType.google,
                onPressed: () async {
                  UserDAO us = (await authProvider.signInWithGoogle())!;
                  userServices.loadUser(us);
                  Navigator.pushReplacementNamed(context, '/home');
                },
              ),
            ],
          ),
        )
      ]),
    )));
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({super.key});
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    final authProvider = Provider.of<AuthServices>(context);
    final userServices = Provider.of<UserServices>(context);

    final RoundedLoadingButtonController btnController =
        RoundedLoadingButtonController();

    return Form(
      key: loginForm.formkey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            style: const TextStyle(color: Colors.black),
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecorations(
                labelText: 'Correo electronico',
                prefixIcon: Icons.alternate_email_sharp),
            onChanged: (value) => loginForm.email = value,
            validator: (value) {
              String pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp = RegExp(pattern);
              return regExp.hasMatch(value ?? '')
                  ? null
                  : "El valor ingresado noluce com un correo";
            },
          ),
          const SizedBox(
            height: 30,
          ),
          TextFormField(
              style: const TextStyle(color: Colors.black),
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.text,
              decoration: InputDecorations.authInputDecorations(
                  labelText: 'Contraseña', prefixIcon: Icons.lock_outline),
              onChanged: (value) => loginForm.password = value,
              validator: (value) {
                return (value != null) && (value.length >= 6)
                    ? null
                    : 'La contraseña debe ser de 6 caracteres';
              }),
          const SizedBox(
            height: 30,
          ),
          RoundedLoadingButton(
            color: Color.fromARGB(255, 185, 0, 121),
            borderRadius: 10,
            controller: btnController,
            errorColor: Colors.red,
            onPressed: loginForm.isLoading
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    if (!loginForm.isValidForm()) {
                      btnController.error();
                      await Future.delayed(const Duration(seconds: 2));
                      btnController.reset();
                    }
                    loginForm.isLoading = true;
                    await Future.delayed(const Duration(seconds: 2));
                    UserDAO us = await authProvider.signInWithEmailAndPassword(
                        email: loginForm.email, password: loginForm.password);
                    if (us != null) {
                      loginForm.isLoading = false;
                      userServices.loadUser(us);
                      Navigator.pushReplacementNamed(context, '/home');
                    } else {
                      btnController.error();
                      await Future.delayed(const Duration(seconds: 2));
                      btnController.reset();
                      loginForm.isLoading = false;
                    }
                  },
            child: const Text('Ingresar'),
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
