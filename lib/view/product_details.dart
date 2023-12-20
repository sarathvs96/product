import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';

class ProductDetails extends StatefulWidget {
  late String product;
  ProductDetails({super.key, required this.product});


  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  void showValidationMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),
      ),
    );
  }
  Widget build(BuildContext context) {
    final providerobj1 = Provider.of<ProductProvider>(context);
    providerobj1.getProducts(widget.product);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product,style: const TextStyle(
            fontWeight: FontWeight.bold
        ),),
      ),
      body: ListView.separated(
          itemBuilder: (context, index){
            var prod = providerobj1.products[index];
            // value: prod.selected,
            return ListTile(
              trailing: IconButton(icon: Icon(Icons.add),
              onPressed: (){
                String validationError = providerobj1.addProductToList(prod);
                if (validationError != "") {
                  showValidationMessage(validationError);
                }
              },),
              leading: ClipRRect(
                  child: Container(
                      width: 100,
                      height: 100,
                      child: Image.network(prod.thumbnail))),
              title: Text(prod.title),
            );
          },
          separatorBuilder: (context, index){
            return Divider();
          },
          itemCount: providerobj1.products.length
      ),
    );
  }
}
