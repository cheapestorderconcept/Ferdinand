import 'package:flutter/material.dart';
import '../model/productlist.dart';

class AddProductProviderAdmin extends ChangeNotifier {
  final Map<String, ProductVariants> _variants = {};
  Map<String, ProductVariants> get productVariants => _variants;
  addVariant(ProductVariants variant) {
    _variants.putIfAbsent('${variant.name}', () => variant);
    notifyListeners();
  }

  removeVariant(String variantName) {
    _variants.remove(variantName);
    notifyListeners();
  }
}
