import 'package:firebase_autentication/firebase/user_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../firebase/auth_services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final User user = ModalRoute.of(context)!.settings.arguments as User;
    final authProvider = Provider.of<AuthServices>(context);
    final userProvider = Provider.of<UserServices>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      drawer: Theme(
        data: Theme.of(context).copyWith(
            canvasColor: Theme.of(context)
                .primaryColor //This will change the drawer background to blue.
            //other styles
            ),
        child: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: userProvider.userDAO.fullName!.isNotEmpty
                    ? Text(userProvider.userDAO.fullName!)
                    : const Text('No name'),
                accountEmail: userProvider.userDAO.email!.isNotEmpty
                    ? Text(userProvider.userDAO.email!)
                    : const Text('No email'),
                currentAccountPicture: Hero(
                  tag: "hero",
                  child: CircleAvatar(
                    backgroundImage: userProvider.userDAO.image!.isNotEmpty
                        ? NetworkImage(userProvider.userDAO.image!)
                        : const NetworkImage(
                            'https://cdn-icons-png.flaticon.com/512/147/147144.png'),
                  ),
                ),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: NetworkImage(
                      'https://p4.wallpaperbetter.com/wallpaper/243/559/623/space-circles-graphics-planet-wallpaper-preview.jpg'),
                  fit: BoxFit.cover,
                )),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pushNamed(context, '/home');
                },
                trailing: const Icon(Icons.chevron_right),
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Profile'),
                onTap: () {
                  Navigator.pushNamed(context, '/profile');
                },
                trailing: const Icon(Icons.chevron_right),
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: Text('Logout ${authProvider.provider}'),
                onTap: () async {
                  await authProvider.signOut().then((value) {
                    Navigator.pushReplacementNamed(context, '/login');
                  });
                },
                trailing: const Icon(Icons.chevron_right),
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Text("Se inicion sesion con ${authProvider.provider}"),
      ),
    );
  }
}
