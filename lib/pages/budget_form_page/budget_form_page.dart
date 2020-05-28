import 'package:empreiteiraApp/models/budget_item_model.dart';
import 'package:empreiteiraApp/models/budget_model.dart';
import 'package:empreiteiraApp/models/client_model.dart';
import 'package:empreiteiraApp/models/payment_item_model.dart';
import 'package:empreiteiraApp/shared/components/modal_yes_no/modal_yes_no.dart';
import 'package:flutter/material.dart';

import 'components/budget_floating_buttons.dart';

class BudgetFormPage extends StatefulWidget {
  @override
  _BudgetFormScreenState createState() => _BudgetFormScreenState();
}

class _BudgetFormScreenState extends State<BudgetFormPage> {
  final _clientFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();
  final _codFocusNode = FocusNode();
  final _serviceFocusNode = FocusNode();
  final _paymentFocusNode = FocusNode();
  final _formData = Map<String, Object>();
  final _form = GlobalKey<FormState>();
  BudgetFormStatus status = BudgetFormStatus.description;

  bool _isEditing = false;

  void _saveBudget() {
    showDialog(
      context: context,
      builder: (context) {
        return ModalYesNoWidget(
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
        return ModalYesNoWidget(
            title: 'Atenção', content: 'Deseja excluir o orçamento?');
      },
    ).then((value) {
      //IMPLEMENT
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_formData.isEmpty) {
      final budget = ModalRoute.of(context).settings.arguments as BudgetModel;
      if (budget == null) {
        return;
      }
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
    var budget = ModalRoute.of(context).settings.arguments as BudgetModel;
    if (budget == null)
      budget = new BudgetModel(
          title: '',
          price: 0,
          date: DateTime.now(),
          client: new ClientModel(name: '', cod: ''),
          items: new List<BudgetItemModel>(),
          payments: new List<PaymentItemModel>());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(budget.title != '' ? budget.title : 'Novo Orçamento'),
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
      body: Padding(
        padding: const EdgeInsets.all(15),
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
                            initialValue: _formData['title'],
                            decoration: InputDecoration(
                              labelText: 'Título',
                            ),
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_priceFocusNode);
                            },
                            onSaved: (value) => _formData['title'] = value,
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
                            initialValue: _formData['price'] == null
                                ? ''
                                : _formData['price'].toString(),
                            focusNode: _priceFocusNode,
                            decoration: InputDecoration(
                              labelText: 'Preço',
                            ),
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_clientFocusNode);
                            },
                            onSaved: (value) =>
                                _formData['price'] = double.parse(value),
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
                      initialValue: _formData['client'],
                      decoration: InputDecoration(
                        labelText: 'Cliente',
                      ),
                      focusNode: _clientFocusNode,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_codFocusNode);
                      },
                      onSaved: (value) => _formData['client'] = value,
                      validator: (value) {
                        bool isEmpty = value.trim().isEmpty;
                        if (isEmpty) {
                          return 'Informe um cliente!';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _formData['cod'],
                      decoration: InputDecoration(
                        labelText: 'CPF / CNPJ',
                      ),
                      focusNode: _codFocusNode,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        setState(() {
                          status = BudgetFormStatus.adding_items;
                        });
                      },
                      onSaved: (value) => _formData['cod'] = value,
                      validator: (value) {
                        bool isEmpty = value.trim().isEmpty;
                        if (isEmpty) {
                          return 'Informe um CPF / CNPJ!';
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
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: '',
                            maxLines: 2,
                            focusNode: _serviceFocusNode,
                            decoration: InputDecoration(
                              labelText: 'Serviço',
                            ),
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) {},
                            onSaved: (value) => {},
                            validator: (value) {
                              bool isEmpty = value.trim().isEmpty;
                              if (isEmpty) {
                                return 'Informe um serviço';
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
                          child: FlatButton(
                            child: Text('Adicionar'),
                            onPressed: () {},
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      height: 300,
                      child: ListView.builder(
                          itemCount: budget.items.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    String.fromCharCode(0x2022) + '  ',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    budget.items[index].title,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
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
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: '',
                            maxLines: 2,
                            focusNode: _paymentFocusNode,
                            decoration: InputDecoration(
                              labelText: 'Formas de Pagamento',
                            ),
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) {},
                            onSaved: (value) => {},
                            validator: (value) {
                              bool isEmpty = value.trim().isEmpty;
                              if (isEmpty) {
                                return 'Informe uma forma de pagamento';
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
                          child: FlatButton(
                            child: Text('Adicionar'),
                            onPressed: () {},
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      height: 300,
                      child: ListView.builder(
                          itemCount: budget.payments.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    String.fromCharCode(0x2022) + '  ',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    budget.payments[index].description,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
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
