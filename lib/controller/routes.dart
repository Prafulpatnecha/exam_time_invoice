import 'package:exam_time_invoice/home/product_file/product_page.dart';
import 'package:flutter/material.dart';

import '../home/details_screen/detailpage.dart';
import '../home/home_screen/homepage.dart';
import '../home/pdf_page/pdfscreen.dart';

class RoutesApp
{
  static Map<String, Widget Function(BuildContext)> routes={
    '/':(context)=>const HomePage(),
    '/product':(context)=>const ProductPage(),
    '/detail':(context)=>const DetailPage(),
    '/pdf':(context)=>const PdfPage(),
  };
}