import 'package:empreiteiraApp/shared/components/drawer/app_drawer_item.dart';
import 'package:empreiteiraApp/shared/utils/app_routes.dart';
import 'package:flutter/material.dart';

class AppDrawerWidget extends StatelessWidget {
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
          AppDrawerItemWidget(title: 'Orçamentos', icon: Icons.attach_money, appRoute: AppRoutes.HOME),
          AppDrawerItemWidget(title: 'Configurações', icon: Icons.settings, appRoute: AppRoutes.CONFIG),
        ],
      ),
    );
  }
}

