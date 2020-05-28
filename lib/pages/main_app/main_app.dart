import 'package:empreiteiraApp/pages/budget_form_page/budget_form_page.dart';
import 'package:empreiteiraApp/pages/budget_list_page/budget_list_page.dart';
import 'package:empreiteiraApp/pages/configuration_page/configuration_page.dart';
import 'package:empreiteiraApp/providers/app_config_provider.dart';
import 'package:empreiteiraApp/shared/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainAppPage extends StatefulWidget {
  @override
  _MainAppPageState createState() => _MainAppPageState();
}

class _MainAppPageState extends State<MainAppPage> {
  @override
  Widget build(BuildContext context) {
    var _themeIsDark =
        Provider.of<AppConfigProvider>(context).appConfig.themeIsDark;
    return _themeIsDark != null
        ? MaterialApp(
            theme: ThemeData(
              primarySwatch: Colors.green,
              accentColor: Colors.yellowAccent,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              brightness: _themeIsDark ? Brightness.dark : Brightness.light,
            ),
            debugShowCheckedModeBanner: false,
            home: BudgetListPage(),
            routes: {
              AppRoutes.BUDGET: (ctx) => BudgetFormPage(),
              AppRoutes.CONFIG: (ctx) => ConfigurationPage(),
            },
          )
        : MaterialApp(
            theme: ThemeData(
              primarySwatch: Colors.green,
              accentColor: Colors.yellowAccent,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              brightness:  Brightness.dark
            ),
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 15,
                    ),
                    Text('Carregando as configurações iniciais...')
                  ],
                ),
              ),
            ),
          );
  }
}
