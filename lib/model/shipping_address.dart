class ShippingAddressModel {
  ShippingAddress? shippingAddress;

  ShippingAddressModel({shippingAddress});

  ShippingAddressModel.fromJson(Map<String, dynamic> json) {
    shippingAddress = json['shippingAddress'] != null
        ? ShippingAddress.fromJson(json['shippingAddress'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (shippingAddress != null) {
      data['shippingAddress'] = shippingAddress!.toJson();
    }
    return data;
  }
}

class ShippingAddress {
  String? sId;
  String? phoneNumber;
  String? firstName;
  String? lastName;
  String? address;
  String? region;
  String? user;
  String? zipCode;
  String? createdAt;
  String? updatedAt;

  ShippingAddress(
      {sId,
      phoneNumber,
      firstName,
      lastName,
      address,
      region,
      zipCode,
      user,
      createdAt,
      updatedAt});

  ShippingAddress.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    phoneNumber = json['phone_number'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    address = json['address'];
    region = json['land_region'];
    zipCode = json["zip_code"];
    user = json['user'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['phone_number'] = phoneNumber;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['address'] = address;
    data['region'] = region;
    data['user'] = user;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
