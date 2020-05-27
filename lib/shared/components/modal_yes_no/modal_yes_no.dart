import 'package:flutter/material.dart';

class ModalYesNoWidget extends StatelessWidget {
  final String title;
  final String content;

  ModalYesNoWidget({
    @required this.title,
    @required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        FlatButton(
            child: Text('Não'),
            onPressed: () => Navigator.of(context).pop(false)),
        FlatButton(
            child: Text('Sim'),
            onPressed: () => Navigator.of(context).pop(true)),
      ],
    );
  }
}
