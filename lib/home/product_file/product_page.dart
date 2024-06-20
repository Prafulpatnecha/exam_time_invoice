import 'package:exam_time_invoice/utils/globle_values.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Product Page',style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: SizedBox(
        child: (valueFindBool==true)?ListView.builder(
          itemCount: listInvoiceData.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  selectindex=index;
                  Navigator.of(context).pushNamed('/detail');
                },
                child: Container(
                  color: Colors.blue.shade100,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundImage: FileImage(listInvoiceData[index].fileImage!),
                    ),
                    title: Text(listInvoiceData[index].txtProductName!.text.toUpperCase(),style: const TextStyle(fontWeight: FontWeight.bold),),
                    trailing: Text(listInvoiceData[index].txtPrice!.text),
                    subtitle: Row(
                      children: [
                        Text('${listInvoiceData[index].txtGst!.text}%'),
                        IconButton(onPressed: () {
                          setState(() {
                            listInvoiceData.removeAt(index);
                          });
                        }, icon: const Icon(Icons.delete_forever_outlined)),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ):Column(
          children: [
            RangeSlider(
              divisions: 20,
              min: 0,
              max: 100000000,
              labels: RangeLabels(
                statRange.toInt().toString(),endRange.toInt().toString(),
              ),
                values: RangeValues(statRange,endRange), onChanged: (value) {
                setState(() {
                  statRange=value.start;
                  endRange=value.end;
                });
                },),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if(valueFindBool==true)
              {
                valueFindBool=false;
              }
            else{
              valueFindBool=true;
            }
          });
        },child: (valueFindBool==true)?const Icon(Icons.find_replace_sharp):const Icon(Icons.arrow_back),
      )
    );
  }
}
bool valueFindBool=true;
TextEditingController? textControllerFind;
double statRange=0;
double endRange=1000;