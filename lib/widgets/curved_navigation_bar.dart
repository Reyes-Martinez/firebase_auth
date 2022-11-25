import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/ui_provider.dart';

class ButtomNabVar extends StatelessWidget {
  const ButtomNabVar({super.key});

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);

    GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

    return CurvedNavigationBar(
      key: _bottomNavigationKey,
      index: 0,
      height: 60.0,
      items: const <Widget>[
        Icon(Icons.color_lens, size: 30),
        Icon(Icons.shopping_bag_outlined, size: 30),
        Icon(Icons.home, size: 30),
        Icon(Icons.perm_identity, size: 30),
        Icon(Icons.logout, size: 30),
      ],
      color: Colors.white,
      buttonBackgroundColor: Colors.white,
      backgroundColor: Colors.blueAccent,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 600),
      onTap: (index) => uiProvider.selectedMenuOpt = index,
      letIndexChange: (index) => true,
    );
  }
}
