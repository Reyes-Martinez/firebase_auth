import 'package:firebase_autentication/provider/alimentos_provider.dart';
import 'package:firebase_autentication/widgets/alimentos_slider.dart';
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
            left: 1.0,
            right: 1.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 30.0,
                    right: 30.0,
                    top: 20.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Coffee Linx",
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
                        radius: 55.0,
                      ),
                    ],
                  ),
                ),
                const Divider(),
                const Center(
                  child: Text(
                    '¿Qué se te antoja hoy?',
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const Divider(),
                Column(
                  children: [
                    Text(''),
                    AlimentosSlider(
                      alimentos: alimentosProvider.comidas,
                      onNextPage: () {},
                      title: 'Alimentos',
                    ),
                    const Divider(),
                    AlimentosSlider(
                      alimentos: alimentosProvider.bebidas,
                      onNextPage: () {},
                      title: 'Bebidas',
                    ),
                    const Divider(),
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
