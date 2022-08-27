import 'package:flutter/cupertino.dart';

import '../model/shipping_address.dart';

class ShippingAddressProvider extends ChangeNotifier {
  ShippingAddress? shippingAddress;

  set userShippingAddress(ShippingAddress? address) {
    shippingAddress = address;
    notifyListeners();
  }
}
