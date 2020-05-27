import 'package:empreiteiraApp/providers/budget_provider.dart';
import 'package:empreiteiraApp/screens/budget_form_screen.dart';
import 'package:empreiteiraApp/screens/budget_list_screen.dart';
import 'package:empreiteiraApp/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          AppRoutes.HOME: (ctx) => BudgetListScreen(),
          AppRoutes.BUDGET: (ctx) => BudgetFormScreen(),
        },
      ),
    );
  }
}
