import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/widgets/components/stream_body.dart';

class BeautyGalleryScreen extends StatefulWidget {
  const BeautyGalleryScreen({Key? key}) : super(key: key);

  @override
  State<BeautyGalleryScreen> createState() => _MenGalleryScreenState();
}

class _MenGalleryScreenState extends State<BeautyGalleryScreen> {
  final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance
      .collection('products')
      .where('maincateg', isEqualTo: 'beauty')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBody(productsStream: _productsStream);
  }
}
