import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
int selectindex=0;
GlobalKey<FormState> formKey=GlobalKey();
ImagePicker imagePicker=ImagePicker();
List<ListInvoice> listInvoiceData=[];

class ListInvoice
{
  TextEditingController? txtProductName;
  TextEditingController? txtPrice;
  TextEditingController? txtGst;
  TextEditingController? txtDescription;
  File? fileImage;
  ListInvoice(
      {this.fileImage,
      this.txtDescription,
      this.txtGst,
      this.txtPrice,
      this.txtProductName});
}