class FavoritesListModel {
  List<FavoriteList>? favoriteList;

  FavoritesListModel({favoriteList});

  FavoritesListModel.fromJson(Map<String, dynamic> json) {
    if (json['favoriteList'] != null) {
      favoriteList = <FavoriteList>[];
      json['favoriteList'].forEach((v) {
        favoriteList!.add(FavoriteList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (favoriteList != null) {
      data['favoriteList'] = favoriteList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FavoriteList {
  String? sId;
  Product? product;
  String? user;
  String? createdAt;
  String? updatedAt;

  FavoriteList({sId, product, user, createdAt, updatedAt});

  FavoriteList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
    user = json['user'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    data['user'] = user;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Product {
  List<ProductVariants>? productVariants;
  String? sId;
  String? productName;
  String? aboutProduct;
  num? vat;
  num? productPrice;
  String? productDescription;
  String? productCategories;
  String? productPictures;

  Product(
      {sId,
      vat,
      productName,
      productPrice,
      productVariants,
      productDescription,
      aboutProduct,
      productCategories,
      productPictures});

  Product.fromJson(Map<String, dynamic> json) {
    if (json['product_variants'] != null) {
      productVariants = <ProductVariants>[];
      json['product_variants'].forEach((v) {
        productVariants!.add(ProductVariants.fromJson(v));
      });
    }
    sId = json['_id'];
    vat = json['vat'];
    productName = json['product_name'];
    aboutProduct = json["about_product"];
    productPrice = json['product_price'];
    productDescription = json['product_description'];
    productCategories = json['product_categories'];
    productPictures = json['product_pictures'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['product_name'] = productName;
    data['product_price'] = productPrice;
    data['product_description'] = productDescription;
    data['product_categories'] = productCategories;
    data['product_pictures'] = productPictures;
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
