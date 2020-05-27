import 'package:empreiteiraApp/utils/app_routes.dart';
import 'package:flutter/material.dart';

class AppDrawerItemWidget extends StatelessWidget {
  final String title;
  final String appRoute;
  final IconData icon;

  const AppDrawerItemWidget({
    @required this.title,
    @required this.icon,
    @required this.appRoute,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.attach_money),
          title: Text('Orçamentos'),
          onTap: () {
            Navigator.of(context).popAndPushNamed(AppRoutes.HOME);
          },
        ),
        Divider()
      ],
    );
  }
}
