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
                  isLastPage = index == 3;
                });
              },
              children: [
                Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Welcome to the aplication',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 14),
                        Image.asset(
                          'assets/logo.png',
                          fit: BoxFit.cover,
                          width: 150,
                        ),
                        const SizedBox(height: 14),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: const Text(
                            'Ipsum nostrud veniam ullamco est cupidatat ullamco ut est. Quis id dolor ea quis culpa magna in anim est commodo nulla esse. Anim minim laborum exercitation dolore aliqua pariatur commodo et Lorem. Quis voluptate irure elit cupidatat Lorem laborum incididunt do velit id. Voluptate duis id est aliqua duis laboris incididunt occaecat amet anim aliquip do. Pariatur voluptate reprehenderit exercitation aute nisi enim non.',
                          ),
                        ),
                        const SizedBox(height: 40),
                        Image.asset(
                          'assets/logo.png',
                          fit: BoxFit.cover,
                          width: 60,
                        ),
                        const Text('Tap on next button')
                      ],
                    )),
                Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Selected theme',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 14),
                        Image.asset(
                          'assets/logo.png',
                          fit: BoxFit.cover,
                          width: 150,
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
                              icon: const Icon(Icons.sunny, color: Colors.grey),
                              label: const Text('Tema de Día',
                                  style: TextStyle(color: Colors.grey)),
                            ),
                            TextButton.icon(
                              onPressed: () {
                                Preference.theme = 'temaNoche';

                                tema.setthemeData(temaNoche());
                              },
                              icon: const Icon(Icons.mode_night_outlined,
                                  color: Colors.black),
                              label: const Text('Tema de Noche',
                                  style: TextStyle(color: Colors.black)),
                            ),
                            TextButton.icon(
                              onPressed: () {
                                Preference.theme = 'temaAzul';

                                tema.setthemeData(temaAzul());
                              },
                              icon: const Icon(Icons.water, color: Colors.blue),
                              label: Text('Tema Azul',
                                  style:
                                      TextStyle(color: Colors.blue.shade400)),
                            ),
                            TextButton.icon(
                              onPressed: () {
                                Preference.theme = 'temaVerde';
                                tema.setthemeData(temaVerde());
                              },
                              icon: const Icon(
                                Icons.wb_twilight_sharp,
                                color: Colors.green,
                              ),
                              label: Text(
                                'Tema Verde',
                                style: TextStyle(color: Colors.green.shade400),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Image.asset(
                          'assets/logo.png',
                          fit: BoxFit.cover,
                          width: 60,
                        ),
                        const Text('Tap on next button')
                      ],
                    )),
                Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Etid your profile',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 14),
                        Image.asset(
                          'assets/logo.png',
                          fit: BoxFit.cover,
                          width: 240,
                        ),
                        const SizedBox(height: 14),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: const Text(
                              'You can edit your profile after you are lgin'),
                        ),
                        const SizedBox(height: 40),
                      ],
                    )),
                Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Movies',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 14),
                        Image.asset(
                          'assets/logo.png',
                          fit: BoxFit.cover,
                          width: 240,
                        ),
                        const SizedBox(height: 40),
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
                child: const Text('Get Satarted'),
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
                        'SKIP',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        controller.jumpToPage(3);
                      },
                    ),
                    Center(
                      child: SmoothPageIndicator(
                        controller: controller,
                        count: 4,
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
                      child: const Text('NEXT',
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
