import 'package:flutter/material.dart';
import '../models/catagories.dart';
import '../models/products.dart';
import '../services/api_service.dart';

class ProductProvider extends ChangeNotifier{

  List<Products> _products=[];
  get products => _products;

  List <Category>_category=[];
  get category => _category;

  List<Products> _productList = [];
  List<Products> get productList => _productList;

  ApiService apiService =ApiService();

  Future<void>getProducts(String? search)async{
    apiService.fetchProducts(search).then((value) {
      _products=value!;
      notifyListeners();
    });

  }

  Future<void> fetchCategories() async {
    try {
      _category = await apiService.fetchCategories();
      notifyListeners();
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  String addProductToList(Products newProduct) {
    if (productList.length < 6) {
      productList.add(newProduct);
      notifyListeners();
      return "";
    } else {
      return 'Cannot add more than 6 products.';
    }
  }

  void reorderItems(int oldIndex, int newIndex) {
    if (oldIndex < 0 ||
        oldIndex >= _productList.length ||
        newIndex < 0 ||
        newIndex >= _productList.length) {
      return;
    }

    final Products removedItem = _productList.removeAt(oldIndex);
    _productList.insert(newIndex, removedItem);

    notifyListeners();
  }

}
