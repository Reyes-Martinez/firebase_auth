import 'package:firebase_autentication/provider/alimentos_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../firebase/user_services.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserServices>(context);
    final alimentosProvider = Provider.of<AlimentosProvider>(context);

    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 30.0,
            right: 30.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "CoffeLinx",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.brown,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                    CircleAvatar(
                      backgroundImage: userProvider.userDAO.image!.isNotEmpty
                          ? NetworkImage(userProvider.userDAO.image!)
                          : const NetworkImage(
                              'https://cdn-icons-png.flaticon.com/512/147/147144.png'),
                      backgroundColor: Colors.white,
                      radius: 50.0,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25.0,
                ),
                const Text(
                  'Coffee Products',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                Column(
                  children: [
                    Row(),
                    SizedBox(
                      height: 25.0,
                    ),
                    Row(),
                    SizedBox(
                      height: 25.0,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
