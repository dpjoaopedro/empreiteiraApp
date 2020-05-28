import 'package:empreiteiraApp/pages/main_app/main_app.dart';
import 'package:empreiteiraApp/providers/app_config_provider.dart';
import 'package:empreiteiraApp/providers/budget_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';


void main() {
  initializeDateFormatting('pt_BR', null).then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => new BudgetProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => new AppConfigProvider(),
        ),
      ],
      child: MainAppPage(),
    );
  }
}
