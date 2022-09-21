import 'package:flutter/foundation.dart';
import '../model/cart_model.dart';

class CartProvider extends ChangeNotifier {
  Map<String, CartModel> _items = {};
  int _productQty = 0;
  num price = 0;
  num totalQty = 0;
  bool is10x500g = false;
  int get qty => _productQty;
  num get totalQtyPurchases => totalQty;
  num get myProductPrice => price;
  increseQty() {
    _productQty += 1;
    notifyListeners();
  }

  set set10x500g(bool value) {
    is10x500g = value;
    notifyListeners();
  }

  set productPrice(num myprice) {
    price = myprice;
    notifyListeners();
  }

  set resetQty(int qty) {
    _productQty = qty;
    notifyListeners();
  }

  decreaseQty() {
    if (_productQty > 1) {
      _productQty -= 1;
    }
    notifyListeners();
  }

  set qtyPurchased(int q) {
    totalQty += q;
    notifyListeners();
  }

  set clearCart(Map<String, CartModel> items) {
    _items = {};
    totalQty = 0;
    notifyListeners();
  }

  //get all items in cart
  Map<String, CartModel> get item {
    return {..._items};
  }

  num get totalAmount {
    num total = 0;
    _items.forEach((key, value) {
      total += value.totalPrice!;
    });
    return total;
  }

//generate a unique ID for each item in cart

  get totalItems => _items.length;
//add items to cart
  set addItems(CartModel item) {
    if (_items.containsKey(item.itemId)) {
      _items.update('${item.itemId}', (existingItem) {
        return CartModel(
          productVat: item.productVat,
          vat: item.vat,
          itemPrice: item.itemPrice,
          productId: item.productId,
          productName: existingItem.productName,
          productQty: existingItem.productQty! + 1,
          totalPrice: existingItem.totalPrice,
          image: item.image,
          itemId: existingItem.itemId,
        );
      });
    } else {
      _items.putIfAbsent("${item.itemId}", () {
        return CartModel(
            productVat: item.productVat,
            vat: item.vat,
            itemPrice: item.itemPrice,
            productId: item.productId,
            productName: item.productName,
            productQty: item.productQty,
            totalPrice: item.totalPrice,
            image: item.image,
            itemId: item.itemId);
      });
    }
    notifyListeners();
  }

//increase quanity of item after adding them to cart;

  increaseItemInCartQty(String itemId) {
    if (_items.containsKey(itemId)) {
      _items.update(itemId, (existingItem) {
        return CartModel(
          productVat: existingItem.productVat,
          vat: existingItem.totalPrice! * existingItem.productVat!,
          itemPrice: existingItem.itemPrice,
          productId: existingItem.productId,
          productName: existingItem.productName,
          productQty: existingItem.productQty! + 1,
          totalPrice: existingItem.totalPrice! + (existingItem.itemPrice!),
          image: existingItem.image,
          itemId: existingItem.itemId,
        );
      });
    }
    notifyListeners();
  }

  set decreaseItemInCartQty(String itemId) {
    if (_items.containsKey(itemId)) {
      _items.update(itemId, (existingItem) {
        return CartModel(
          productVat: existingItem.productVat,
          vat: existingItem.totalPrice! * existingItem.productVat!,
          itemPrice: existingItem.itemPrice,
          productId: existingItem.productId,
          productName: existingItem.productName,
          productQty: existingItem.productQty! > 1
              ? existingItem.productQty! - 1
              : existingItem.productQty!,
          totalPrice: existingItem.productQty! > 1
              ? existingItem.totalPrice! - existingItem.itemPrice!
              : existingItem.itemPrice!,
          image: existingItem.image,
          itemId: existingItem.itemId,
        );
      });
    }
    notifyListeners();
  }

  //remove items from cart;
  set removeItems(String? itemId) {
    _items.update('$itemId', (item) {
      totalQty -= item.productQty!;
      if (item.itemId == '10x500g') {
        is10x500g = false;
        notifyListeners();
      }
      return CartModel(itemId: item.itemId);
    });
    _items.remove(itemId);
    notifyListeners();
    print(totalQty);
  }
}
