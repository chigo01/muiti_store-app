import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/widgets/components/stream_body.dart';

class AccessoriesGalleryScreen extends StatefulWidget {
  const AccessoriesGalleryScreen({Key? key}) : super(key: key);

  @override
  State<AccessoriesGalleryScreen> createState() => _MenGalleryScreenState();
}

class _MenGalleryScreenState extends State<AccessoriesGalleryScreen> {
  final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance
      .collection('products')
      .where('maincateg', isEqualTo: 'accessories')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBody(productsStream: _productsStream);
  }
}
