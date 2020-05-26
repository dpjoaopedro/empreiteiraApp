import 'package:empreiteiraApp/components/app_drawer.dart';
import 'package:flutter/material.dart';

class BudgetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orçamentos'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          return Text('Implementing');
        },
      ),
    );
  }
}
