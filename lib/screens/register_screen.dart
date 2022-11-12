import 'package:firebase_autentication/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../decorations/input_decorations.dart';
import '../firebase/auth_services.dart';
import '../provider/login_form_provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AuthBackground(
            child: SingleChildScrollView(
      child: Column(children: [
        const SizedBox(height: 180),
        CardContainer(
            child: Column(children: [
          Text('Register', style: Theme.of(context).textTheme.headline4),
          ChangeNotifierProvider(
              create: (_) => LoginFormProvider(), child: const _RegisterForm())
        ])),
      ]),
    )));
  }
}

class _RegisterForm extends StatefulWidget {
  const _RegisterForm({super.key});

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
  AuthServices? _emailAuth;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailAuth = AuthServices();
  }

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);

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
                    _emailAuth!
                        .createUserWithEmailAndPassword(
                            email: loginForm.email,
                            password: loginForm.password)
                        .then((value) {
                      print(value);
                    });
                    loginForm.isLoading = false;
                    Navigator.pushReplacementNamed(context, '/login');
                  },
            child: const Text('crear'),
          ),
          const Divider(color: Color.fromARGB(255, 185, 0, 121)),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
