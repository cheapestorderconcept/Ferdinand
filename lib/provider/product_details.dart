import 'package:flutter/foundation.dart';

import '../model/singleproduct_details.dart';

class ProductDetailsProvider extends ChangeNotifier {
  SingleProductDetailsModel? _details;
  SingleProductDetailsModel? get product => _details;
  set setproductDetails(SingleProductDetailsModel model) {
    _details = model;
    print(_details!.data!.product?.productName);
    notifyListeners();
    print(_details);
  }
}
