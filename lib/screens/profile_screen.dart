import 'dart:io';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:firebase_autentication/decorations/input_decorations.dart';
import 'package:firebase_autentication/firebase/user_services.dart';
import 'package:firebase_autentication/shared/preferences.dart';
import 'package:firebase_autentication/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../firebase/auth_services.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProfileBackground(
        child: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const _Image(),
          const SizedBox(
            height: 20,
          ),
          CardContainer(
            child: Column(children: const [
              SizedBox(height: 10),
              _ProfileFrom(),
            ]),
          ),
          const SizedBox(
            height: 70,
          ),
        ],
      ),
    ));
  }
}

class _Image extends StatelessWidget {
  const _Image({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<UserServices>(context);
    final picker = ImagePicker();
    return Column(
      children: [
        Hero(
          tag: "hero",
          child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: profile.userDAO.image != ""
                  ? Image(
                      height: 200,
                      width: 220,
                      fit: BoxFit.cover,
                      image: NetworkImage(profile.userDAO.image!),
                    )
                  : const Image(
                      height: 200,
                      width: 220,
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'https://cdn-icons-png.flaticon.com/512/147/147144.png'),
                    )),
        ),
        ImageControls(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () async {
                    final XFile? pickedFile = await picker.pickImage(
                        source: ImageSource.camera, imageQuality: 100);
                    if (pickedFile != null) {
                      print('Path ${pickedFile.path}');
                      File image = File(pickedFile.path);
                      profile.selectImage(image);
                    }
                  },
                  icon: const Icon(Icons.camera,
                      color: Color.fromARGB(255, 12, 51, 228))),
              IconButton(
                  onPressed: () async {
                    final XFile? pickedFile = await picker.pickImage(
                        source: ImageSource.gallery, imageQuality: 100);
                    if (pickedFile != null) {
                      print(pickedFile.path);
                      File image = File(pickedFile.path);
                      profile.selectImage(image);
                    }
                  },
                  icon: const Icon(Icons.image_search,
                      color: Color.fromARGB(255, 12, 51, 228))),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProfileFrom extends StatelessWidget {
  const _ProfileFrom({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthServices>(context);

    final profile = Provider.of<UserServices>(context);
    final RoundedLoadingButtonController btnController =
        RoundedLoadingButtonController();
    return Form(
      key: profile.formkey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            style: const TextStyle(color: Colors.black),
            autocorrect: false,
            initialValue:
                profile.userDAO.fullName != "" ? profile.userDAO.fullName : "",
            keyboardType: TextInputType.text,
            decoration: InputDecorations.authInputDecorations(
                labelText: 'Full name', prefixIcon: Icons.person_pin),
            onChanged: (value) => profile.userDAO.fullName = value,
          ),
          const SizedBox(
            height: 30,
          ),
          TextFormField(
            style: const TextStyle(color: Colors.black),
            autocorrect: false,
            initialValue:
                profile.userDAO.email != "" ? profile.userDAO.email : "",
            keyboardType: TextInputType.text,
            decoration: InputDecorations.authInputDecorations(
                // hintText: 'example@example.com',
                labelText: 'Email',
                prefixIcon: Icons.alternate_email_sharp),
            onChanged: (value) => profile.userDAO.email = value,
          ),
          const SizedBox(
            height: 30,
          ),
          TextFormField(
            style: const TextStyle(color: Colors.black),
            autocorrect: false,
            initialValue:
                profile.userDAO.phone != "" ? profile.userDAO.phone : "",
            keyboardType: TextInputType.phone,
            decoration: InputDecorations.authInputDecorations(
                // hintText: '******',
                labelText: 'Number phone',
                prefixIcon: Icons.phone),
            onChanged: (value) => profile.userDAO.phone = value,
          ),
          const SizedBox(
            height: 30,
          ),
          RoundedLoadingButton(
            color: Color.fromARGB(255, 185, 0, 121),
            borderRadius: 10,
            controller: btnController,
            errorColor: Colors.red,
            onPressed: profile.isLoading
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    if (!profile.isValidForm()) {
                      btnController.error();
                      await Future.delayed(const Duration(seconds: 2));
                      btnController.reset();
                      return;
                    }
                    profile.isLoading = true;
                    profile.updateUser();
                    ElegantNotification.success(
                            title: const Text("Actualizado"),
                            description: const Text(
                                "Tu información se actualizo correctamente"))
                        .show(context);
                    await Future.delayed(const Duration(seconds: 2));
                    btnController.reset();
                    profile.isLoading = false;
                  },
            child: const Text('Save'),
          ),
          IconButton(
              onPressed: () async {
                await authProvider.signOut().then((value) {
                  Preference.user = "";
                  Navigator.pushReplacementNamed(context, '/login');
                });
              },
              icon: const Icon(Icons.logout))
        ],
      ),
    );
  }
}
