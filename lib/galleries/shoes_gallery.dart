import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/widgets/components/stream_body.dart';

class ShoesGalleryScreen extends StatefulWidget {
  const ShoesGalleryScreen({Key? key}) : super(key: key);

  @override
  State<ShoesGalleryScreen> createState() => _MenGalleryScreenState();
}

class _MenGalleryScreenState extends State<ShoesGalleryScreen> {
  final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance
      .collection('products')
      .where('maincateg', isEqualTo: 'shoes')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBody(productsStream: _productsStream);
  }
}
