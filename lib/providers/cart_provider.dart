// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:multi_store_app/providers/product_class.dart';

class Cart extends ChangeNotifier {
  final List<Product> _list = [];
  List<Product> get getItems => _list;

  double get totalPrice {
    var total = 0.0;
    final result = _list.fold<double>(
        total, (previousValue, element) => previousValue + element.price);

    return result;
  }

  int? get count => _list.length;

  void addItem(
    String name,
    double price,
    int qty,
    int qntty,
    List imageUrl,
    String documentId,
    String suppId,
  ) {
    final product = Product(
        name: name,
        price: price,
        qty: qty,
        qntty: qntty,
        imageUrl: imageUrl,
        documentId: documentId,
        suppId: suppId);
    _list.add(product);

    notifyListeners();
  }

  void increment(Product product) {
    product.increase();
    notifyListeners();
  }

  void decrement(Product product) {
    product.decrease();
    notifyListeners();
  }

  void removeItem(Product product) {
    _list.remove(product);
    notifyListeners();
  }

  void clearCart() {
    _list.clear();
    notifyListeners();
  }
}
