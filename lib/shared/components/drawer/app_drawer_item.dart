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
          leading: Icon(icon),
          title: Text(title),
          onTap: () {
            if (ModalRoute.of(context).settings.name != appRoute) {
              Navigator.of(context).popAndPushNamed(appRoute);
            } else {
              Navigator.of(context).pushReplacementNamed(appRoute);
             }
          },
        ),
        Divider()
      ],
    );
  }
}
