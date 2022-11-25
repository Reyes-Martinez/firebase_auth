import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_autentication/firebase/user_services.dart';
import 'package:firebase_autentication/provider/login_form_provider.dart';
import 'package:firebase_autentication/screens/home_page.dart';
import 'package:firebase_autentication/screens/profile_screen.dart';
import 'package:firebase_autentication/screens/theme_screen.dart';
import 'package:firebase_autentication/shared/preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../firebase/auth_services.dart';

class DashBorad extends StatefulWidget {
  const DashBorad({Key? key}) : super(key: key);

  @override
  State<DashBorad> createState() => _DashBoradState();
}

class _DashBoradState extends State<DashBorad> {
  Widget _page = HomeScreen();
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  singOut(authProvider) async {
    await authProvider.signOut().then((value) {
      Preference.user = "";
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    // final User user = ModalRoute.of(context)!.settings.arguments as User;
    final loginForm = Provider.of<LoginFormProvider>(context);
    final authProvider = Provider.of<AuthServices>(context);
    final userProvider = Provider.of<UserServices>(context);
    if (loginForm.recordar == true) {
      Preference.user = userProvider.userDAO.id!;
    }

    return SafeArea(
      child: Scaffold(
        extendBody: true,
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 60.0,
          items: const <Widget>[
            Icon(Icons.home, size: 30, color: (Colors.amber)),
            Icon(Icons.shopping_bag_outlined, size: 30, color: (Colors.amber)),
            Icon(Icons.palette, size: 30, color: (Colors.amber)),
            Icon(Icons.perm_identity, size: 30, color: (Colors.amber)),
            Icon(Icons.output, size: 30, color: (Colors.amber)),
          ],
          color: Colors.brown,
          buttonBackgroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              switch (index) {
                case 0:
                  _page = HomeScreen();
                  break;
                case 1:
                  _page = Center(child: Text('List'));
                  break;
                case 2:
                  _page = ThemeScreen();
                  break;
                case 3:
                  _page = ProfileScreen();
                  break;
                case 4:
                  singOut(authProvider);
                  break;
              }
            });
          },
          letIndexChange: (index) => true,
        ),
        // drawer: Theme(
        //   data: Theme.of(context).copyWith(
        //       canvasColor: Theme.of(context)
        //           .primaryColor //This will change the drawer background to blue.
        //       //other styles
        //       ),
        //   child: Drawer(
        //     child: ListView(
        //       children: [
        //         UserAccountsDrawerHeader(
        //           accountName: userProvider.userDAO.fullName!.isNotEmpty
        //               ? Text(userProvider.userDAO.fullName!)
        //               : const Text('No name'),
        //           accountEmail: userProvider.userDAO.email!.isNotEmpty
        //               ? Text(userProvider.userDAO.email!)
        //               : const Text('No email'),
        //           currentAccountPicture: Hero(
        //             tag: "hero",
        //             child: CircleAvatar(
        //               backgroundImage: userProvider.userDAO.image!.isNotEmpty
        //                   ? NetworkImage(userProvider.userDAO.image!)
        //                   : const NetworkImage(
        //                       'https://cdn-icons-png.flaticon.com/512/147/147144.png'),
        //             ),
        //           ),
        //           decoration: const BoxDecoration(
        //               image: DecorationImage(
        //             image: NetworkImage(
        //                 'https://p4.wallpaperbetter.com/wallpaper/243/559/623/space-circles-graphics-planet-wallpaper-preview.jpg'),
        //             fit: BoxFit.cover,
        //           )),
        //         ),
        //         ListTile(
        //           leading: const Icon(Icons.home),
        //           title: const Text('Home'),
        //           onTap: () {
        //             Navigator.pushNamed(context, '/home');
        //           },
        //           trailing: const Icon(Icons.chevron_right),
        //         ),
        //         ListTile(
        //           leading: const Icon(Icons.person),
        //           title: const Text('Profile'),
        //           onTap: () {
        //             Navigator.pushNamed(context, '/profile');
        //           },
        //           trailing: const Icon(Icons.chevron_right),
        //         ),
        //         ListTile(
        //           leading: const Icon(Icons.logout),
        //           title: Text('Logout ${authProvider.provider}'),
        //           onTap: () async {
        //             await authProvider.signOut().then((value) {
        //               Navigator.pushReplacementNamed(context, '/login');
        //             });
        //           },
        //           trailing: const Icon(Icons.chevron_right),
        //         ),
        //         ListTile(
        //           title: Text(
        //               'Ultumo inicio de sesion:\n${userProvider.userDAO.lastSignIn}'),
        //           onTap: () {},
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        body: _page,
      ),
    );
  }
}
