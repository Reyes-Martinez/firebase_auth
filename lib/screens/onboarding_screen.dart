import 'package:firebase_autentication/provider/theme_provider.dart';
import 'package:firebase_autentication/shared/preferences.dart';
import 'package:firebase_autentication/themes/styles_settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider tema = Provider.of<ThemeProvider>(context);

    return Scaffold(
        body: Container(
          padding: const EdgeInsets.only(bottom: 80),
          child: PageView(
              controller: controller,
              onPageChanged: (index) {
                setState(() {
                  isLastPage = index == 2;
                });
              },
              children: [
                Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Bienvenido a Coffee Linx',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        const Divider(),
                        Image.asset(
                          'assets/CoffeeCup.png',
                          fit: BoxFit.cover,
                          width: 250,
                        ),
                        const Divider(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: const Text(
                            'Hola querido usuari@, esta aplicación “Coffee Linx” fue desarrollada por 2 alumnos del TecNM en Celaya (Martínez Arriaga Reyes Manuel y Ponce Ramírez Emmanuel) para que puedas pedir tu comida y/o bebida favorita en la cafetería y solo tengas que acercarte a la barra para recoger tus alimentos sin necesidad de que hagas fila, solo pides y nosotros te avisamos cuando esté listo.',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    )),
                Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Selecciona el tema que prefieras',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const Divider(),
                        Image.asset(
                          'assets/coffee-cup.png',
                          fit: BoxFit.cover,
                          width: 250,
                        ),
                        const SizedBox(height: 14),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton.icon(
                              onPressed: () {
                                Preference.theme = 'temaDia';
                                tema.setthemeData(temaDia());
                              },
                              icon: const Icon(Icons.sunny,
                                  color: Colors.grey, size: 50),
                              label: const Text('Tema Claro',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 22)),
                            ),
                            TextButton.icon(
                              onPressed: () {
                                Preference.theme = 'temaNoche';

                                tema.setthemeData(temaNoche());
                              },
                              icon: const Icon(Icons.mode_night_outlined,
                                  color: Colors.black, size: 50),
                              label: const Text('Tema Oscuro',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 22)),
                            ),
                            TextButton.icon(
                              onPressed: () {
                                Preference.theme = 'temaCapucchino';

                                tema.setthemeData(temaCapucchino());
                              },
                              icon: const Icon(Icons.coffee,
                                  color: Color.fromARGB(255, 239, 182, 135),
                                  size: 50),
                              label: const Text('Tema Capucchino',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 216, 184, 147),
                                      fontSize: 22)),
                            ),
                            TextButton.icon(
                              onPressed: () {
                                Preference.theme = 'temaExpresso';
                                tema.setthemeData(temaExpresso());
                              },
                              icon: const Icon(Icons.coffee_maker,
                                  color: Colors.brown, size: 50),
                              label: Text(
                                'Tema Expresso',
                                style: TextStyle(
                                    color: Colors.brown.shade400, fontSize: 22),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
                Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Te deseamos la mejor experiencia tanto en la aplicación como en la cafetería, siempre eres bienvenid@ Lince.',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const Divider(),
                        Image.asset(
                          'assets/Tecnm.png',
                          fit: BoxFit.cover,
                          width: 260,
                        ),
                      ],
                    )),
              ]),
        ),
        bottomSheet: isLastPage
            ? TextButton(
                onPressed: () {
                  //TODO mostrar el onboarding solo una vez
                  Preference.showOnboardin = false;
                  Navigator.pushNamed(context, '/home');
                },
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Theme.of(context).primaryColor,
                  minimumSize: const Size(double.infinity, 80),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)),
                ),
                child: const Text('COMENZAR'),
              )
            : Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                color: Theme.of(context).primaryColor,
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      child: const Text(
                        'SALTAR',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        controller.jumpToPage(2);
                      },
                    ),
                    Center(
                      child: SmoothPageIndicator(
                        controller: controller,
                        count: 3,
                        effect: const WormEffect(
                            spacing: 16,
                            dotColor: Colors.grey,
                            activeDotColor: Colors.white38),
                        onDotClicked: (index) => controller.animateToPage(index,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn),
                      ),
                    ),
                    TextButton(
                      child: const Text('SIGUIENTE',
                          style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut);
                      },
                    ),
                  ],
                ),
              ));
  }
}

class _Sider extends StatelessWidget {
  const _Sider({
    Key? key,
    required this.titel,
    required this.content,
    this.image,
    required this.color,
    this.buttons,
  }) : super(key: key);
  final String titel;
  final String content;
  final String? image;
  final Color? color;
  final Widget? buttons;
  @override
  Widget build(BuildContext context) {
    return Container(
        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(titel),
          ],
        ));
  }
}
