import 'package:flutter/material.dart';
import 'package:products/providers/product_provider.dart';
import 'package:products/view/product_details.dart';
import 'package:products/view/rearrange_product.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    final providerobj = Provider.of<ProductProvider>(context);
    providerobj.fetchCategories();
    return Scaffold(
      floatingActionButton: Container(
        width: 150,
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          child: const Text("Rearrange Product",style: TextStyle(
              fontWeight: FontWeight.bold
          ),),
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  RearrangeProduct()),
            );
          },
        ),
      ),
      appBar: AppBar(
        title: const Text("Products"),
        centerTitle: true,
      ),
      body: ListView.separated(
          itemBuilder: (context, index){
            var prod = providerobj.category[index];
            return InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  ProductDetails(
                      product:prod.name
                  )),
                );
              },
              child: Container(
                margin: EdgeInsets.all(10),
                child: Text(prod.name),
              ),
            );
          },
          separatorBuilder: (context, index){
            return Divider();
          },
          itemCount: providerobj.category.length
      ),
    );
  }
}
