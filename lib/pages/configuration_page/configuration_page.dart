import 'package:empreiteiraApp/providers/app_config_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConfigurationPage extends StatefulWidget {
  @override
  _ConfigurationPageState createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
  @override
  Widget build(BuildContext context) {
    final appConfigProvider = Provider.of<AppConfigProvider>(context);
    final appConfig = appConfigProvider.appConfig;
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
      ),
      body: ListView(
        padding: EdgeInsets.all(35),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Tema escuro', style: TextStyle(fontSize: 17),),
              Switch(
                value: appConfig.themeIsDark,
                onChanged: (value) => {appConfigProvider.changeTheme(value)},
              )
            ],
          )
        ],
      ),
    );
  }
}
