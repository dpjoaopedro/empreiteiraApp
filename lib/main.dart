import 'package:empreiteiraApp/providers/budget_provider.dart';
import 'package:empreiteiraApp/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/budget_form_page/budget_form_page.dart';
import 'pages/budget_list_page/budget_list_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => new BudgetProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.yellowAccent,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          AppRoutes.HOME: (ctx) => BudgetListPage(),
          AppRoutes.BUDGET: (ctx) => BudgetFormPage(),
        },
      ),
    );
  }
}