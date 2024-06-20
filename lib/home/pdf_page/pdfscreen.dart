
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
// import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

import '../../utils/globle_values.dart';
// import '../details_screen/detailpage.dart';

class PdfPage extends StatefulWidget {
  const PdfPage({super.key});

  @override
  State<PdfPage> createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PdfPreview(build: (format) => pdfView(),),
    );
  }
}

Future<Uint8List> pdfView()
{
  var pdf=pw.Document();
  var image = pw.MemoryImage(
    File(listInvoiceData[selectindex].fileImage!.path).readAsBytesSync(),
  );
  pdf.addPage(
    pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {

      return
        // [

      pw.Container(
        child: pw.Container(
          color: PdfColors.white,
          child: pw.Column(
            children: [
              pw.SizedBox(height: 30,),
              // pw.CircleAvatar(
              //   radius: 80,
              //   backgroundImage:
              //   FileImage(listInvoiceData[selectindex].fileImage!),
              // ),
              pw.Container(
                height: 300,
                width: 300,
                child: pw.Image(image),
              ),
              pw.SizedBox(
                height: 20,
              ),
              pw.Table(
                border: pw.TableBorder.all(color: PdfColors.blue),
                children: [
                   pw.TableRow(children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8.0),
                      child: pw.Text(
                        '',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                     pw.Padding(
                      padding: const pw.EdgeInsets.all(8.0),
                      child: pw.Text(
                        'Product Details',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                  ]),
                  pw.TableRow(children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8.0),
                      child: pw.Text(
                        'Product Name',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8.0),
                      child: pw.Text(
                        listInvoiceData[selectindex].txtProductName!.text,
                      ),
                    ),
                  ]),
                  // pw.buildTableRow(
                  //     textDetailFind: 'Product Name',
                  //     textDetails:
                  //     listInvoiceData[selectindex].txtProductName!.text),
                  pw.TableRow(children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8.0),
                      child: pw.Text(
                        'Product Price',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8.0),
                      child: pw.Text(
                        listInvoiceData[selectindex].txtPrice!.text,
                      ),
                    ),
                  ]),
                  // pw.buildTableRow(
                  //     textDetailFind: 'Product Price',
                  //     textDetails: ),
                  pw.TableRow(children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8.0),
                      child: pw.Text(
                        'Product Gst',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8.0),
                      child: pw.Text(
                        listInvoiceData[selectindex].txtGst!.text,
                      ),
                    ),
                  ]),
                  // pw.buildTableRow(
                  //     textDetailFind: 'Product Gst',
                  //     textDetails: listInvoiceData[selectindex].txtGst!.text),
                  pw.TableRow(children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8.0),
                      child: pw.Text(
                        'Product Description',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8.0),
                      child: pw.Text(
                        listInvoiceData[selectindex].txtDescription!.text,
                      ),
                    ),
                  ]),
                  // pw.buildTableRow(
                  //     textDetailFind: 'Product Description',
                  //     textDetails:
                  //     ),
                  pw.TableRow(children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8.0),
                      child: pw.Text(
                        'Bill Total',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8.0),
                      child: pw.Text(
                        '${double.parse(listInvoiceData[selectindex].txtPrice!.text) / 100 * double.parse(listInvoiceData[selectindex].txtGst!.text)}',
                      ),
                    ),
                  ]),
                  // pw.buildTableRow(
                  //     textDetailFind: 'Bill Total',
                  //     textDetails:
                  //     ''),
                ],
              ),
            ],
          ),
        ),
      );
      // ];
    }
    ),
  );
  return pdf.save();
}
