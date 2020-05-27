import 'package:empreiteiraApp/components/modal_yes_no.dart';
import 'package:empreiteiraApp/models/budget.dart';
import 'package:flutter/material.dart';

class BudgetFormScreen extends StatefulWidget {
  @override
  _BudgetFormScreenState createState() => _BudgetFormScreenState();
}

class _BudgetFormScreenState extends State<BudgetFormScreen> {
  final _formData = Map<String, Object>();
  bool _isEditing = false;

  void _saveBudget() {
    showDialog(
      context: context,
      builder: (context) {
        return ModalYesNo(
            title: 'Atenção', content: 'Deseja salvar o orçamento?');
      },
    ).then((value) {
      //IMPLEMENT
    });
  }

  void _deleteBudget() {
    showDialog(
      context: context,
      builder: (context) {
        return ModalYesNo(
            title: 'Atenção', content: 'Deseja deletar o orçamento?');
      },
    ).then((value) {
      //IMPLEMENT
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_formData.isEmpty) {
      final budget = ModalRoute.of(context).settings.arguments as Budget;
      if (budget == null) { return; }
      _isEditing = true;
      _formData['id'] = budget.id;
      _formData['title'] = budget.title;
      _formData['price'] = budget.price;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar/Novo'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveBudget,
          ),
          if (_isEditing)
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: _deleteBudget,
          ),
        ],
      ),
      body: Form(
        child: ListView(
          children: <Widget>[],
        ),
      ),
    );
  }
}