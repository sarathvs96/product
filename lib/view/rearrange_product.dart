
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/products.dart';
import '../providers/product_provider.dart';

class RearrangeProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       leading: IconButton(
         icon: const Icon(Icons.arrow_back_ios,color: Colors.black,),
         onPressed: ()=>Navigator.of(context).pop(),
       ),
      ),
      body: Column(
        children: [
          Consumer<ProductProvider>(
            builder: (context, itemsProvider, child) {
              return DottedBorder(
                borderType: BorderType.RRect,
                color: Colors.black,
                dashPattern: const [3, 3],
                strokeWidth: 2,borderPadding: const EdgeInsets.all(10),
                child: Container(
                  height: 300,
                  margin: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                      ),
                      itemCount: itemsProvider.productList.length,
                      itemBuilder: (context, index) {
                        final Products item = itemsProvider.productList[index];
                        return Draggable(
                          data: index,
                          feedback: SizedBox(
                            height: 50,
                            child: Center(child: Image.network(item.thumbnail!)),
                          ),
                          childWhenDragging: Container(),
                          child: DragTarget<int>(
                            builder: (context, candidateData, rejectedData) {
                              return SizedBox(
                                height: 50,
                                child: Center(child: Image.network(item.thumbnail!)),
                              );
                            },
                            onWillAccept: (data) {
                              // Return true if the dragged item should be accepted
                              return data != index;
                            },
                            onAccept: (data) {
                              // Handle the accepted item
                              itemsProvider.reorderItems(data, index);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20,),
          const Column(
            children: [
              Icon(Icons.back_hand,color: Color(0xff003731),size: 30,),
              SizedBox(height: 10,),
              Text("Tap and hold to move items",style: TextStyle(
                color: Color(0xff003731),fontSize: 17
              ),)
            ],
          )
        ],
      ),
    );
  }
}

