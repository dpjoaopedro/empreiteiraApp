import 'package:empreiteiraApp/utils/app_routes.dart';
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
          Divider(),
          ListTile(
            leading: Icon(Icons.attach_money),
            title: Text('Orçamentos'),
            onTap: () {
              Navigator.of(context).popAndPushNamed(AppRoutes.HOME);
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
