class FlashSalesModel {
  List<Product>? product;

  FlashSalesModel({product});

  FlashSalesModel.fromJson(Map<String, dynamic> json) {
    if (json['product'] != null) {
      product = <Product>[];
      json['product'].forEach((v) {
        product!.add(Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (product != null) {
      data['product'] = product!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  String? sId;
  String? productName;
  int? productPrice;
  String? productDescription;
  List<String>? color;
  List<String>? size;
  String? productCategories;
  int? productQuantity;
  List<String>? productPictures;
  bool? flashSales;
  String? createdAt;
  String? updatedAt;

  Product(
      {sId,
      productName,
      productPrice,
      productDescription,
      color,
      size,
      productCategories,
      productQuantity,
      productPictures,
      flashSales,
      createdAt,
      updatedAt});

  Product.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productName = json['product_name'];
    productPrice = json['product_price'];
    productDescription = json['product_description'];
    color = json['color'].cast<String>();
    size = json['size'].cast<String>();
    productCategories = json['product_categories'];
    productQuantity = json['product_quantity'];
    productPictures = json['product_pictures'].cast<String>();
    flashSales = json['flash_sales'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['product_name'] = productName;
    data['product_price'] = productPrice;
    data['product_description'] = productDescription;
    data['color'] = color;
    data['size'] = size;
    data['product_categories'] = productCategories;
    data['product_quantity'] = productQuantity;
    data['product_pictures'] = productPictures;
    data['flash_sales'] = flashSales;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
