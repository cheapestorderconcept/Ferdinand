class SingleProductDetailsModel {
  num? statusCode;
  String? responseMessage;
  Data? data;

  SingleProductDetailsModel({this.statusCode, this.responseMessage, this.data});

  SingleProductDetailsModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    responseMessage = json['response_message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['response_message'] = this.responseMessage;
    if (this.data != null) {
      data[' data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Product? product;

  Data({this.product});

  Data.fromJson(Map<String, dynamic> json) {
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

class Product {
  String? sId;
  String? productName;
  num? views;
  bool? isLiked;
  String? aboutProduct;
  num? vat;
  List<ProductVariants>? productVariants;
  String? productDescription;
  num? productQuantity;
  String? productPictures;

  Product(
      {this.sId,
      this.productName,
      this.views,
      this.isLiked,
      this.aboutProduct,
      this.vat,
      this.productVariants,
      this.productDescription,
      this.productQuantity,
      this.productPictures});

  Product.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productName = json['product_name'];
    views = json['views'];
    isLiked = json['isLiked'];
    aboutProduct = json['about_product'];
    vat = json['vat'];
    if (json['product_variants'] != null) {
      productVariants = <ProductVariants>[];
      json['product_variants'].forEach((v) {
        productVariants!.add(new ProductVariants.fromJson(v));
      });
    }
    productDescription = json['product_description'];
    productQuantity = json['product_quantity'];
    productPictures = json['product_pictures'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['product_name'] = this.productName;
    data['views'] = this.views;
    data['isLiked'] = this.isLiked;
    data['about_product'] = this.aboutProduct;
    data['vat'] = this.vat;
    if (this.productVariants != null) {
      data['product_variants'] =
          this.productVariants!.map((v) => v.toJson()).toList();
    }
    data['product_description'] = this.productDescription;
    data['product_quantity'] = this.productQuantity;
    data['product_pictures'] = this.productPictures;
    return data;
  }
}

class ProductVariants {
  String? name;
  num? price;
  num? priceWithVat;

  ProductVariants({this.name, this.price, this.priceWithVat});

  ProductVariants.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    priceWithVat = json['priceWithVat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['price'] = this.price;
    data['priceWithVat'] = this.priceWithVat;
    return data;
  }
}
