import 'dart:io';
import 'package:empreiteiraApp/models/budget_model.dart';
import 'package:empreiteiraApp/shared/utils/app_routes.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_extend/share_extend.dart';

class BudgetListItemWidget extends StatelessWidget {
  final BudgetModel budget;

  BudgetListItemWidget(this.budget);

  void generatePdf() async {
    final doc = pw.Document();

    final PdfImage logo = PdfImage.file(
      doc.document,
      bytes: (await rootBundle.load('assets/images/logo.png'))
          .buffer
          .asUint8List(),
    );

    var apresentacao =
        "Com ampla experiência, a EMPREITEIRA PAULA SJ LTDA dispõe de vasto conhecimento em construções e reformas em geral. Estamos no mercado da Construção Civil há 23 anos, prestando serviços com dedicação, compromisso e qualidade. Para isso, contamos com uma equipe de diversos profissionais qualificados.\n\n Fornecemos mão de obra para construção e reformas em geral. Utilizamos dos mais modernos equipamentos para realizar nossos serviços. Entre os nossos principais parceiros estão: HAP Engenharia, Senko Construtora, SGO Construções, Tenac Engenharia, Banco Mercantil do Brasil.";

    var budgetItems = budget.items.map((item) {
      return pw.Bullet(text: item.title);
    }).toList();

    var paymentItems = budget.payments.map((item) {
      return pw.Bullet(text: item.description);
    }).toList();

    doc.addPage(
      pw.MultiPage(build: (pw.Context context) {
        return <pw.Widget>[
          pw.Row(children: <pw.Widget>[
            // pw.Container(
            //   width: 250,
            //   height: 200,
            //   child: pw.Image(logo),
            // ),
            pw.Container(
              alignment: pw.Alignment.topLeft,
              height: 72,
              child: logo != null ? pw.Image(logo) : pw.PdfLogo(),
            ),
            pw.Spacer(),
            pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: <pw.Widget>[
                  pw.Text('CNPJ:10.253.958/0001-48'),
                  pw.Text('Insc. Municipal: 720535410'),
                  pw.Text('Telefone: +55 31 9 9576 8733'),
                  pw.Text('e-mail: empreiteirapaula@hotmail.com'),
                ])
          ]),
          pw.SizedBox(height: 10),
          pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.end,
              children: <pw.Widget>[
                pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: <pw.Widget>[
                      pw.Text(
                        'Data: ' +
                            DateFormat('dd').format(budget.date) +
                            ' de ' +
                            DateFormat('MMM').format(budget.date) +
                            ' de ' +
                            DateFormat('yyyy').format(budget.date),
                      ),
                      pw.SizedBox(height: 10),
                      pw.Text('Orçamento para:',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text(budget.client.name),
                      pw.Text(budget.client.cod),
                    ]),
              ]),
          pw.Header(
              level: 2,
              child: pw.Text('1. Apresentação',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
          pw.Paragraph(textAlign: pw.TextAlign.left, text: apresentacao),
          pw.Header(
              level: 2,
              child: pw.Text('2. Escopo de serviços',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
          ...budgetItems,
          pw.Header(
              level: 2,
              child: pw.Text('3. Material e ferramentas',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
          pw.Header(
              level: 2,
              child: pw.Text('4. Preço e condições de pagamento',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
          pw.Paragraph(
              textAlign: pw.TextAlign.left,
              text:
                  'O valor para execução dos serviços é R\$${budget.price.toStringAsFixed(2).replaceAll('.', ',')} (onze mil e quinhentos reais) que poderá ser pago da seguinte forma:'),
          ...paymentItems
        ];
      }),
    );

    final title = budget.title.replaceAll(' ', '_');
    final String dir = (await getApplicationDocumentsDirectory()).path;
    final String path = '$dir/$title.pdf';
    final File file = File(path);
    await file.writeAsBytes(doc.save());

    ShareExtend.share('$dir/$title.pdf', "file");
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
          width: 80,
          child:
              FittedBox(child: Text('R\$ ${budget.price.toStringAsFixed(2)}'))),
      title: Text(budget.title, overflow: TextOverflow.clip),
      subtitle: Text(DateFormat('dd/MM/yyyy').format(budget.date)),
      onTap: () => {
        Navigator.of(context).pushNamed(AppRoutes.BUDGET, arguments: budget)
      },
      trailing: IconButton(icon: Icon(Icons.share), onPressed: generatePdf),
    );
  }
}
