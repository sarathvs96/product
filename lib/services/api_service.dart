import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:products/models/catagories.dart';
import '../models/products.dart';

class ApiService {

  Future<List<Products>?> fetchProducts(String? cat) async {
    final response =await http.get(Uri.parse('https://dummyjson.com/products/category/$cat'));
    if (response.statusCode == 200) {
      var getProductData = json.decode(response.body.toString());
      var data=RespMain.fromJson(getProductData);
      var listProducts = data.products;
      return listProducts;
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/products/categories'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<Category> list =[];
      for(var u in data){
        list.add(Category(name: u));
      }
      return list;
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
