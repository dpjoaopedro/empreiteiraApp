import 'package:empreiteiraApp/components/app_drawer_item.dart';
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
          AppDrawerItem(title: 'Orçamentos', icon: Icons.attach_money, appRoute: AppRoutes.HOME),
        ],
      ),
    );
  }
}

