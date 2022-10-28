import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/widgets/components/stream_body.dart';

class BagsGalleryScreen extends StatefulWidget {
  const BagsGalleryScreen({Key? key}) : super(key: key);

  @override
  State<BagsGalleryScreen> createState() => _MenGalleryScreenState();
}

class _MenGalleryScreenState extends State<BagsGalleryScreen> {
  final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance
      .collection('products')
      .where('maincateg', isEqualTo: 'bags')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBody(productsStream: _productsStream);
  }
}
