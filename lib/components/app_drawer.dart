import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Center(child: Text('Menu')),
            automaticallyImplyLeading: false,
          ),
        ],
      ),
    );
  }
}
