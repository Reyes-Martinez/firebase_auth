import 'package:firebase_autentication/provider/theme_provider.dart';
import 'package:firebase_autentication/shared/preferences.dart';
import 'package:firebase_autentication/themes/styles_settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeScreen extends StatelessWidget {
  const ThemeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeProvider tema = Provider.of<ThemeProvider>(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton.icon(
            onPressed: () {
              Preference.theme = 'temaDia';
              tema.setthemeData(temaDia());
            },
            icon: const Icon(Icons.sunny, color: Colors.grey, size: 50),
            label: const Text('Tema de Día',
                style: TextStyle(color: Colors.grey, fontSize: 22)),
          ),
          TextButton.icon(
            onPressed: () {
              Preference.theme = 'temaNoche';
              tema.setthemeData(temaNoche());
            },
            icon: const Icon(
              Icons.mode_night_outlined,
              color: Colors.black,
              size: 50,
            ),
            label: const Text('Tema de Noche',
                style: TextStyle(color: Colors.black, fontSize: 22)),
          ),
          TextButton.icon(
            onPressed: () {
              Preference.theme = 'temaCapucchino';
              tema.setthemeData(temaCapucchino());
            },
            icon: const Icon(
              Icons.coffee,
              color: Color.fromARGB(255, 239, 182, 135),
              size: 50,
            ),
            label: const Text('Tema Capucchino',
                style: TextStyle(
                    color: Color.fromARGB(255, 216, 184, 147), fontSize: 22)),
          ),
          TextButton.icon(
            onPressed: () {
              Preference.theme = 'temaExpresso';
              tema.setthemeData(temaExpresso());
              print('Expresso');
            },
            icon: const Icon(
              Icons.coffee_maker,
              color: Colors.brown,
              size: 50,
            ),
            label: Text(
              'Tema Expresso',
              style: TextStyle(color: Colors.brown.shade400, fontSize: 22),
            ),
          ),
        ],
      ),
    );
  }
}
