// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:multi_store_app/providers/product_class.dart';

class Wish extends ChangeNotifier {
  final List<Product> _list = [];
  List<Product> get geWishItems => _list;

  int? get count => _list.length;

  Future<void> addWishItem(
    String name,
    double price,
    int qty,
    int qntty,
    List imageUrl,
    String documentId,
    String suppId,
  ) async {
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

  void removeItem(Product product) {
    _list.remove(product);
    notifyListeners();
  }

  void clearWishCart() {
    _list.clear();
    notifyListeners();
  }

  void removeThis(String id) {
    _list.removeWhere((element) => element.documentId == id);
    notifyListeners();
  }
}
