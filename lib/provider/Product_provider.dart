import 'package:flutter/cupertino.dart';

import '../model/productlist.dart';

class AddProductProvider extends ChangeNotifier {
  List<String> color = [];
  List<String> size = [];
  List<String> productImage = [];

  List<String> get myColor => color;

  List<String> get mySize => size;

  set addColor(String p) {
    color.add(p);
    notifyListeners();
  }

  set addImage(String p) {
    productImage.add(p);
    notifyListeners();
  }

  set removeImage(String p) {
    productImage.remove(p);
    notifyListeners();
  }

  set addSize(String p) {
    size.add(p);
    notifyListeners();
  }

  set removeColor(String p) {
    color.remove(p);
    notifyListeners();
  }

  set removeSize(String p) {
    size.remove(p);
    notifyListeners();
  }
}

class ProductListProvider extends ChangeNotifier {
  List<Product>? product = [];

  set setProductList(List<Product>? p) {
    product = p;

    notifyListeners();
  }
}
