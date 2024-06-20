import 'dart:io';

import 'package:exam_time_invoice/utils/globle_values.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return Form(
      key: formKey,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('Invoice Generator',style: TextStyle(color: Colors.white),),
          centerTitle: true,
        ),
        body: SizedBox(
          height: height,
          width: width,
          child: ListView.builder(itemCount: listInvoiceData.length,
            itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                // height: 100,
                // width: 50,
                color: Colors.blue.shade100,
                child: ListTile(
                  title: Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          XFile? xfileImage=await imagePicker.pickImage(source: ImageSource.gallery);
                          setState(() {
                            listInvoiceData[index].fileImage=File(xfileImage!.path);
                          });
                        },
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: (listInvoiceData[index].fileImage!=null)?FileImage(listInvoiceData[index].fileImage!):null,
                        ),
                      ),
                      const SizedBox(height: 20,),
                      buildTextFormField(textFind: const Text('Product Name'), maxLengthFind: 20, textInputTypeFind: TextInputType.text, controllerFind: listInvoiceData[index].txtProductName!, maxLinesFind: null),
                      buildTextFormField(textFind: const Text('Product Price'), maxLengthFind: 10, textInputTypeFind: TextInputType.number, controllerFind: listInvoiceData[index].txtPrice!, maxLinesFind: null),
                      buildTextFormField(textFind: const Text('Product Gst%'), maxLengthFind: 2, textInputTypeFind: TextInputType.number, controllerFind: listInvoiceData[index].txtGst!, maxLinesFind: null),
                      buildTextFormField(textFind: const Text('Product Description'), maxLengthFind: 100, textInputTypeFind: TextInputType.text, controllerFind: listInvoiceData[index].txtDescription!, maxLinesFind: 3),
                    ],
                  ),
                  subtitle: Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            listInvoiceData.removeAt(index);
                          });
                        },
                        icon:const Icon(Icons.delete_forever_outlined),)
                    ],
                  ),
                ),
              ),
            );
          },),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(onPressed: () {
              setState(() {
                check=0;
                bool boolValue=formKey.currentState!.validate();
                for(int i=0;i<listInvoiceData.length;i++)
                  {
                    if(listInvoiceData[i].fileImage==null)
                      {
                        check++;
                      }
                  }
                if(listInvoiceData.isNotEmpty)
                  {
                if(check==0)
                  {
                  if(boolValue)
                    {
                      Navigator.of(context).pushNamed('/product');
                    }
                  }
                else{
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Image Most be Required')));
                }
                  }
                else
                  {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Product Add Most be Required')));
                  }
              });
            },child: const Icon(Icons.production_quantity_limits),),
            const SizedBox(width: 50,),
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  TextEditingController txtProductName=TextEditingController();
                  TextEditingController txtPrice=TextEditingController();
                  TextEditingController txtGst=TextEditingController();
                  TextEditingController txtDescription=TextEditingController();
                  File? fileImage;
                  listInvoiceData.add(ListInvoice(fileImage: fileImage,txtDescription: txtDescription,txtGst: txtGst,txtPrice: txtPrice,txtProductName: txtProductName));
                });
              },
              child: const Icon(Icons.add_box_outlined),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField buildTextFormField({required Text textFind,required int maxLengthFind,required TextInputType textInputTypeFind,required TextEditingController controllerFind,required dynamic maxLinesFind}) {
    return TextFormField(
      validator: (value) {
        if(value!.isEmpty)
          {
            return 'Field Must Be Required';
          }
        return null;
      },
      controller: controllerFind,
      maxLength: maxLengthFind,
      maxLines: maxLinesFind,
      keyboardType: textInputTypeFind,
      decoration: InputDecoration(
        border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
        label: textFind,
      ),
    );
  }
}
TextEditingController txtProductName=TextEditingController();
TextEditingController txtPrice=TextEditingController();
TextEditingController txtGst=TextEditingController();
TextEditingController txtDescription=TextEditingController();
int check=0;
File? fileImage;
