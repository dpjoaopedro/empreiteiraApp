import 'dart:math';

import 'package:empreiteiraApp/models/budget_item_model.dart';
import 'package:empreiteiraApp/models/budget_model.dart';
import 'package:empreiteiraApp/models/client_model.dart';
import 'package:empreiteiraApp/models/payment_item_model.dart';
import 'package:empreiteiraApp/providers/budget_provider.dart';
import 'package:empreiteiraApp/shared/components/modal_yes_no/modal_yes_no.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/budget_floating_buttons.dart';

class BudgetFormPage extends StatefulWidget {
  @override
  _BudgetFormScreenState createState() => _BudgetFormScreenState();
}

class _BudgetFormScreenState extends State<BudgetFormPage> {
  final _clientFocusNode = FocusNode();
  final _materialsAndToolsFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();
  final _codFocusNode = FocusNode();
  final _serviceFocusNode = FocusNode();
  final _paymentFocusNode = FocusNode();
  final _formData = Map<String, Object>();
  final _form = GlobalKey<FormState>();
  final _budgetServiceController = TextEditingController();
  final _budgetPaymentController = TextEditingController();
  BudgetFormStatus status = BudgetFormStatus.description;
  BudgetModel budget = BudgetModel(
      title: '',
      price: 0.00,
      materialsAndTools: 'Materiais e ferramentas por conta do contratante',
      date: DateTime.now(),
      client: new ClientModel(name: '', cod: ''),
      items: new List<BudgetItemModel>(),
      payments: new List<PaymentItemModel>());

  bool _isEditing = false;

  void _saveBudget(BudgetModel budget) {
    showDialog(
      context: context,
      builder: (ctx) {
        return ModalYesNoWidget(
            title: 'Atenção', content: 'Deseja salvar o orçamento?');
      },
    ).then((value) {
      if (value) {
        var isValid = _form.currentState.validate();
        if (!isValid) return;
        _form.currentState.save();
        var provider = Provider.of<BudgetProvider>(context, listen: false);
        provider.addBudget(budget);
        Navigator.of(context).pop();
      }
    });
  }

  void _deleteBudget() {
    showDialog(
      context: context,
      builder: (context) {
        return ModalYesNoWidget(
            title: 'Atenção', content: 'Deseja excluir o orçamento?');
      },
    ).then((value) {
      if (value) {
        var provider = Provider.of<BudgetProvider>(context, listen: false);
        provider.removeBudget(budget.id);
        Navigator.of(context).pop();
      }
    });
  }

  void onNavigateNext() {
    setState(() {
      if (status == BudgetFormStatus.description) {
        status = BudgetFormStatus.adding_items;
        return;
      }
      if (status == BudgetFormStatus.adding_items) {
        status = BudgetFormStatus.adding_payments;
        return;
      }
    });
  }

  void onNavigateBack() {
    setState(() {
      if (status == BudgetFormStatus.adding_payments) {
        status = BudgetFormStatus.adding_items;
        return;
      }
      if (status == BudgetFormStatus.adding_items) {
        status = BudgetFormStatus.description;
        return;
      }
    });
  }

