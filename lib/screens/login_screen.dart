import 'dart:async';

import 'package:firebase_autentication/firebase/auth_services.dart';
import 'package:firebase_autentication/models/user.dart';
import 'package:firebase_autentication/shared/preferences.dart';
import 'package:firebase_autentication/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

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
        const SizedBox(height: 70),
        CardContainer(
            child: Column(children: [
          Image.asset("assets/Logotipo.png"),
          Text('Bienvenido', style: Theme.of(context).textTheme.headline4),
          const _LoginForm(),
        ])),
        const SizedBox(
          height: 10,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 25),
            SocialLoginButton(
              borderRadius: 50,
              mode: SocialLoginButtonMode.single,
              buttonType: SocialLoginButtonType.generalLogin,
              text: 'Registrarse',
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
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'O iniciar sesión con:',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            backgroundColor: Color.fromARGB(255, 93, 76, 68),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SocialLoginButton(
                borderRadius: 50,
                mode: SocialLoginButtonMode.single,
                buttonType: SocialLoginButtonType.facebook,
                onPressed: () async {
                  UserDAO us = await authProvider.signInWithFacebook();
                  userServices.loadUser(us);
                  Navigator.pushReplacementNamed(context, '/onboarding');
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
                mode: SocialLoginButtonMode.single,
                borderRadius: 50,
                buttonType: SocialLoginButtonType.google,
                onPressed: () async {
                  UserDAO us = (await authProvider.signInWithGoogle())!;
                  userServices.loadUser(us);
                  Navigator.pushReplacementNamed(context, '/onboarding');
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
                  : "El valor ingresado no luce como un correo";
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
            color: Color.fromARGB(255, 168, 89, 36),
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
                      Navigator.pushReplacementNamed(context, '/onboarding');
                    } else {
                      btnController.error();
                      await Future.delayed(const Duration(seconds: 2));
                      btnController.reset();
                      loginForm.isLoading = false;
                    }
                  },
            child: const Text('Ingresar'),
          ),
          const Divider(color: Color.fromARGB(255, 168, 89, 36)),
          SwitchListTile.adaptive(
              value: loginForm.recordar,
              activeColor: Color.fromARGB(255, 168, 89, 36),
              onChanged: (value) {
                loginForm.recordar = value;
              },
              title: const Text(
                'Recordar credenciales',
                style: TextStyle(color: Colors.black, fontSize: 14),
              )),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
