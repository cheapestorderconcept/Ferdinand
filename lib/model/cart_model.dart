class CartModel {
  String? productName;
  num? productQty;
  String? productId;
  String? selectedGram;
  String? image;
  num? totalPrice;
  num? itemPrice;
  num? vat;
  String? itemId;
  num? productVat;
  String? productType;

  CartModel(
      {this.productId,
      this.productName,
      this.productVat,
      this.itemPrice,
      this.productQty,
      this.productType,
      this.totalPrice,
      this.vat,
      this.image,
      this.itemId,
      this.selectedGram});

  CartModel.fromJson(Map<String, dynamic> json) {
    productId = json["product_id"];
    image = json["image"];
    vat = json["vat"];
    productVat = json["vat"];
    productType = json["product_type"];
    itemPrice = json["item_price"];
    productName = json["product_name"];
    productQty = json["qty"];
    totalPrice = json["product_price"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["product_id"] = productId;
    data["qty"] = productQty;
    data["vat"] = vat;
    data["vat"] = productVat;
    data["product_type"] = productType;
    data["image"] = image;
    data["item_price"] = itemPrice;
    data["product_name"] = productName;
    data["product_price"] = totalPrice;

    return data;
  }
}