  @override
  void dispose() {
    _budgetPaymentController.dispose();
    _budgetServiceController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_formData.isEmpty) {
      final loadedBudget =
          ModalRoute.of(context).settings.arguments as BudgetModel;
      if (loadedBudget == null) return;
      budget = loadedBudget.copy();
      _isEditing = true;
      _formData['id'] = budget.id;
      _formData['title'] = budget.title;
      _formData['client'] = budget.client.name;
      _formData['cod'] = budget.client.cod;
      _formData['price'] = budget.price.toStringAsFixed(2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(budget.title != '' ? budget.title : 'Novo Orçamento'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => _saveBudget(budget),
          ),
          if (_isEditing)
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: _deleteBudget,
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              if (status == BudgetFormStatus.description)
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: TextFormField(
                            initialValue: budget.title,
                            decoration: InputDecoration(
                              labelText: 'Título',
                            ),
                            textInputAction: TextInputAction.next,
                            onChanged: (value) => budget.title = value,
                            onFieldSubmitted: (value) {
                              FocusScope.of(context)
                                  .requestFocus(_priceFocusNode);
                            },
                            onSaved: (value) => budget.title = value,
                            validator: (value) {
                              bool isEmpty = value.trim().isEmpty;
                              bool isInvalid = value.length < 3;
                              if (isInvalid || isEmpty) {
                                return 'Informe um título com no mínimo 3 caracteres!';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        SizedBox(
                          width: 100,
                          child: TextFormField(
                            initialValue: budget.price == null
                                ? ''
                                : budget.price.toString(),
                            onChanged: (value) => budget.price =
                                double.tryParse(value.replaceAll(',', '.')),
                            focusNode: _priceFocusNode,
                            decoration: InputDecoration(
                              labelText: 'Preço',
                            ),
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_clientFocusNode);
                            },
                            onSaved: (value) => budget.price =
                                double.tryParse(value.replaceAll(',', '.')),
                            textInputAction: TextInputAction.next,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            validator: (value) {
                              bool isEmpty = value.trim().isEmpty;
                              var newPrice =
                                  double.tryParse(value.replaceAll(',', '.'));
                              bool isInvalid =
                                  newPrice == null || newPrice <= 0;
                              if (isInvalid || isEmpty) {
                                return 'Informe um preço válido';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                      initialValue: budget.client.name,
                      onChanged: (value) => budget.client.name = value,
                      decoration: InputDecoration(
                        labelText: 'Cliente',
                      ),
                      focusNode: _clientFocusNode,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_codFocusNode);
                      },
                      onSaved: (value) => budget.client.name = value,
                      validator: (value) {
                        bool isEmpty = value.trim().isEmpty;
                        if (isEmpty) {
                          return 'Informe um cliente!';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: budget.client.cod,
                      onChanged: (value) => budget.client.cod = value,
                      decoration: InputDecoration(
                        labelText: 'CPF / CNPJ',
                      ),
                      focusNode: _codFocusNode,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_materialsAndToolsFocusNode);
                      },
                      onSaved: (value) => budget.client.cod = value,
                      validator: (value) {
                        bool isEmpty = value.trim().isEmpty;
                        if (isEmpty) {
                          return 'Informe um CPF / CNPJ!';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: budget.materialsAndTools,
                      maxLines: 2,
                      onChanged: (value) => budget.materialsAndTools = value,
                      decoration: InputDecoration(
                        labelText: 'Materiais e Ferramentas',
                      ),
                      focusNode: _materialsAndToolsFocusNode,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        setState(() {
                          status = BudgetFormStatus.adding_items;
                        });
                      },
                      onSaved: (value) => budget.client.name = value,
                      validator: (value) {
                        bool isEmpty = value.trim().isEmpty;
                        if (isEmpty) {
                          return 'Informe os detalhes de material e equipamentos!';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              if (status == BudgetFormStatus.adding_items)
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: TextField(
                            key: UniqueKey(),
                            maxLines: 2,
                            focusNode: _serviceFocusNode,
                            controller: _budgetServiceController,
                            decoration: InputDecoration(
                              labelText: 'Serviço',
                            ),
                            textInputAction: TextInputAction.next,
                            onSubmitted: (value) {
                              if (_budgetServiceController.text.isNotEmpty)
                                setState(() {
                                  budget.items.add((BudgetItemModel(
                                      id: Random().nextDouble().toString(),
                                      title: _budgetServiceController.text)));
                                  _budgetServiceController.text = '';
                                });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        SizedBox(
                          width: 100,
                          child: FlatButton(
                            child: Text('Adicionar'),
                            onPressed: () {
                              if (_budgetServiceController.text.isNotEmpty)
                                setState(() {
                                  budget.items.add((BudgetItemModel(
                                      id: Random().nextDouble().toString(),
                                      title: _budgetServiceController.text)));
                                  _budgetServiceController.text = '';
                                });
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      height: 360,
                      child: ListView.builder(
                          itemCount: budget.items.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      String.fromCharCode(0x2022) + '  ',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Expanded(
                                      child: Text(
                                        budget.items[index].title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    Container(
                                      height: 15,
                                      child: FlatButton(
                                          onPressed: () {
                                            setState(() {
                                              budget.items.removeWhere((item) =>
                                                  item.id ==
                                                  budget.items[index].id);
                                            });
                                          },
                                          child: Text(
                                            'Remover',
                                            style: TextStyle(color: Colors.red),
                                          )),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              if (status == BudgetFormStatus.adding_payments)
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: TextField(
                            key: UniqueKey(),
                            maxLines: 2,
                            focusNode: _paymentFocusNode,
                            decoration: InputDecoration(
                              labelText: 'Formas de Pagamento',
                            ),
                            textInputAction: TextInputAction.next,
                            controller: _budgetPaymentController,
                            onSubmitted: (_) {
                              setState(() {
                                if (_budgetPaymentController.text.isNotEmpty)
                                  setState(() {
                                    budget.payments.add(
                                      (PaymentItemModel(
                                          date: DateTime.now(),
                                          id: Random().nextDouble().toString(),
                                          description:
                                              _budgetPaymentController.text)),
                                    );
                                    _budgetPaymentController.text = '';
                                  });
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        SizedBox(
                          width: 100,
                          child: FlatButton(
                            child: Text('Adicionar'),
                            onPressed: () {
                              setState(() {
                                budget.payments.add(
                                  (PaymentItemModel(
                                      date: DateTime.now(),
                                      id: Random().nextDouble().toString(),
                                      description:
                                          _budgetPaymentController.text)),
                                );
                                _budgetPaymentController.text = '';
                              });
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      height: 350,
                      child: ListView.builder(
                          itemCount: budget.payments.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      String.fromCharCode(0x2022) + '  ',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Expanded(
                                      child: Text(
                                        budget.payments[index].description,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 15,
                                      child: FlatButton(
                                          onPressed: () {
                                            setState(() {
                                              budget.payments.removeWhere(
                                                  (payment) =>
                                                      payment.id ==
                                                      budget
                                                          .payments[index].id);
                                            });
                                          },
                                          child: Text(
                                            'Remover',
                                            style: TextStyle(color: Colors.red),
                                          )),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              Spacer(),
              BudgetFloatingButtons(status, onNavigateBack, onNavigateNext)
            ],
          ),
        ),
      ),
    );
  }
}

enum BudgetFormStatus {
  description,
  adding_items,
  adding_payments,
}
