class ProductListModel {
  List<Product>? product;

  ProductListModel({this.product});

  ProductListModel.fromJson(Map<String, dynamic> json) {
    if (json['product'] != null) {
      product = <Product>[];
      json['product'].forEach((v) {
        product!.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.product != null) {
      data['product'] = this.product!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  List<ProductVariants>? productVariants;
  String? sId;
  String? productName;
  num? productPrice;
  String? aboutProduct;
  num? vat;
  String? productDescription;
  String? productPictures;

  Product(
      {this.productVariants,
      this.sId,
      this.productName,
      this.productPrice,
      this.aboutProduct,
      this.vat,
      this.productDescription,
      this.productPictures});

  Product.fromJson(Map<String, dynamic> json) {
    if (json['product_variants'] != null) {
      productVariants = <ProductVariants>[];
      json['product_variants'].forEach((v) {
        productVariants!.add(new ProductVariants.fromJson(v));
      });
    }
    sId = json['_id'];
    productName = json['product_name'];
    productPrice = json['product_price'];
    aboutProduct = json['about_product'];
    vat = json['vat'];
    productDescription = json['product_description'];
    productPictures = json['product_pictures'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.productVariants != null) {
      data['product_variants'] =
          this.productVariants!.map((v) => v.toJson()).toList();
    }
    data['_id'] = this.sId;
    data['product_name'] = this.productName;
    data['product_price'] = this.productPrice;
    data['about_product'] = this.aboutProduct;
    data['vat'] = this.vat;
    data['product_description'] = this.productDescription;
    data[' product_pictures'] = this.productPictures;
    return data;
  }
}

class ProductVariants {
  String? name;
  num? price;

  ProductVariants({this.name, this.price});

  ProductVariants.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['price'] = price;
    return data;
  }
}
