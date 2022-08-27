class ClientOrderModel {
  List<PlacedOrder>? placedOrder;

  ClientOrderModel({placedOrder});

  ClientOrderModel.fromJson(Map<String, dynamic> json) {
    if (json['placedOrder'] != null) {
      placedOrder = <PlacedOrder>[];
      json['placedOrder'].forEach((v) {
        placedOrder!.add(PlacedOrder.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (placedOrder != null) {
      data['placedOrder'] = placedOrder!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PlacedOrder {
  String? sId;
  num? totalPrice;
  String? user;
  String? orderStatus;
  String? trackingNumber;
  String? logisticName;
  String? logisticWebsite;
  String? productName;
  String? productColor;
  String? productImage;
  String? productSize;
  ShippingAddress? shippingAddress;
  int? quantity;

  PlacedOrder(
      {sId,
      totalPrice,
      user,
      orderStatus,
      productName,
      productImage,
      productColor,
      trackingNumber,
      logisticName,
      logisticWebsite,
      productSize,
      shippingAddress,
      quantity});

  PlacedOrder.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    totalPrice = json['total_price'];
    user = json['user'];
    orderStatus = json['order_status'];
    logisticWebsite = json["logistic_website"];
    trackingNumber = json["tracking_number"];
    logisticName = json["logistic_name"];
    productName = json['product_name'];
    productImage = json["product_image"];
    productColor = json['product_color'];
    productSize = json['product_size'];
    shippingAddress = json['shipping_address'] != null
        ? ShippingAddress.fromJson(json['shipping_address'])
        : null;
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['total_price'] = totalPrice;
    data['user'] = user;
    data['order_status'] = orderStatus;
    data['product_name'] = productName;
    data["logistic_name"] = logisticName;
    data["logistic_website"] = logisticWebsite;
    data["tracking_number"] = trackingNumber;
    data["product_image"] = productImage;
    data['product_color'] = productColor;
    data['product_size'] = productSize;
    if (shippingAddress != null) {
      data['shipping_address'] = shippingAddress!.toJson();
    }
    data['quantity'] = quantity;
    return data;
  }
}

class ShippingAddress {
  String? sId;
  String? phoneNumber;
  String? firstName;
  String? lastName;
  String? addressLineOne;
  String? addressLineTwo;
  String? city;
  String? zipCode;
  String? country;
  String? user;

  ShippingAddress(
      {sId,
      phoneNumber,
      firstName,
      lastName,
      addressLineOne,
      addressLineTwo,
      city,
      zipCode,
      country,
      user});

  ShippingAddress.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    phoneNumber = json['phone_number'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    addressLineOne = json['address_line_one'];
    addressLineTwo = json['address_line_two'];
    city = json['city'];
    zipCode = json['zip_code'];
    country = json['country'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['phone_number'] = phoneNumber;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['address_line_one'] = addressLineOne;
    data['address_line_two'] = addressLineTwo;
    data['city'] = city;
    data['zip_code'] = zipCode;
    data['country'] = country;
    data['user'] = user;
    return data;
  }
}
