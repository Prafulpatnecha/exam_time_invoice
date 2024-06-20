import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:exam_time_invoice/utils/globle_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_extend/share_extend.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Detail Page'),
      ),
      body: RepaintBoundary(
        key: globalKey,
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(height: 30,),
              CircleAvatar(
                radius: 80,
                backgroundImage:
                    FileImage(listInvoiceData[selectindex].fileImage!),
              ),
              const SizedBox(
                height: 20,
              ),
              Table(
                border: TableBorder.all(color: Colors.blue),
                children: [
                  const TableRow(children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        '',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Product Details',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ]),
                  buildTableRow(
                      textDetailFind: 'Product Name',
                      textDetails:
                          listInvoiceData[selectindex].txtProductName!.text),
                  buildTableRow(
                      textDetailFind: 'Product Price',
                      textDetails: listInvoiceData[selectindex].txtPrice!.text),
                  buildTableRow(
                      textDetailFind: 'Product Gst',
                      textDetails: listInvoiceData[selectindex].txtGst!.text),
                  buildTableRow(
                      textDetailFind: 'Product Description',
                      textDetails:
                          listInvoiceData[selectindex].txtDescription!.text),
                  buildTableRow(
                      textDetailFind: 'Bill Total',
                      textDetails:
                          '${double.parse(listInvoiceData[selectindex].txtPrice!.text) / 100 * double.parse(listInvoiceData[selectindex].txtGst!.text)}'),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: () async {
              RenderRepaintBoundary boundary = globalKey.currentContext!
                  .findRenderObject() as RenderRepaintBoundary;
              ui.Image imageUi = await boundary.toImage();
              ByteData? byteData =
                  await imageUi.toByteData(format: ui.ImageByteFormat.png);
              Uint8List img = byteData!.buffer.asUint8List();
              ImageGallerySaver.saveImage(img);
            },
            child: const Icon(Icons.download),
          ),
          FloatingActionButton(
            onPressed: () async {
              RenderRepaintBoundary boundary = globalKey.currentContext!
                  .findRenderObject() as RenderRepaintBoundary;
              ui.Image imageUi = await boundary.toImage();
              ByteData? byteData =
                  await imageUi.toByteData(format: ui.ImageByteFormat.png);
              Uint8List img = byteData!.buffer.asUint8List();
              var path=await getApplicationDocumentsDirectory();
              File file= File('${path.path}/image.png');
              file.writeAsBytes(img);
              ShareExtend.share(file.path, 'image');
              // ImageGallerySaver.saveImage(img);
            },
            child: const Icon(Icons.share),
          ),
          FloatingActionButton(onPressed: () {
            Navigator.of(context).pushNamed('/pdf');
          },child: const Icon(Icons.picture_as_pdf),)
        ],
      ),
    );
  }

}
  TableRow buildTableRow(
      {required String textDetailFind, required String textDetails}) {
    return TableRow(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          textDetailFind,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          textDetails,
        ),
      ),
    ]);
  }

GlobalKey globalKey = GlobalKey();
