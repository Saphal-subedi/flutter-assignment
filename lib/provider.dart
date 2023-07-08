import 'package:flutter/cupertino.dart';
import 'package:onlinestore/api_model.dart';
import 'package:http/http.dart' as http;

class AlDataList with ChangeNotifier {
  List<ProductModel> allDetails = [];

  bool isSearchPerformed = false;
  bool isLoading = false;
  List<ProductModel> filteredDetails = [];
  final url = "https://fakestoreapi.com/products";
  Future<List<ProductModel>> getAllProduct() async {
    isLoading = true;
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final data = productModelFromJson(response.body);
    allDetails = data;
    isLoading = false;
    notifyListeners();
    return data;
  }

  onSearch(String text) {
    if (text.isEmpty) {
      filteredDetails = [
        ...allDetails
      ]; // Show all products if the search text is empty
      isSearchPerformed = false;
    } else {
      filteredDetails = allDetails
          .where((element) =>
              element.title.toLowerCase().contains(text.toLowerCase()))
          .toList(); // Filter products based on the search text
      isSearchPerformed = true;
    }
    notifyListeners();
  }
}
